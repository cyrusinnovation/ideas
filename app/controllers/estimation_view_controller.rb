class EstimationViewController < ApplicationController
  TARGET_BURN_RATE = 16

  def index
    @groups = [
        examples(13),
        examples(8),
        examples(5),
        examples(3),
        examples(2),
        examples(1),
        examples(0.5),
        examples(0.25),
    ]
  end

  private

  def examples( estimate)
    target = TARGET_BURN_RATE * estimate
    EstimationStory.find_examples(:estimate => estimate,
                                  :target => target,
                                  :min => target * 0.8,
                                  :max => target * 1.2,
                                  :count => 9)
  end
end
