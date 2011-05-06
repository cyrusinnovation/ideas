class EstimationViewController < ApplicationController
  TARGET_BURN_RATE = 16

  def index
    averages = Story.average_hours_by_estimate
    @groups = [
        examples(averages, 5),
        examples(averages, 3),
        examples(averages, 2),
        examples(averages, 1),
        examples(averages, 0.5),
        examples(averages, 0.25),
    ]
  end

  private

  def examples(averages, estimate)
    target = TARGET_BURN_RATE * estimate
    EstimationStory.find_examples(:estimate => estimate,
                                  :target => target,
                                  :min => target * 0.75,
                                  :max => target * 1.25)
  end
end
