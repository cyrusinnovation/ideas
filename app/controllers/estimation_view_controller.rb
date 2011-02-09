class EstimationViewController < ApplicationController
  def index
    @groups = [
        [
            EstimationStory.new("Do something", 2, 1),
            EstimationStory.new("On K1 Input, show last year's ending balance by input for beginning balance.", 2, 2),
            EstimationStory.new('Add a "Tax Return" document type to FS callsheet notes', 2, 2),
        ],
        [
            EstimationStory.new("Track Tax Return Approved Date", 1, 1),
            EstimationStory.new("Frobnicate the Winstonially Frobulifiers", 1, 1),
            EstimationStory.new('Genuine Edison walks through the wilderness unfied', 1, 2),
        ],
        [
            EstimationStory.new("Do something", Rational(1, 2), 3),
            EstimationStory.new("On K1 Input, show last year's ending balance by input for beginning balance.", Rational(1, 2), Rational(1, 2)),
            EstimationStory.new('Add a "Tax Return" document type to FS callsheet notes', Rational(1, 2), Rational(1, 2)),
        ]
    ]
  end
end

class EstimationStory
  attr_reader :title, :estimate, :under_or_over

  def initialize title, estimate, original
    @title = title
    @estimate = estimate
    unless original == estimate
      word = original > estimate ? 'over' : 'under'
      @under_or_over = "<span class='#{word}'>(#{word}estimated at #{original})</span>"
    end
  end
end
