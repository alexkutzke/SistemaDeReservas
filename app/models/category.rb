class Category < ApplicationRecord
  has_many :rooms
  validates :name, presence: true, length: { minimum: 3 }
end
