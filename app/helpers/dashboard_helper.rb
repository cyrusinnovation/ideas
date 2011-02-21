module DashboardHelper
  def throughput_history
    image_tag url_for(:action => 'throughput_sparkline'), :alt => ''
  end
end
