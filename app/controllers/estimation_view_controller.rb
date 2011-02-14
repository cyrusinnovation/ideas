class EstimationViewController < ApplicationController
  def index
    averages = Story.average_hours_by_estimate
    @groups = [
        EstimationStory.find_examples(:estimate => 5, :average_time => averages[BigDecimal.new("5")]),
        EstimationStory.find_examples(:estimate => 3, :average_time => averages[BigDecimal.new("3")]),
        EstimationStory.find_examples(:estimate => 2, :average_time => averages[BigDecimal.new("2")]),
        EstimationStory.find_examples(:estimate => 1, :average_time => averages[BigDecimal.new("1")]),
        EstimationStory.find_examples(:estimate => 0.5, :average_time => averages[BigDecimal.new("0.5")]),
        EstimationStory.find_examples(:estimate => 0.25, :average_time => averages[BigDecimal.new("0.25")]),
    ]
  end
end
