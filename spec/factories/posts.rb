# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Title' }
    description { 'Description' }
  end

  trait :invalid do
    title { nil }
  end
end
