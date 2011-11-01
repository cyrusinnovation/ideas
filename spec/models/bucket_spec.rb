require 'spec_helper'

describe Bucket do
  before(:each) do
    @buckets = [0.25, 0.5, 1, 2, 3, 5, 8, 13].collect { |bucket| Bucket.create :value => bucket }
  end

  it "should display html correctly" do
    @buckets.first.pretty_print_html.should == '&frac14;'
    @buckets.last.pretty_print_html.should == 13
  end

  it "should convert whole numbers to integers" do 
    @buckets.first.pretty_print.should == 0.25
    # @buckets.last.pretty_print.should 
  end

end
