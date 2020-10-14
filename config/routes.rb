Rails.application.routes.draw do
  resources :counters
  root to: 'counters#railway'

  namespace :api do
    namespace :v1 do
      resources :counters
    end
  end
end
