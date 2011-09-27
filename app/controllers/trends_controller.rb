class TrendsController < SecureController
  def index
    
    all = current_user.stories.where("estimate IS NOT NULL AND hours_worked IS NOT NULL").order("finished DESC")
    
    burn_rate_history = all.
        map { |s| s.burn_rate }.
        reverse.
        last(120)
        
    @burn_rates = DataSeries.new burn_rate_history
    
    @estimate_groups = EstimateGroups.new(all)
    
    @stories = all
  end
end
