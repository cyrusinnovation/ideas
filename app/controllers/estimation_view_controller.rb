class EstimationViewController < SecureController
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
    target = current_user.target_point_size * estimate
    current_user.find_example_stories(:estimate => estimate,
                                  :target => target,
                                  :min => target * 0.8,
                                  :max => target * 1.2,
                                  :count => 9)
  end
end
