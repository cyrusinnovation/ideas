class ActualsController < SecureController
  def index
    @stories = current_project.stories.order("title ASC")
    @stories_no_actual = current_project.stories.where('finished IS NULL AND hours_worked IS NULL').order("title ASC")
  end
end
