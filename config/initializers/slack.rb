if Rails.env.production?
  SLACK_OAUTH_REDIRECT_URL = "http://www.spotibot.pw/slack/auth/callback"
else
  SLACK_OAUTH_REDIRECT_URL = "https://spotibot.serveo.netslack/auth/callback"
end
