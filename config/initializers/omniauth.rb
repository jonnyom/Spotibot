require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,
           Rails.application.credentials.spotify[:client_id],
           Rails.application.credentials.spotify[:client_secret],
           scope: 'user-read-email user-top-read playlist-modify-public user-library-read user-library-modify'
end
