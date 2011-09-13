Pointilist::Application.routes.draw do

  resources :stories
  resource :import, :only => [:index, :create]
  devise_for :users
  
  match '/:controller(/:action(/:id))'

  root :to => "stories#index"
end
