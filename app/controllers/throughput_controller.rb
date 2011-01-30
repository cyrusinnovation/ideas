class ThroughputController < ApplicationController
  def index
    @throughput_history = Throughput.history
  end
end
