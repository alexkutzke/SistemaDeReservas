class Permission < ApplicationRecord
    belongs_to :role
    accepts_nested_attributes_for :role
end
