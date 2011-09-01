# The gvis gem has a bug that causes problems in newer rails versions: it tries to call responsd_to? instead of
# respond_to?. They appear to have fixed the problem:
# https://github.com/jeremyolliver/gvis/pull/15
# but the latest gem version available right now, 2.0.3, doesn't include the fix. When we upgrade to a version that
# has the fix, this file can be deleted.

module GoogleVisualization
  def debugging?
    false
  end
end