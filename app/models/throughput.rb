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
    count_points_from stories_in_range
  end

  def team_stories team
    stories_for(team).size
  end

  def team_points team
    count_points_from stories_for(team)
  end

  private

  def stories_in_range
    Story.all :conditions => ["finished >= ? AND finished <= ?", @start_date, @date]
  end

  def stories_for team
    stories_in_range.select { |s| s.team == team }
  end

  def count_points_from stories
    stories.reduce(0) {|count, story| count + (story.estimate || 0) }
  end
end