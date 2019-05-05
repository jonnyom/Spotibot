require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "factory_bot"
require "json"

OmniAuth.config.test_mode = true
spotify_auth_hash = {
  provider: "spotify",
  uid: "1199355469",
  info: {
    display_name: nil,
    email: "jonathanomahony@gmail.com",
    external_urls: {
      spotify: "https: //open.spotify.com/user/1199355469"
    },
    followers: {
      href: nil,
      total: 46
    },
    href: "https: //api.spotify.com/v1/users/1199355469",
    id: "1199355469",
    images: [],
    type: "user",
    uri: "spotify:user:1199355469"
  },
  credentials:{
    token: "<TOKEN>",
    refresh_token: "<REFRESH_TOKEN>",
    expires_at: 1557084545,
    expires: true
  },
  extra: {
    raw_info: {
      display_name: nil,
      email: "jonathanomahony@gmail.com",
      external_urls: {
        spotify: "https://open.spotify.com/user/1199355469"
      },
      followers: {
        href: nil,
        total: 46
      },
      href: "https: //api.spotify.com/v1/users/1199355469",
      id: "1199355469",
      images: [],
      type: "user",
      uri: "spotify:user:1199355469"
    }
  }
}
OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(spotify_auth_hash)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
end
