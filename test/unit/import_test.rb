require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  test "import a story" do
    story = import_story '143 Remove unused permissions,ShARC,0.25,1/24/2011,1/25/2011,1,4.0,9,8'
    assert_equal '143 Remove unused permissions', story.title
    assert_equal 'ShARC', story.team
    assert_equal 0.25, story.estimate
    assert_equal Date.new(2011, 1, 24), story.started
    assert_equal Date.new(2011, 1, 25), story.finished
  end

  test "blank fields should become nil" do
    story = import_story '143 Remove unused permissions,,,,,,,,'
    assert_equal '143 Remove unused permissions', story.title
    assert_nil story.team
    assert_nil story.estimate
    assert_nil story.started
    assert_nil story.finished
  end

  def import_story csv_row
    import_file = StringIO.new <<HERE # Note that it should ignore the first (header) line of the file
Title,Team,Estimate,Started,Finished,Additional,Other,Ignored,Fields
#{csv_row}
HERE
    Import.new(import_file).each {|story| return story }
  end
end