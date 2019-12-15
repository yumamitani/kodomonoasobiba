Rails.application.routes.draw do
  resources :prefectures, only: :show
  root "reviews#home"
  get "reviews/index"=> 'reviews#index'
  get 'about'=> 'reviews#about'
  get 'reviews/new'  =>  'reviews#new' 
  get 'saitama' => 'reviews#saitama'
  get 'reviews/:id'=> 'reviews#show'
  get 'reviews/:id/edit'=> 'reviews#edit'
  post 'reviews'=> 'reviews#create'
  post 'reviews/:id/update'=> 'reviews#update'
  post 'reviews/:id/destroy'=> 'reviews#destroy'

  get "users/index"=>"users#index"
  get "users/:id" => "users#show"
  get "users/new" => "users#new"
  post "users/create"=> "users#create"
  get "users/:id/edit" =>"users#edit"
  post "users/:id/update"=>"users#update"
  get "login"=> "users#login_form"
  post "login" => "users#login"
  post "logout"=> "users#logout"

  post "likes/:review_id/create"=> "likes#create"
  post "likes/:review_id/destroy"=> "likes#destroy"

end
