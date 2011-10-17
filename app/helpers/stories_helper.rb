module StoriesHelper
  def range_html bucket
    return "Up to #{time_text(bucket.max)}" if(bucket.no_min?)
    return "#{time_text(bucket.min)} and up" if(bucket.no_max?)

    min = time_text(bucket.min)
    max = time_text(bucket.max)
    
    html = "About #{min}"
    html += " &ndash; #{max}" if min != max
    html
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
