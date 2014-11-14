Rails.application.routes.draw do
  devise_for :users, :controllers =>
    { :omniauth_callbacks => "users/omniauth_callbacks"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'posts/my_posts', to: 'posts#my_posts', as: :my_posts

  # Just for fun XD
  get 'say/:word', to: 'static_pages#say', as: :say
  get 'car/:number', to: 'static_pages#car', as: :car
  get 'help', to: 'static_pages#help', as: :help


  # FB fucking login
  resources :users, only: [:edit, :update, :destroy]

  # Normal resources
  resources :posts
  resources :stallions
  
  # admin
  namespace :admin do
    resources :posts do
      collection do
        get :schedule, as: :schedule
        put :set_publish_time
        put :toggle_publish
        get :notification, as: :notification
      end
    end
    resources :users do
      collection do
        put :toggle_admin
      end
    end
  end

end
