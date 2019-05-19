# frozen_string_literal: true

every 1.day, at: "01am" do
  runner "Workers::User::Recommender.run"
end

