class Period < ApplicationRecord
    has_many :student_classes

    validates :semester, presence: true,
                        length: {minimum:1, maximum:1}

    validates :year, presence: true,
                        length: {minimum:4, maximum:4},
                        numericality: { only_integer: true }

    # validate dates (start and end)          
end
