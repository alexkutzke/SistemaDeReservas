class StudentClass < ApplicationRecord
    belongs_to :period

    validates :name, presence: true,
                        length: { minimum: 3}

    validates :period_id, presence: true,
                        length: { minimum: 1},
                        numericality: { only_integer: true }
end
