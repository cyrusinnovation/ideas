class TrendsController < SecureController
  def index
    @hours_per_point = collect_hours_per_point
    @actuals_by_bucket = current_user.buckets.collect {|b| [b, current_user.actuals(b)]}
    @all_actuals = current_user.all_actuals
    @all_actuals_normalized = current_user.all_actuals_normalized
  end
  
  private
  
  def collect_hours_per_point
    DataSeries.new(current_user.stories
       .where("estimate IS NOT NULL AND hours_worked IS NOT NULL")
       .order("finished DESC")
       .limit(120)
       .reverse
       .collect { |s| s.burn_rate })
  end
end
