class TrendsController < SecureController
  def index
    @hours_per_point = collect_hours_per_point
    @actuals_by_bucket = current_project.buckets.collect {|bucket| [bucket, current_project.actuals(bucket)]}
    @all_actuals = current_project.all_actuals
    @all_actuals_normalized = current_project.all_actuals_normalized
  end
  
  private
  
  def collect_hours_per_point
    DataSeries.new(current_project.stories
       .where("estimate IS NOT NULL AND hours_worked IS NOT NULL")
       .order("finished DESC")
       .limit(120)
       .reverse
       .collect { |s| s.burn_rate })
  end
end
