# frozen_string_literal: true

FactoryBot.define do
  factory :news do
    sequence(:urod_id) { |n| n }
    link { Faker::Internet.url }
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    send_msg { [true, false].sample }
    format { News::ALLOWED_FORMATS.sample }

    # sequel's models don't support method save!, but FactoryBot uses it
    to_create(&:save)
  end
end
