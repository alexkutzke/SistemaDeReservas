class Category < ApplicationRecord
    validates :name, presence: true,
                        length: { minimum: 3}

    def self.number_of_records
        @number = Category.count
    end
end
