class Materiel < ApplicationRecord
  belongs_to :room, optional: true

  validates :name, presence: true,
                    length: {minimum:2}

  validates :patrimony, presence: true,
                    length: {minimum:3}
end
