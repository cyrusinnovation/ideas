class Story < ActiveRecord::Base
  belongs_to :user
  validates :title, :presence => true
  validates_numericality_of :hours_worked, :greater_than => 0
  validates_numericality_of :estimate, :greater_than => 0


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


  def variance_vs_mean actuals
    return nil if hours_worked.nil? || actuals.nil?
    difference = hours_worked - actuals.mean
    difference.abs > actuals.standard_deviation ? difference.round : nil
  end

end
