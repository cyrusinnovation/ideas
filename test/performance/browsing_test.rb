require 'test_helper'
require 'rails/performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionDispatch::PerformanceTest
  def setup
    given_existing_stories(100)
  end

  def test_dashboard
    get '/'
  end

  def test_stories
    get '/stories'
  end

  def test_throughput
    get '/throughput'
  end

  def test_cycle_time
    get '/cycle_time'
  end

  def test_burn_rate
    get '/burn_rate'
  end

  def test_estimation_view
    get '/estimation_view'
  end

  private

  def given_existing_stories count
    (1..count).collect { |i| Date.new(2011, 1, 1) + i }.each do |date|
      Story.create :title => date.to_s, :started => date, :finished => date+1, :estimate => 3, :hours_worked => 58
    end
  end
end
