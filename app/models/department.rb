class Department < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 3}

  validates :place, presence: true,
                    length: { minimum: 3}
  def self.get_departments
    Department.all
  end
end
