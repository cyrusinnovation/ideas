class ThroughputController < ApplicationController
  def index
    @throughput_history = Throughput.history
    @teams = [Team.find_by_name('ShARC'), Team.find_by_name('Schildkroete')]
  end
end
