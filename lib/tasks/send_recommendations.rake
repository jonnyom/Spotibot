# frozen_string_literal: true

namespace :worker do
  desc "run a periodic job to send user recommendations"
  task user_recommender: :environment do
    ::Workers::User::Recommender.run
  end
end
