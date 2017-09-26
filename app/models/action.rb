class Action < ApplicationRecord
  belongs_to :perfil
  accepts_nested_attributes_for :perfil
end
