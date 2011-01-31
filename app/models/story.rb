class Story < ActiveRecord::Base
  composed_of :date_range, :mapping => [%w(started started), %w(finished finished)]

  def self.list_newest_first
    Story.all.sort
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

