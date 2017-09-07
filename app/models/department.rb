class Department < ApplicationRecord
    validates :name, presence: true,
                     length: { minimum: 3}
                     
    validates :place, presence: true,
                      length: { minimum: 3}

    def self.number_of_records
        @departments = Department.count
    end
end
