class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates_presence_of :images
end
