class CycleTimeCalculator
  def initialize stories
    @stories = stories
  end

  def story
    @stories.first.title
  end

  def for_points goal
    stories = stories_for_points(goal)
    started = stories.last.started
    finished = stories.first.finished
    DateRange.new(started, finished).workdays
  end

  private

  def stories_for_points goal
    count = 0
    list = []
    @stories.each do |s|
      count += s.estimate
      list.push s
      return list if count >= goal
    end
    nil
  end
end