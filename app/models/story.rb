class Story < ActiveRecord::Base
  composed_of :date_range, :mapping => [%w(started started), %w(finished finished)]
  belongs_to :user

  def burn_rate
    return nil if hours_worked.nil?
    return nil if estimate.nil?
    hours_worked / estimate
  end

  def <=> other
    return -1 if started.nil?
    return 1 if other.started.nil?
    other.started <=> started
  end
end

class User
  def hours_worked_by_estimate
    DataSeries.by_group(all_with_burn_rates, :group => :estimate) {|s| s.hours_worked }
  end

  def all_with_burn_rates
    stories.where("estimate IS NOT NULL AND hours_worked IS NOT NULL").order("finished DESC")
  end
end
