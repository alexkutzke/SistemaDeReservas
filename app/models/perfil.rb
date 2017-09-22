class Perfil < ApplicationRecord
    has_many :actions
    validates :name, presence: true,
                     length: { minimum: 5}
end
