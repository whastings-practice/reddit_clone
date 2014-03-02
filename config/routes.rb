RedditClone::Application.routes.draw do
  resources :users,   except: :destroy
  resource  :session, only: [:new, :create, :destroy]

  resources :subs

  resources :links do
    resources :comments, only: :create
    member do
      patch :upvote
      patch :downvote
    end
  end

  resources :comments, only: :destroy

  root to: "subs#index"
end
