class Discipline < ApplicationRecord
  belongs_to :department

  validates :name, presence: true,
                     length: { minimum: 3}

  validates :discipline_code, presence: true,
                    length: {minimum: 3}

  validates :department_id, presence: true,
                            length: {minimum: 1}
  def self.number_of_records
    @number = Discipline.count
  end
end
