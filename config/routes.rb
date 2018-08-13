Rails.application.routes.draw do
  get 'slack_oauth/callback'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :slack do
    controller :slack_oauth do
      get '/auth/callback' => :callback
    end
  end
end
