JKino::Application.routes.draw do
	resources :movies
	resources :events
	root 'events#index'
end
