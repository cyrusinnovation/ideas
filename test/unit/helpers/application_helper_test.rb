require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "render ds as html" do
    ds = DataSeries.new [1, 2, 7, 2, 6, 7]
    assert_equal '<span title="4.17 &plusmn; 2.54">4 &plusmn; 3</span>', to_html(ds)
    assert_equal '4 &plusmn; 3', to_html_attribute(ds)
  end

  test "render nil ds as nils" do
      ds = DataSeries.new([])
      assert_equal nil, to_html(ds)
      assert_equal nil, to_html_attribute(ds)
  end
end
