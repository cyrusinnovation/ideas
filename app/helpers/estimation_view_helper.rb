module EstimationViewHelper
  def heading(group)
    return '' if group.empty?
    group[0].estimate.to_s
  end
end
