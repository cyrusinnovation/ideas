class CycleTimeCalculator
  def initialize stories
    @stories = stories
  end

  def list_back
    result = []
    @stories.size.downto(1) do |count|
      shorter_stories = @stories.last(count)
      result.push CycleTimeCalculator.new(shorter_stories)
    end
    result
  end

  def story
    @stories.first.title
  end

  def for_points goal
    stories = stories_for_points(goal)
    return nil if stories.nil?
    started = stories.map{|s| s.started}.min
    finished = stories.first.finished
    DateRange.new(started, finished).workdays
  end

  private

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