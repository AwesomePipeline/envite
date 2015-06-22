module ApplicationHelper
  # Helper function to convert rails flash types to bootstrap flash types
  def flash_style(flash_type)
    {"success" => "alert-success",
      "error" => "alert-danger",
      "alert" => "alert-warning",
      "notice" => "alert-info"}[flash_type]
  end
  
  # Wraps and styles each flash message with bootstrap contextual alerts
  def flash_messages(opts = {})
    flash.each do |flash_type, message|
      concat(content_tag(:div, message, :class => "alert #{flash_style(flash_type)} alert-dismissible", role: :alert) do 
              concat content_tag(:button, "&times;".html_safe, :class => "close", data: { dismiss: 'alert' })
              concat content_tag(:strong, flash_type.capitalize + ':') + ' ' + message
            end)
    end
    nil
  end
  
  # Returns the formatted datetime for display
  def display_datetime(time)
    time.strftime('%l:%M%p, %e %B %:z')
  end
  
  # Returns the relative time in words with timezone correction
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
