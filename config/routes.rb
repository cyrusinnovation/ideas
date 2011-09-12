Pointilist::Application.routes.draw do
  devise_for :users

  root :to => 'dashboard#index'
  match 'stories/import' => 'stories#import', :as => :import, :via => :post
  match 'stories/import' => 'stories#prepare_import', :as => :import, :via => :get
  resources :stories
  resources :holidays
  match '/:controller(/:action(/:id))'
end
