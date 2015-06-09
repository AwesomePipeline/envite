Rails.application.routes.draw do
  
  # [PUBLIC] Landing page
  # =====================
  root 'landing#index'
  
  # [AUTH] Devise authentication setup
  # ==================================
  # devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations, :unlocks]
  devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations, :unlocks]
  
  # [ADMIN] Routing for admin pages
  # ===============================
  namespace :admin do
    resources :users
    resources :events
  end
  
  # [TEMP]
  resources :events
  
  # [AUTH] Routing to create notifications when inviting friends
  authenticate :user do
    post '/notifications', to: 'notifications#create'
  end
  
  # [PUBLIC] Routing for login and user management
  # ==============================================
  devise_scope :user do
    # Sessions
    get '/login', to: 'devise/sessions#new', as: 'new_user_session'
    post '/login', to: 'devise/sessions#create', as: 'user_session'
    get '/logout', to: 'devise/sessions#destroy', as: 'destroy_user_session'
    
    # Registrations
    get '/signup', to: 'devise/registrations#new', as: 'new_user_registration'
    post '/signup', to: 'devise/registrations#create', as: 'user_registration'
    get '/user', to: 'devise/registrations#edit', as: 'edit_user_registration'
    
    # Passwords
    get '/user/reset_password', to: 'devise/passwords#new', as: 'new_user_password'
    get '/user/reset_password/reset', to: 'devise/passwords#edit', as: 'edit_user_password'
    put '/user/reset_password', to: 'devise/passwords#update', as: 'user_password'
    post '/user/reset_password', to: 'devise/passwords#create'
  end
  
  # [AUTH] Routing for User's events and notifications
  # ==================================================
  scope '/user' do
    authenticate :user do
      get '/events', to: 'events#user_index', as: 'user_events'
      get '/events/:id', to: 'events#show'
      get '/notifications', to: 'notifications#user_index', as: 'user_notifications'
      get '/profile', to: 'users#show'
    end
  end
end
