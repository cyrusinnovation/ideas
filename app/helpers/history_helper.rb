module HistoryHelper
  def story_row_class(story)
    return nil if story.estimate.nil?
    actuals = @all_actuals_by_estimate[story.estimate]
    difference = story.variance_vs_mean(actuals)
    return nil if difference.nil?
    difference < 0 ? :overestimated : :underestimated
  end 
end