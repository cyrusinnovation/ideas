class CycleTimeCalculator
  def self.collect story_finder
    result = []
    stories = story_finder.find :all, :conditions => "finished IS NOT NULL", :order => "finished DESC"
    stories.size.downto(1) do |count|
      shorter_stories = stories.last(count)
      result.push CycleTimeCalculator.new(shorter_stories)
    end
    result
  end

  def initialize stories
    @stories = stories
  end

  def story
    @stories.first.title
  end

  def story_points
    @stories.first.estimate
  end

  def started
    @stories.first.started
  end

  def finished
    @stories.first.finished
  end

  def for_story
    @stories.first.cycle_time
  end

  def for_stories goal
    stories = @stories.first(goal)
    return nil if stories.size < goal
    cycle_time(stories)
  end

  def for_points goal
    cycle_time(stories_for_points(goal))
  end

  private

  def cycle_time(stories)
    return nil if stories.nil?
    started = stories.map { |s| s.started }.min
    finished = stories.first.finished
    DateRange.new(started, finished).workdays
  end

  def stories_for_points goal
    count = 0
    list = []
    @stories.each do |s|
      next if s.estimate.nil?
      count += s.estimate
      list.push s
      return list if count >= goal
    end
    nil
  end
end