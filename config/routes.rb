Pointilist::Application.routes.draw do
  resource :settings, :only => [:edit, :update]
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
  post 'new_bucket' => 'settings#new_bucket', :as => :new_bucket
  get 'delete_bucket' => 'settings#delete_bucket', :as => :delete_bucket

  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  
end
