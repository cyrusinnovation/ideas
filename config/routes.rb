Pointilist::Application.routes.draw do
  match '/' => 'dashboard#index'
  match 'stories/import' => 'stories#import', :as => :import, :via => :post
  match 'stories/import' => 'stories#prepare_import', :as => :import, :via => :get
  resources :stories
  resources :holidays
  match 'cycle_time/:team' => 'cycle_time#team'
  match '/:controller(/:action(/:id))'
end
