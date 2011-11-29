Ideas::Application.routes.draw do

  resources :categories, :except => :show

  resources :projects, :except => :show do
    resources :ideas, :except => :new do
      resources :comments, :only => [:index, :create, :new]
    end

    resources :memberships, :only => [:index, :destroy, :create]
    get '/history' => 'history#index'
    get '/settings' => 'settings#edit', :as => :edit_settings
    post '/settings' => 'settings#update', :as => :update_settings
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get "users/sign_out" => "devise/sessions#destroy"
  end

  match '/incoming_mail' => 'incoming_mail#create'
  match '/new_favorite' => 'favorite_ideas#create', :as => 'new_favorite'
  match '/delete_favorite' => 'favorite_ideas#delete', :as => 'delete_favorite'
  match '/rating' => 'ratings#rate', :as => 'rate_idea'
  root :to => 'front#index'
end
