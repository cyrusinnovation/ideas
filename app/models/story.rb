class Story < ActiveRecord::Base
  belongs_to :user
  validates :title, :presence => true
 
  def burn_rate
    return nil if hours_worked.nil?
    return nil if estimate.nil?
    hours_worked / estimate
  end

  def <=> other
    return -1 if title.nil?
    return 1 if other.title.nil?
    other.title <=> title
  end

  def status estimate_groups
    return nil if data_series(estimate_groups).empty?
    difference = variance_vs_mean(estimate_groups)
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end

  def variance_vs_mean estimate_groups
    return nil if data_series(estimate_groups).empty?

    difference = hours_worked - data_series(estimate_groups).mean
    difference.abs < data_series(estimate_groups).standard_deviation ? nil : difference.round
  end

  def data_series estimate_groups
    estimate_groups.data_series(estimate)
  end

end
