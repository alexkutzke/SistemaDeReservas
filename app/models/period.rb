class Period < ApplicationRecord
    has_many :student_classes

    validates :name, presence: true,
                        length: {minimum:4}

    # validate dates (start and end)          
end
