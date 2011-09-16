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

  def self.well_estimated_stories min, max, count, target
    examples = select("*, abs(hours_worked - #{target}) as quality")
    examples = examples.order('quality asc').limit(count)
    examples = examples.where(["hours_worked >= ?", min])
    examples = examples.where(["hours_worked <= ?", max])
  end

end
