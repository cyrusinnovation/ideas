module EstimationViewHelper
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
