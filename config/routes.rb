Ideas::Application.routes.draw do
  resources :projects, :except => :show do
    resources :ideas, :except => :new

    resources :memberships, :only => [:index, :destroy, :create]
    get '/history' => 'history#index'
    get '/settings' => 'settings#edit', :as => :edit_settings
    post '/settings' => 'settings#update', :as => :update_settings
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get "users/sign_out" => "devise/sessions#destroy"
  end

  match '/incoming_mail' => 'incoming_mail#create'
  
  root :to => 'front#index'
end
