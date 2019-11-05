Rails.application.routes.draw do
  root "reviews#home"
  get "reviews/index"=> 'reviews#index'
  get 'about'=> 'reviews#about'
  get 'reviews/new'  =>  'reviews#new' 
  get 'saitama' => 'reviews#saitama'
  get 'show/:id'=> 'reviews#show'
  get 'reviews/:id/edit'=> 'reviews#edit'
  post 'reviews'=> 'reviews#create'
  post 'reviews/:id/update'=> 'reviews#update'
  post 'reviews/:id/destroy'=> 'reviews#destroy'

end
