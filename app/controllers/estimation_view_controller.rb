class EstimationViewController < ApplicationController
  TARGET_BURN_RATE = 16

  def index
    @count = params.fetch(:count, 3).to_i
    @count = 1 if @count < 1
    @groups = [
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
                                  :min => target * 0.75,
                                  :max => target * 1.25,
                                  :count => @count)
  end
end
