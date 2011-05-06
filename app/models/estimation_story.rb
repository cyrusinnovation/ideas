class EstimationStory
  attr_reader :title, :estimate, :original

  def self.find_examples(options)
    estimate = options[:estimate]
    target = options[:target]
    low = options[:min]
    high = options[:max]
    stories = Story.find :all, :conditions => ["hours_worked >= ? AND hours_worked <= ?", low, high]
    stories = stories.sort_by {|story| (story.hours_worked - target).abs }
    stories.first(3).map do |story|
      EstimationStory.new story.title, estimate, story.estimate
    end
  end

  def initialize title, estimate, original
    @title = title
    @estimate = estimate
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
end
