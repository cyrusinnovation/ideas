class Story < ActiveRecord::Base
  belongs_to :team
  composed_of :date_range, :mapping => [%w(started started), %w(finished finished)]

  def self.list_newest_first
    Story.all.sort
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

  def <=> other
    return -1 if started.nil?
    return 1 if other.started.nil?
    other.started <=> started
  end
end

class DateRange
  attr_reader :started, :finished

  def initialize started, finished
    @started = started
    @finished = finished
  end

  def workdays
    return nil if started.nil?
    return nil if finished.nil?
    filtered_range.size
  end

  private

  def filtered_range
    date_range = started..finished
    filtered = date_range.select {|d| d.extend(DateExtensions).workday? }
    filtered.unshift(started).push(finished).uniq
  end
end

module DateExtensions
  def workday?
    weekday? && !holiday?()
  end

  def holiday?
    Holiday.holiday?(self)
  end

  def weekday?
    (1..5).include? wday
  end
end

