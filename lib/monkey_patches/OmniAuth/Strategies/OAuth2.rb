# frozen_string_literal: true

module OmniAuth::Strategies::OAuth2
  def build_access_token
    url = full_host + script_name + callback_path
    client.auth_code.get_token(verifier, {:redirect_uri => url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
  end
end

OmniAuth::Strategies::OAuth2.singleton_class.prepend(OmniAuth::Strategies::OAuth2)
