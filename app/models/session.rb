class Session < ApplicationRecord
    has_many :actions
    has_many :perfils, through: :actions
    accepts_nested_attributes_for :actions
end
