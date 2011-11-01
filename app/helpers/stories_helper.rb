module StoriesHelper
  def range_html bucket
    return "up to #{time_text(bucket.max)}" if(bucket.no_min?)

    min = time_text(bucket.min)
    max = time_text(bucket.max)
    
    html = "about #{min}"
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
  
  def bucket_value bucket
    bucket.nil? ? '' : bucket.value
  end
  
  def pretty_print_bucket bucket
    bucket.nil? ? '' : bucket.pretty_print_html
  end
end
