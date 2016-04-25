Rails.application.routes.draw do

  get '/places/today'
  get '/places/yesterday'
  get '/places/two_days'
  get '/places/favorites'
  resources :places
  resources :coordinates, only: [:create, :new]
end
