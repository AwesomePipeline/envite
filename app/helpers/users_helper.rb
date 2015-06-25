module UsersHelper
  def avatar_class response
    case response
    when :accepted
      'class=accepted'
    when :rejected
      'class=rejected'
    when :no_response
      'class=no-response'
    else
      nil
    end
  end
end
