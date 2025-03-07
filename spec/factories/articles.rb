# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Lorem.sentence }
  end
end