# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: 'dev.dev') }
    password { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }
    confirmed_at { Time.current }

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
