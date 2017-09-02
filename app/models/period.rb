class Period < ApplicationRecord
    has_many :student_classes

    private
    def semester_with_year
        "{#semester}° {#year}"
    end
end
