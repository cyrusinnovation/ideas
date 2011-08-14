class EstimationStory
  attr_reader :title, :estimate, :original

  def self.find_examples(options)
    estimate = options[:estimate]
    target = options[:target]
    low = options[:min]
    high = options[:max]
    count = options[:count]
    stories = closest target, ["hours_worked >= ? AND hours_worked <= ? AND finished >= ?", low, high, Date.today - 60]
    if stories.size < count
      stories += closest target, ["hours_worked >= ? AND hours_worked <= ?", low, high]
    end
    stories.first(count).map do |story|
      EstimationStory.new story.title, estimate, story.estimate
    end
  end

  def self.closest(target, conditions)
    stories = Story.find :all, :conditions => conditions
    stories = stories.sort_by { |story| (story.hours_worked - target).abs }
    stories
  end

  def initialize title, estimate, original
    @title = title
    @estimate = BigDecimal.new(estimate.to_s).to_r
    @original = original
  end

  def under_or_over_html
    return nil if @original.nil?
    return nil if @original == @estimate
    word = @original > @estimate ? 'over' : 'under'
    @under_or_over_html = "<span class='#{word}'>(#{word}estimated at #{original.to_r})</span>"
  end

  def to_s
    title
  end

  def ==(other)
    title == other.title && estimate == other.estimate && original == other.original
  end
end
