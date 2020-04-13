Rails.application.routes.draw do
  root 'sessions#new'
  post "users/:id/update", to: "users#update"
  resources :users, only: [:new, :create, :show, :index, :edit ,:update]
  resources :sessions, only: [:new, :create, :destroy,:update]
  resources :favorites, only: [:index,:create, :destroy]
  resources :feeds do
    collection do
      post :confirm
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
