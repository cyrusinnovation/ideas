class Throughput
  SPAN = 20

  def self.history
    oldest_story = Story.first(:order => "finished", :conditions => "finished IS NOT NULL")
    return [] if oldest_story.nil?
    start_date = oldest_story.finished + SPAN
    date_range = start_date..Date.today
    date_range.map { |date|
      Throughput.new date
    }.reverse
  end

  attr_reader :date

  def initialize date
    @date = date
    @start_date = date - SPAN
  end

  def stories
    stories_in_range.size
  end

  def points
    stories_in_range.reduce(0) {|count, story| count + (story.estimate || 0) }
  end

  private

  def stories_in_range
    Story.all :conditions => ["finished >= ? AND finished <= ?", @start_date, @date]
  end
end