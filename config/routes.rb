Rails.application.routes.draw do
  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }
  devise_for :user,skip:[:passwords],controllers:{
    registrations:'public/registrations',
    sessions:'public/sessions'
  }
  
  namespace :admin do
    root 'posts#index'
    get 'top'=>'homes#top'
    resources :posts,only:[:index,:show,:destroy]
    resources :users do
      member do 
        patch :withdraw
      end 
    end
  end  
  
  
  
  
  
  get 'homes/about'
  root to:'homes#top'
  resources :users,only:[:index,:show,:edit,:update] do
  end   
  resources :posts do
    resources :post_comments,only:[:create,:destroy]
  end   
  get 'search'=>'searches#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end   
