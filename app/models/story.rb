class Story < ActiveRecord::Base
  composed_of :date_range, :mapping => [%w(started started), %w(finished finished)]

  def self.list_newest_first
    Story.all.sort
  end

  def self.all_with_burn_rates
    all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"
  end

  def self.hours_worked_by_estimate
    DataSeries.by_group(all_with_burn_rates, :group => :estimate) {|s| s.hours_worked }
  end

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
