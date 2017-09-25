class Perfil < ApplicationRecord
    has_many :actions
    has_many :sessions, through: :actions
    accepts_nested_attributes_for :actions
    validates :name, presence: true,
                     length: { minimum: 5}
end
