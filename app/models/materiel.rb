class Materiel < ApplicationRecord
    belongs_to :classroom, optional: true
    validates :name, presence: true, length: { minimum:2 }

    def as_json(options={})
        super(include: :room)
    end
end
