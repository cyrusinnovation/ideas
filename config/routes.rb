Pointilist::Application.routes.draw do
  resources :projects, :except => :show do
    resources :stories, :except => :show do
      post 'new_interactive', :on => :collection
      get 'edit_interactive', :on => :member
    end
    resource :import, :only => [:new, :create]


    match '/trends' => 'trends#index'
    match '/history' => 'history#index'
    match '/estimation_view' => 'estimation_view#index'
    get '/settings' => 'settings#edit', :as => :edit_settings
    post '/settings' => 'settings#update', :as => :update_settings

    resources :memberships, :except => [:show, :edit, :update]

  end

  match '/privacy' => 'front#privacy'

  devise_for :users do
    get "users/sign_out" => "devise/sessions#destroy"
  end

  root :to => 'front#index'
end
