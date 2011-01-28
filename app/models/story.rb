class Story < ActiveRecord::Base
  def self.list_newest_first
    Story.all.sort
  end

  def cycle_time
    return nil if started.nil?
    return nil if finished.nil?
    date_range = started..finished
    date_range.select {|d| d.extend(DateExtensions).workday? }.size
  end

  def <=> other
    return -1 if started.nil?
    return 1 if other.started.nil?
    other.started <=> started
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

