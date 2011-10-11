module EstimationViewHelper
  def range_html bucket
    min = min_html bucket
    max = max_html bucket
    
    html = "About #{min}"
    html += " &ndash; #{max}" if min != max
    html
  end


  def min_html bucket
    hours = current_user.min(bucket)
    time_text hours
  end

  def max_html bucket
    hours = current_user.max(bucket)
    time_text hours
  end

  def time_text hours
    if hours > 16
      days = hours / 8
      "#{days.floor} days"
    else
      pluralize hours.ceil, "hour"
    end
  end
end
