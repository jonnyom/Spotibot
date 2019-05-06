Rails.application.routes.draw do
  get "/", to: "users#index"
  get "/login", to: "users#login"
  get "/logout", to: "users#logout"
  get "auth/spotify/callback", to: "spotify_oauth#callback"
end
