class Materiel < ApplicationRecord
  belongs_to :room, optional: true
end
