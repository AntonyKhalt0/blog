# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many_attached :images

  validates :title, :description, presence: true
end
