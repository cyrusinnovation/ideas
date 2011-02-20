class DashboardController < ApplicationController
  def index
    @throughput = Throughput.history[0]
  end
end
