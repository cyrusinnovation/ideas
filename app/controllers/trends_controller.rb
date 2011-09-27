class TrendsController < SecureController
  def index
    
    all = current_user.all_with_burn_rates
    
    burn_rate_history = all.
        map { |s| s.burn_rate }.
        reverse.
        last(120)
        
    @burn_rates = DataSeries.new burn_rate_history
    
    @estimate_groups = EstimateGroups.new(all) { |s| s.hours_worked }
    
    @stories = all
  end
end
