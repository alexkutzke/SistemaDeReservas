class Action < ApplicationRecord
  belongs_to :perfil
  belongs_to :session
  accepts_nested_attributes_for :perfil
end
