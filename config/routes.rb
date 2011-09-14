Pointilist::Application.routes.draw do

  resources :stories
  resource :import, :only => [:new, :create]

  match '/burn_rate' => 'burn_rate#index'
  match '/estimation_view' => 'estimation_view#index'
  
  devise_for :users do
    root :to => "home#index"
  end
  
  root :to => "stories#index"
end
