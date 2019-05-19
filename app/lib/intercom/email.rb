# frozen_string_literal: true

module Intercom
  class Email

    ADMIN_ID = "1723471"

    attr_accessor :user, :recommendation

    def initialize(user:, recommendation:)
      @user = user
      @recommendation = recommendation
    end

    def send_recommendation
      intercom_client.messages.create(
        {
          message_type: "email",
          subject: "Your daily album",
          body: recommended_album,
          template: "personal",
          from: { type: "admin", id: ADMIN_ID },
          to: { type: "user", id: intercom_user.id }
        }
      )
    end

    private def recommended_album
      artist_name = recommendation.artists&.first.name
      album_url = recommendation.external_urls["spotify"]
      album_name = recommendation.name
      message(artist_name, album_url, album_name)
    end

    private def message(artist_name, album_url, album_name)
      "Here's your daily recommendation:\n#{album_name} by #{artist_name}\n#{album_url}"
    end

    private def intercom_user
      @intercom_user ||= begin
        intercom_client.users.find(user_id: user.spotify_id)
      rescue Intercom::ResourceNotFound
        Rails.logger.info("User not found, creating new user spotify_id=#{user.spotify_id}")
        intercom_client.users.create(user_id: user.spotify_id, email: user.email, name: user.full_name)
      end
    end

    private def intercom_client
      @intercom_client ||= Intercom::Client.new(token: Rails.application.credentials.intercom_pat)
    end

  end
end
