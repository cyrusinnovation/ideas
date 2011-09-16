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
