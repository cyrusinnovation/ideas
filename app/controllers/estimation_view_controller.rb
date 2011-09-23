class EstimationViewController < SecureController
  def index
    @groups = current_user.buckets_with_examples
  end
end
