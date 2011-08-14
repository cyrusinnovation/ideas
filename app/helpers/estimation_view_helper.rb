module EstimationViewHelper
  def heading(group)
    return '' if group.empty?
    BigDecimal.new(group[0].estimate.to_s).to_r.to_s
  end
end
