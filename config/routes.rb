Rails.application.routes.draw do
  resources :prefectures, only: :show
  root "reviews#home"
  get "reviews/index"=> 'reviews#index'
  get 'about'=> 'reviews#about'
  get 'reviews/new'  =>  'reviews#new' 
  get 'reviews/:id'=> 'reviews#show'
  get 'reviews/:id/edit'=> 'reviews#edit'
  post 'reviews'=> 'reviews#create'
  patch 'reviews/:id/update'=> 'reviews#update'
  post 'reviews/:id/destroy'=> 'reviews#destroy'
  get "reviews/:id/comment" => "comments#index"

  get "users/index"=>"users#index"
  get "users/new" => "users#new"
  get "users/:id" => "users#show"
  get 'users/:id/myreview'=> 'users#myreview'
  get 'users/:id/favorite'=> 'users#favorite'
  post "users"=> "users#create"
  get "users/:id/edit" =>"users#edit"
  patch "users/:id/update"=>"users#update"
  get "login"=> "users#login_form"
  post "login" => "users#login"
  post "logout"=> "users#logout"

  post "likes/:review_id/create"=> "likes#create"
  post "likes/:review_id/destroy"=> "likes#destroy"

  post "comments" => "comments#create"

end
