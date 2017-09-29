class Perfil < ApplicationRecord
    has_many :actions
    accepts_nested_attributes_for :actions
    validates :name, presence: true, uniqueness: true,
                     length: { minimum: 5}
end
