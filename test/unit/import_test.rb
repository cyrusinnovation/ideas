require 'test_helper'
require 'import'

class ImportTest < ActiveSupport::TestCase
  test "import a story" do
    story = import_story '143 Remove unused permissions,ShARC,0.25,1/24/2011,1/25/2011,3.5,1,4.0,9,8'
    assert_equal '143 Remove unused permissions', story.title
    assert_equal 0.25, story.estimate
    assert_equal Date.new(2011, 1, 24), story.started
    assert_equal Date.new(2011, 1, 25), story.finished
    assert_equal 3.5, story.hours_worked
  end

  test "blank fields should become nil" do
    story = import_story '143 Remove unused permissions,,,,,,,,,'
    assert_equal '143 Remove unused permissions', story.title
    assert_nil story.estimate
    assert_nil story.started
    assert_nil story.finished
    assert_nil story.hours_worked
  end

  test "wrap a field in quotes if it includes commas" do
    story = import_story '"a, b, c",,,,,,,,'
    assert_equal 'a, b, c', story.title
  end

  test "escape quotes by doubling them" do
    story = import_story '"a, ""b"", c",,,,,,,,'
    assert_equal 'a, "b", c', story.title
  end

  def import_story csv_row
    import_file = StringIO.new <<HERE # Note that it should ignore the first (header) line of the file
Title,Team,Estimate,Started,Finished,Additional,Other,Ignored,Fields
#{csv_row}
HERE
    Import.new(import_file).each {|story| return story }
  end
end