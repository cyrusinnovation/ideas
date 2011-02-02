class ThroughputController < ApplicationController
  def index
    @throughput_history = Throughput.history
    @teams = Team.active
  end
end
