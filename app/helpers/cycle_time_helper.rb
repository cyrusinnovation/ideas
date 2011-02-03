module CycleTimeHelper
  def full_team_link
    attributes = {}
    attributes[:class] = 'current' if @controller.action_name == 'index'
    link_to 'Full Team', { :action => 'index' }, attributes
  end

  def team_link team
    attributes = {}
    attributes[:class] = 'current' if @controller.action_name == 'team' && @team == team
    link_to team.name, { :action => 'team', :team => team }, attributes
  end
end
