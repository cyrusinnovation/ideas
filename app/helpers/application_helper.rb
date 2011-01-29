module ApplicationHelper
  def navigation_link controller_name
    title = controller_name.capitalize
    html_options = {}
    if @controller.controller_name == controller_name
      html_options[:class] = 'current'
    end
    link_to title, { :controller => controller_name, :action => 'index' }, html_options
  end

  def format_date date
    return "" if date.nil?
    "#{date.month}/#{date.day}/#{date.year}"
  end
end
