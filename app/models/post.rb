class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates :title, :description, presence: true
end
