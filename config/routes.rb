RedditClone::Application.routes.draw do
  resources :users,   except: :destroy
  resource  :session, only: [:new, :create, :destroy]

  resources :subs
  resources :links

  root to: "sessions#new"
end
