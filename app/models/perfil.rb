class Perfil < ApplicationRecord
    has_many :permissions
    validates :name, presence: true,
                     length: { minimum: 5}
end
