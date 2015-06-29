Rails.application.routes.draw do
  
  # [PUBLIC] Landing page
  # =====================
  root 'landing#index'
  
  # [PUBLIC] Feedback page
  get '/feedbacks/new', to: 'feedbacks#new', as: 'new_feedback'
  post '/feedbacks', to: 'feedbacks#create', as: 'feedbacks'
  
  # [AUTH] Devise authentication setup
  # ==================================
  # devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations, :unlocks]
  devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations, :unlocks]
  
  # [ADMIN] Routing for admin pages
  # ===============================
  namespace :admin do
    resources :users
    resources :events
    
    get '/feedbacks', to: 'feedbacks#index', as: 'feedbacks'
  end
  
  # [TEMP]
  # resources :events
  
  # [AUTH] Routing to create notifications when inviting friends
  authenticate :user do
    # Creating new events
    post '/events', to: 'events#create', as: 'events'
    get '/events/new', to: 'events#new', as: 'new_event'
    get '/events/:id', to: 'events#show', as: 'event'
    get '/events/:id/edit', to: 'events#edit', as: 'edit_event'
    patch '/events/:id', to: 'events#update'
    get '/events/:id/invite', to: 'events#invite', as: 'invite_event'
    
    # Creating new notifications
    post '/notifications', to: 'notifications#create'
    get '/notifications/invite/:event_id/:user_id', to: 'notifications#create', as: 'invite_notifications'
    
    # Accepting / Declining an invitation
    get '/notifications/:id/accept', to: 'notifications#accept', as: 'accept_notification'
    get '/notifications/:id/decline', to: 'notifications#decline', as: 'decline_notification'
    
    # Suggesting different activity / datetime / location for an event
    get '/notifications/:id/suggest_activity', to: 'notifications#suggest_activity', as: 'suggest_activity_notification'
    get '/notifications/:id/suggest_datetime', to: 'notifications#suggest_datetime', as: 'suggest_datetime_notification'
    get '/notifications/:id/suggest_location', to: 'notifications#suggest_location', as: 'suggest_location_notification'
    post '/notifications/:id/suggest', to: 'notifications#suggest', as: 'suggest_notification'
    
    # Creating messages
    get '/events/:id/:tab', to: 'events#show'
    post '/events/:id/messages', to: 'messages#create', as: 'messages'
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
    put '/user', to: 'devise/registrations#update', as: 'update_user_registration'
    
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
