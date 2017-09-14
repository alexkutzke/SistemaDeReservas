class Room < ApplicationRecord
  belongs_to :category

  validates :capacity, presence: true,
                        length: { minimum: 1}

  validates :block, presence: true,
                        length: { minimum: 1}

  validates :place, presence: true,
                        length: { minimum: 1}

  def self.number_of_records
    @rooms = Room.count
  end
end
