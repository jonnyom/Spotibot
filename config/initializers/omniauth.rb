require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_SECRET"], scope: 'user-read-email user-library-read user-top-read'
  provider :slack, ENV["SLACK_CLIENT_ID"], ENV["SLACK_SECRET"], scope: 'bot,identify,chat:write:bot,links:write,users:profile:read'
end
