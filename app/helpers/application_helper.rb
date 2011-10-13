module ApplicationHelper
  include GoogleVisualization

  def format_title title, length=60
    content_tag 'span', truncate(title, :length => length), :title => title
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

  def page_header page_title
    return "<div class='page-header'><h1>#{page_title}</h1></div>"    
  end
  
  def project_dropdown_title
    return in_project? ? current_project.name : 'Projects'
  end
  
  def project_dropdown_projects
    return in_project? ? (current_user.projects - [current_project]) : current_user.projects
  end
  
end
