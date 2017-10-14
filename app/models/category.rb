class Category < ApplicationRecord
  has_many :rooms
  validates :name, presence: true, length: { minimum: 3 }

  def self.get_categories
      @categories = Category.all
  end
end
