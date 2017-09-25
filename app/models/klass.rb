class Klass < ApplicationRecord
    belongs_to :period

    validates :name, presence: true,
                        length: { minimum: 3}

    validates :period_id, presence: true,
                        length: { minimum: 1},
                        numericality: { only_integer: true }

    def as_json(options={})
        super(include: :period)
    end
end
