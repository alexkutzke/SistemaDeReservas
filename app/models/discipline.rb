class Discipline < ApplicationRecord
  belongs_to :department, optional: true

  validates :name, presence: true,
                     length: { minimum: 3}

  validates :discipline_code, presence: true,
                    length: {minimum: 3}

  validates :department_id, presence: true,
                            length: {minimum: 1},
                            numericality: { only_integer: true }
  def as_json(options={})
    super(include: :department)
  end
end
