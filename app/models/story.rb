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

  def status actuals
    difference = variance_vs_mean(actuals)
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end

  def variance_vs_mean actuals
    difference = hours_worked - actuals.mean
    difference.abs < actuals.standard_deviation ? nil : difference.round
  end

end
