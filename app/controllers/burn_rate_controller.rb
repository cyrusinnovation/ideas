class BurnRateController < SecureController
  def index
    burn_rate_history = Story.all_with_burn_rates.
        map { |s| s.burn_rate }.
        reverse.
        last(120)
    @burn_rates = DataSeries.new burn_rate_history    
    @estimate_groups = EstimateGroups.new(Story.all_with_burn_rates) { |s| s.hours_worked }
    @stories = Story.all_with_burn_rates.map {|s| @estimate_groups.story_vs_estimate(s) }
  end
end
