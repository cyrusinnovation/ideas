Pointilist::Application.routes.draw do
  resources :projects, :except => :show do
    resources :stories do
      post 'new_interactive', :on => :collection
      get 'edit_interactive', :on => :member
    end
    resource :import, :only => [:new, :create]
    resources :memberships, :only => [:index, :destroy, :create]

    match '/trends' => 'trends#index'
    match '/history' => 'history#index'
    get '/settings' => 'settings#edit', :as => :edit_settings
    post '/settings' => 'settings#update', :as => :update_settings
  end

  match '/privacy' => 'front#privacy'

  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy"
  end

  root :to => 'front#index'
end
