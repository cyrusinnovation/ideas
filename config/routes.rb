Pointilist::Application.routes.draw do

  resource :settings, :only => [:edit, :update]
  resources :stories do
    post 'new_interactive', :on => :collection
    get 'edit_interactive', :on => :member
  end
  resource :import, :only => [:new, :create]

  root :to => 'stories#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'front#index'

  match '/burn_rate' => 'burn_rate#index'
  match '/estimation_view' => 'estimation_view#index'
  
  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  
end
