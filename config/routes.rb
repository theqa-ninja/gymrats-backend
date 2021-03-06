Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:index, :new, :edit, :show, :destroy] do
      get :search, on: :collection
      get :updateGoals, on: :collection
    end

    resources :stables, only: [:index, :new, :edit, :show, :destroy] do
      get :calulateExp, on: :collection
      get :weeklyPrize, on: :collection
    end

    resources :fitbit do
      get :search, on: :collection
    end

    resources :alleleans, only: [:index, :show] do
      get :search, on: :collection
    end

    resources :helix, only: [:index, :show] do
      get :search, on: :collection
    end
  end
end
