Rails.application.routes.draw do

  get 'notifications/index'

resources :conversations do
  resources :messages
end

#  resources :tasks
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}

  resources :users, only: [:index, :show] do
    resources :tasks
    resources :notifications, only: [:index]
      resources :submit_requests , shallow: true do
        get 'approve'
        get 'unapprove'
        get 'reject'
          collection do
            get 'inbox'
          end
      end
  end
  resources :relationships, only: [:create, :destroy]

  resources :blogs do
    resources :comments
  end
  resources :contacts, only: [:new, :create, :index]
  post "confirm" => "contacts#confirm"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

   match "*path" => "application#handle_404", via: :all

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
