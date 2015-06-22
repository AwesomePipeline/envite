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
    # Creating new notifications
    post '/notifications', to: 'notifications#create'
    
    # Accepting / Declining an invitation
    get '/notifications/:id/accept', to: 'notifications#accept', as: 'accept_notification'
    get '/notifications/:id/decline', to: 'notifications#decline', as: 'decline_notification'
    
    # Suggesting different activity / datetime / location for an event
    get '/notifications/:id/suggest_activity', to: 'notifications#suggest_activity', as: 'suggest_activity_notification'
    get '/notifications/:id/suggest_datetime', to: 'notifications#suggest_datetime', as: 'suggest_datetime_notification'
    get '/notifications/:id/suggest_location', to: 'notifications#suggest_location', as: 'suggest_location_notification'
    post '/notifications/:id/suggest', to: 'notifications#suggest', as: 'suggest_notification'
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
