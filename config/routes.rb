Pointilist::Application.routes.draw do
  match 'stories/import' => 'stories#import', :as => :import, :via => :post
  match 'stories/import' => 'stories#prepare_import', :as => :import, :via => :get
  resources :stories
  match '/:controller(/:action(/:id))'
  root :to => "stories#index"
end
