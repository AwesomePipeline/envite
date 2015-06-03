Rails.application.routes.draw do
  
  # [DEV] Root temporary landing page
  # =================================
  root 'landing#index'
  
  # [AUTH] Devise authentication setup
  # ==================================
  devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations, :unlocks]
  
  # [ADMIN] Routing for admin pages
  namespace :admin do
    resources :users
    resources :events
  end  
  
  resources :events
  
  # [DEV] Routing for scaffolding GUI
  # =================================
  scope '/', defaults: {format: :html} do
    # Devise authentication and User actions via GUI
    devise_scope :user do
      # Sessions
      get '/login', to: 'api/sessions#new', as: 'new_user_session'
      post '/login', to: 'api/sessions#create', as: 'user_session'
      get '/logout', to: 'api/sessions#destroy', as: 'destroy_user_session'
      
      # Registrations
      get '/signup', to: 'users/registrations#new', as: 'new_user_registration'
      post '/signup', to: 'users/registrations#create', as: 'user_registration'
      get '/user', to: 'users/registrations#edit', as: 'user_root'
      
      # Passwords
      get '/user/reset_password', to: 'devise/passwords#new', as: 'new_user_password'
      get '/user/reset_password/reset', to: 'devise/passwords#edit', as: 'edit_user_password'
      put '/user/reset_password', to: 'devise/passwords#update', as: 'user_password'
      post '/user/reset_password', to: 'devise/passwords#create'
    end
    
    # [AUTH] Routing to create notifications when inviting friends
    authenticate :user do
      post '/notifications', to: 'notifications#create'
    end
    
    # [AUTH] Routing for User's events via GUI
    # NOTE: Priority lower than above for proper default resource paths
    scope '/user' do
      authenticate :user do
        get '/events', to: 'events#user_index', as: 'user_events'
        get '/events/:id', to: 'events#show'
        get '/notifications', to: 'notifications#user_index', as: 'user_notifications'
      end
    end
  end
  
  # [PROD] Routing for API access
  # =============================
  scope :api, defaults: {format: :json} do
    # Devise authentication and User actions via API
    devise_scope :user do
      # Sessions
      post '/login', to: 'api/sessions#create'
      delete '/logout', to: 'api/sessions#destroy'
      
      # Registrations
      post '/signup', to: 'api/registrations#create'
    end
    
    # Access to events via API
    resources :events, only: [:create, :show, :update, :destroy]
    
    # Access to User's events via API
    scope :user do
      resources :events, only: [:index, :create, :show, :update, :destroy]
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
