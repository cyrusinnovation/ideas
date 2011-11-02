require 'spec_helper'

describe Bucket do
  before(:each) do
    @project = Project.create :name => 'Test', :target_point_size => 2
    @buckets = [0.25, 0.5, 1, 2, 3, 5, 8, 13].collect { |bucket| Bucket.create :value => bucket, :project => @project }
    @project.buckets = @buckets
    
    @quarter = @buckets.first
    @half = @buckets[1]
    @one = @buckets[2]
    @thirteen = @buckets.last
  end

  it "should display html correctly" do
    @quarter.pretty_print_html.should == '&frac14;'
    @thirteen.pretty_print_html.should == 13
  end

  it "should convert whole numbers to integers" do 
    @quarter.pretty_print.class.should == Float
    @thirteen.pretty_print.class.should == Fixnum
  end

  it "give you the hours the point equates to" do
    @one.hours.should == 2
    @thirteen.hours.should == 26
  end

  it "should be able to give you the previous and next bucket" do
    @half.previous_bucket.should == @quarter
    @half.next_bucket.should == @one
  end

  it "should give you a time range" do
    @one.max.should == 3
    @one.min.should == 1.5
  end

  it "should not bound lowest bucket" do
    @quarter.min.should == 0
  end

  it "should bound biggest bucket to a higher amount" do
    @thirteen.max.should == 31
  end

  it "should be able to tell you if its the smallest bucket" do
    @quarter.no_min?.should be_true
    @thirteen.no_min?.should be_false
  end

  it "should make sure values are unique for a project" do
    bucket = Bucket.create :value => 1, :project => @project
    bucket = Bucket.create :value => 1, :project => @project
  end

  it "should validate value" do
    Bucket.create(:value => "aeu", :project => @project).should be_invalid
    Bucket.create(:value => -1, :project => @project).should be_invalid
    Bucket.create(:value => 999999, :project => @project).should be_invalid
  end

end
