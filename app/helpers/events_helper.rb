module EventsHelper
  def response_hash notification
    if notification.has_responded?
      if notification.has_accepted?
        return :accepted
      else
        return :rejected
      end
    else
      return :no_response
    end
  end
end
