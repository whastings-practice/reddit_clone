RedditClone::Application.routes.draw do
  resources :users,   except: :destroy
  resource  :session, only: [:new, :create, :destroy]

  root to: "sessions#new"
end
