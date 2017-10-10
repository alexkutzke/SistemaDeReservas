class Role < ApplicationRecord
    has_many :permissions
    accepts_nested_attributes_for :permissions
    validates :name, presence: true, uniqueness: true,
                     length: { minimum: 5}

     def self.get_roles
       Role.all
     end
end
