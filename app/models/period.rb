class Period < ApplicationRecord
  has_many :klasses
  validates :name, presence: true, length: { minimum:3 }
  # validate dates (start and end)
end
