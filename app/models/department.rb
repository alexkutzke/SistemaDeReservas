class Department < ApplicationRecord
  belongs_to :sector
  validates :name, presence: true, length: { minimum: 3 }
  validates :sector_id, presence: true, length: { minimum: 1 }, numericality: { only_integer: true }
end
