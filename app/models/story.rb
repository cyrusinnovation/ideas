class Story < ActiveRecord::Base
  belongs_to :team
  composed_of :date_range, :mapping => [%w(started started), %w(finished finished)]

  def self.list_newest_first
    Story.all.sort
  end

  def self.all_with_burn_rates
    all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"
  end

  def self.all_with_cycle_times
    all :conditions => "started IS NOT NULL AND finished IS NOT NULL",
        :order => "finished DESC"
  end

  def self.average_hours_by_estimate
    Average.by_group(all_with_burn_rates, :group => :estimate) {|s| s.hours_worked }
  end

  def self.average_cycle_time_by_estimate
    Average.by_group(all_with_cycle_times, :group => :estimate) {|s| s.cycle_time }
  end

  def team_name
    return nil if team.nil?
    team.name
  end

  def team_name= new_team
    if new_team.nil?
      self.team = nil
    else
      self.team = Team.find_or_create_by_name new_team
    end
  end

  def cycle_time
    date_range.workdays
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
