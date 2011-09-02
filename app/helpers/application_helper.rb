module ApplicationHelper
  include GoogleVisualization

  def navigation_link controller_name
    title = controller_name.titleize
    html_options = {}
    if controller.controller_name == controller_name
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

  def format_variance variance
    return nil if variance.nil?
    variance > 0 ? "+#{variance}" : variance
  end

  def to_html data_series
    return nil if data_series.empty?
    '<span title="%.2f &plusmn; %.2f">%.0f &plusmn; %.0f</span>' % [data_series.mean, data_series.standard_deviation, data_series.mean, data_series.standard_deviation]
  end

  def to_html_attribute data_series
    return nil if data_series.empty?
    '%.0f &plusmn; %.0f' % [data_series.mean, data_series.standard_deviation]
  end



end
