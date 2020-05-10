Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'about#top'
  devise_for :users


  resources :books, only:[:index,:show,:edit,:update,:create,:destroy]
  resources :users, only:[:index,:edit,:show,:update,:create,:update]
end
