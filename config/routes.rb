Pointilist::Application.routes.draw do

  resources :stories
  resource :import, :only => [:new, :create]

  root :to => 'home#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'front#index'

  get "/" => 'home#index', :as => "user_root"

  match '/burn_rate' => 'burn_rate#index'
  match '/estimation_view' => 'estimation_view#index'
  
  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy"
  end
  
end
