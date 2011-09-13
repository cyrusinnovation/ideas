class User
  def find_example_stories(options)
    estimate = options[:estimate]
    target = options[:target]
    low = options[:min]
    high = options[:max]
    count = options[:count]
    examples = closest target, ["hours_worked >= ? AND hours_worked <= ? AND finished >= ?", low, high, Date.today - 60]
    if examples.size < count
      examples += closest target, ["hours_worked >= ? AND hours_worked <= ?", low, high]
    end
    examples.first(count).map do |story|
      EstimationStory.new story.title, estimate, story.estimate
    end
  end

  def closest(target, conditions)
    examples = stories.find :all, :conditions => conditions
    examples = examples.sort_by { |story| (story.hours_worked - target).abs }
    examples
  end
end

class EstimationStory
  attr_reader :title, :estimate, :original

  def initialize title, estimate, original
    @title = title
    @estimate = BigDecimal.new(estimate.to_s)
    @original = original
  end

  def under_or_over_html
    return nil if @original.nil?
    return nil if @original == @estimate
    word = @original > @estimate ? 'over' : 'under'
    @under_or_over_html = "<span class='#{word}'>(#{word}estimated at #{original})</span>"
  end

  def to_s
    title
  end

  def ==(other)
    title == other.title && estimate == other.estimate && original == other.original
  end
end
