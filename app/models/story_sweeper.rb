class StorySweeper < ActionController::Caching::Sweeper
  observe Story

  def after_create(story)
    expire_cycle_time_cache
  end

  def after_save(story)
    expire_cycle_time_cache
  end

  def after_update(story)
    expire_cycle_time_cache
  end

  def after_destroy(story)
    expire_cycle_time_cache
  end

  private

  def expire_cycle_time_cache
    expire_action :controller => 'cycle_time', :action => 'index'
    Team.active.each do |team|
      expire_action :controller => 'cycle_time', :action => 'team', :team => team
    end
  end
end