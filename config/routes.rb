JKino::Application.routes.draw do
	get "log_in" => "sessions#new", :as => "log_in"
	get "log_out" => "sessions#destroy", :as => "log_out"
	get "sign_up" => "users#new", :as => "sign_up"

	get "sessions/new"
	get "users/new"
	
	resources :movies, :only => [:index, :new, :create, :show, :edit, :update, :destroy]
	resources :events, :only => [:index, :new, :create, :show, :edit, :update, :destroy]
	resources :users, :only => [:new, :create]
	resources :sessions, :only => [:new, :create]
	
	root 'events#index'
end
