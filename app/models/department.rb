class Department < ApplicationRecord
    has_many :disciplines
    validates :name, presence: true,
                     length: {minimum: 5}
    validates :abbreviation, presence: true
    validates :place, presence: true,
                      length: {minimum: 5}
end
