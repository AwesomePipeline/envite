module ApplicationHelper
 
  def flash_style(flash_type)
    {"success" => "alert-success",
      "error" => "alert-danger",
      "alert" => "alert-warning",
      "notice" => "alert-info"}[flash_type]
  end
 
  def flash_messages(opts = {})
    flash.each do |flash_type, message|
      concat(content_tag(:div, message, :class => "alert #{flash_style(flash_type)} alert-dismissible", role: :alert) do 
              concat content_tag(:button, "&times;".html_safe, :class => "close", data: { dismiss: 'alert' })
              concat content_tag(:strong, flash_type.capitalize + "!") + " " + message
            end)
    end
    nil
  end
end