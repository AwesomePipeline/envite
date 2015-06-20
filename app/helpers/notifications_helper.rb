module NotificationsHelper
  def accept_link_helper notification
    if notification.response == 10
      link_to 'Accepted', '', class: 'btn btn-success active', role: 'button'
    else
      link_to 'Accept', accept_notification_path(notification), class: 'btn btn-success', role: 'button'
    end
  end
  
  def decline_link_helper notification
    if notification.response == 20
      link_to 'Declined', '', class: 'btn btn-danger active', role: 'button'
    else
      link_to 'Decline', decline_notification_path(notification), class: 'btn btn-danger', role: 'button'
    end
  end
end
