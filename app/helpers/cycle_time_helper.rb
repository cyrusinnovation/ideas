module CycleTimeHelper
  def full_team_link
    link_to 'Full Team', { :action => 'index' }, { :class => 'current' }
  end

  def team_link team
    link_to team.name, { :action => 'team', :team => team }
  end
end
