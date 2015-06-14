module ApplicationHelper
 
  def flash_style(flash_type)
    {"success" => "alert-success",
      "error" => "alert-danger",
      "alert" => "alert-warning",
      "notice" => "alert-info"}[flash_type]
  end
 
  def flash_messages(opts = {})
    # Style each flash message with bootstrap contextual alerts
    flash.each do |flash_type, message|
      concat(content_tag(:div, message, :class => "alert #{flash_style(flash_type)} alert-dismissible", role: :alert) do 
              concat content_tag(:button, "&times;".html_safe, :class => "close", data: { dismiss: 'alert' })
              concat content_tag(:strong, flash_type.capitalize + ':') + ' ' + message
            end)
    end
    
    # Returns nil
    nil
  end
  
  def relative_word_time(time)
    now = Time.now
    time -= Time.zone_offset(Time.now.zone)
    if time - now > 0
      'in ' + distance_of_time_in_words(time, now)
    elsif now - time > 7.days
      'on ' + l(time, format: :short)
    else
      distance_of_time_in_words(time, now) + ' ago'
    end
  end
end
