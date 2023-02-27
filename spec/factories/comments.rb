# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { 'Comment' }
  end

  trait :invalid_comment do
    body { nil }
  end
end
