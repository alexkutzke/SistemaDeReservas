class Room < ApplicationRecord
  belongs_to :category

  validates :capacity, presence: true,
                        length: { minimum: 1}

  validates :building, presence: true,
                        length: { minimum: 1}

  validates :room, presence: true,
                        length: { minimum: 1}

end
