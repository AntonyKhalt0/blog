# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { 'User' }
    email { 'user@test.org' }
    password { 12_345_678 }
  end
end
