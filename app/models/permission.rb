class Permission < ApplicationRecord
  belongs_to :perfil
  belongs_to :session
  belongs_to :action
end
