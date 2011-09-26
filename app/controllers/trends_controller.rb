class TrendsController < SecureController
  def index
    burn_rate_history = current_user.all_with_burn_rates.
        map { |s| s.burn_rate }.
        reverse.
        last(120)
    @burn_rates = DataSeries.new burn_rate_history
    @estimate_groups = EstimateGroups.new(current_user.all_with_burn_rates) { |s| s.hours_worked }
    @stories = current_user.all_with_burn_rates
  end
end
