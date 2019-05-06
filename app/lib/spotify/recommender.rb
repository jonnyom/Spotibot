# frozen_string_literal: true

module Spotify
  class RecommendationNotFoundError < StandardError; end

  class Recommender

    attr_accessor :spotify_user, :user

    def initialize(user:)
      @user = user
      @spotify_user = RSpotify::User.new(user.spotify_hash)
    end

    def recommendation
      artist_ids = top_artist_ids
      while artist_ids.present?
        sample_artists = artist_ids.shuffle.take(5)
        artist_ids = artist_ids.delete(sample_artists)
        unsaved_albums = unsaved_albums(sample_artists)
        next if unsaved_albums.blank?
        return unsaved_albums.first[:album]
      end
      raise RecommendationNotFoundError
    end

    private def unsaved_albums(artist_ids)
      unsaved_tracks = unsaved_tracks(artist_ids).take(5)
      return nil if unsaved_tracks.blank?
      recommendations = generate_recommendations(seed_tracks: unsaved_tracks.map { |track| track[:track].id })
      albums = recommendations.tracks.map(&:album)
      saved_albums(albums).reject { |album| album[:saved] }
    end

    private def unsaved_tracks(artist_ids)
      recommendations = generate_recommendations(seed_artists: artist_ids)
      tracks = recommendations.tracks
      saved_tracks(tracks).reject { |track| track[:saved] }
    end

    private def saved_albums(albums)
      spotify_user.saved_albums?(albums).each_with_index.map do |saved_album, index|
        { album: albums[index], saved: saved_album }
      end
    end

    private def saved_tracks(tracks)
      spotify_user.saved_tracks?(tracks).each_with_index.map do |saved_track, index|
        { track: tracks[index], saved: saved_track }
      end
    end

    private def top_artist_ids
      @top_artist_ids ||= spotify_user.top_artists(limit: 25).map(&:id)
    end

    private def generate_recommendations(seed_artists: [], seed_tracks: [])
      raise ArgumentError if seed_artists.blank? && seed_tracks.blank?
      RSpotify::Recommendations.generate(limit: 10, seed_artists: seed_artists, seed_tracks: seed_tracks)
    end

  end
end
