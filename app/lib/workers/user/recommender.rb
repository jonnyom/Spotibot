# frozen_string_literal: true

module Workers
  module User
    class Recommender

      def self.run
        ::User.all.find_in_batches(batch_size: 500).each do |users|
          users.each do |user|
            recommendation = Spotify::Recommender.new(user: user).recommendation
            Intercom::Email.new(user: user, recommendation: recommendation).send_recommendation
          end
        end
      end

    end
  end
end
