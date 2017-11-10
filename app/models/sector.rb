class Sector < ApplicationRecord
  has_many :departments
  validates :name, presence: true, length: { minimum: 3 }
end
