module EstimationViewHelper
  def bucket_display bucket
    return '&frac14;' if bucket == 0.25
    return '&frac12;' if bucket == 0.5
    bucket
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
      "#{hours.ceil} hours"
    end
  end
end
