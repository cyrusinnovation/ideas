class CycleTimeCalculator
  def initialize stories
    @stories = stories
  end

  def story
    @stories.first.title
  end
end