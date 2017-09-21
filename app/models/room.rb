class Room < ApplicationRecord
    belongs_to :category

    validates :capacity, presence: true,
                        length: { minimum: 1}

    validates :building, presence: true,
                        length: { minimum: 1}

    validates :room, presence: true, uniqueness: true,
                        length: { minimum: 1}

    def as_json(options={})
    super(include: :category)
  end
end
