module NotificationsHelper
  # ==================== Response Code Explanation ====================
  # Notification.response is an integer field with binary-encoded meanings
  # Bit 0 is 1 by default and cleared when invitation is accepted / rejected
  # Bit 1 indicates acceptance / rejection of an invitation
  # Bit 5 indicates location suggested
  # Bit 6 indicates datetime suggested
  # Bit 7 indicates activity suggested
  # 0b12--_-345
  # 0b: Ruby binary prefix
  # 1: 1 for no response, 0 when invitation has been responded to
  # 2: 0 for reject, 1 for accept, to set OR 0b0100_0000, to unset AND 0b1011_1111
  # 3: 1 for location suggested, to set OR 0b0000_0100
  # 4: 1 for datetime suggested, to set OR 0b0000_0010
  # 5: 1 for activity suggested, to set OR 0b0000_0001
  # -: unused bit location
  
  # Bitmasks for response code
  RESPONDED_MASK  = 0b1000_0000
  ACCEPT_MASK     = 0b0100_0000
  ACTIVITY_MASK   = 0b0000_0001
  DATETIME_MASK   = 0b0000_0010
  LOCATION_MASK   = 0b0000_0100
  
  # Creates the accept / decline buttons
  def accept_link_helper notification
    if response_accepted? notification.response
      link_to 'Accepted', '', 'class' => 'btn btn-success active', role: 'button'
    else
      link_to 'Accept', accept_notification_path(notification), 'class' => 'btn btn-success', role: 'button'
    end
  end
  
  def decline_link_helper notification
    if !response_accepted? notification.response
      link_to 'Declined', '', 'class' => 'btn btn-danger active', role: 'button'
    else
      link_to 'Decline', decline_notification_path(notification), 'class' => 'btn btn-danger', role: 'button'
    end
  end
  
  # Returns true if invitation has been responded to, false if not
  def response_responded_bit? response_code
    response_code & RESPONDED_MASK == 0
  end
  
  # Returns true if accepted bit is 1, false if 0
  # NOTE: Disregards if invitation has actually been responded to
  # SEE: response_accepted?
  def response_accepted_bit? response_code
    response_code & ACCEPT_MASK > 0
  end
  
  # Returns true if invitation has been accepted, false if rejected
  def response_accepted? response_code
    response_responded_bit?(response_code) && response_accepted_bit?(response_code)
  end
  
  # (Un)sets the responded bit, indicating invitation has been responded to
  def set_responded response_code
    response_code &= ~RESPONDED_MASK
  end
  
  # Sets / unsets the responded bit indicating acceptance / rejection of invitation
  def set_response_accept response_code
    response_code = set_responded(response_code)
    response_code |= ACCEPT_MASK
  end
  
  def set_response_reject response_code
    response_code = set_responded(response_code)
    response_code &= ~ACCEPT_MASK
  end
  
  # Sets the activity / datetime / location suggestion bits of response code
  def set_suggest_activity response_code
    response_code |= ACTIVITY_MASK
  end
  
  def set_suggest_datetime response_code
    response_code |= DATETIME_MASK
  end
  
  def set_suggest_location response_code
    response_code |= LOCATION_MASK
  end
  
  # Modifies the response code with the corresponding bitmasks
  def set_response response_code, response_type
    case response_type
    when :accept
      response_code = set_response_accept(response_code)
    when :reject
      response_code = set_response_reject(response_code)
    when :suggest_activity
      response_code = set_suggest_activity(response_code)
    when :suggest_datetime
      response_code = set_suggest_datetime(response_code)
    when :suggest_location
      response_code = set_suggest_location(response_code)
    end
  end
end
