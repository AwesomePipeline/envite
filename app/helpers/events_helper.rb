module EventsHelper
  def response_to_string response
    if response == 10
      'Accepted'
    elsif response == 20
      'Declined'
    else
      'Undecided'
    end
  end
  
  def response_hash notification
    if notification.has_responded?
      if notification.has_accepted?
        return :accepted
      else
        return :rejected
      end
    else
      return :no_reponse
    end
  end
end
