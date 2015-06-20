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
end
