Rails.application.routes.draw do
  root 'articles#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :articles
  post 'articles/comments_create', as: 'article_comments' 
end
