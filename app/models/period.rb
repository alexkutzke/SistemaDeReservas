class Period < ApplicationRecord
  has_many :klasses
  validates :name, presence: true, length: { minimum:3 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  # validate dates (start and end)
end
