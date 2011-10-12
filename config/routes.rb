Pointilist::Application.routes.draw do
  resources :stories do
    post 'new_interactive', :on => :collection
    get 'edit_interactive', :on => :member
  end
  resource :import, :only => [:new, :create]

  root :to => 'stories#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'front#index'

  match '/trends' => 'trends#index'
  match '/history' => 'history#index'
  match '/estimation_view' => 'estimation_view#index'
  match '/privacy' => 'front#privacy'
  get '/settings' => 'settings#edit', :as => :edit_settings
  post '/settings' => 'settings#update', :as => :update_settings


  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  
end
