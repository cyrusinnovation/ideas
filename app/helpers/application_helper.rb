module ApplicationHelper
  def navigation_link controller_name
    title = controller_name.titleize
    html_options = {}
    if @controller.controller_name == controller_name
      html_options[:class] = 'current'
    end
    link_to title, { :controller => controller_name, :action => 'index' }, html_options
  end

  def format_title title
    content_tag 'span', truncate(title, :length => 60), :title => title
  end

  def format_estimate estimate
    return '' if estimate.nil?
    estimate.to_r
  end

  def format_date date
    return "" if date.nil?
    "#{date.month}/#{date.day}/#{date.year}"
  end
end
