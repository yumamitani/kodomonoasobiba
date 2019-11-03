Rails.application.routes.draw do
  get 'reviews' => 'reviews#index'
  get 'reviews/new'  =>  'reviews#new' 
end
