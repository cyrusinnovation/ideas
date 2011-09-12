class DashboardController < ApplicationController
  def index
    burn_rate_history = Story.all_with_burn_rates.
        map { |s| s.burn_rate }.
        reverse.
        last(120)
    @burn_rates = DataSeries.new burn_rate_history
  end
end
