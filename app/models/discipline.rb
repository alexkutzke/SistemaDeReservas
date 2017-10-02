class Discipline < ApplicationRecord
  belongs_to :department, optional: true

  validates :name, presence: true, length: { minimum: 3}, uniqueness: true

  validates :discipline_code, presence: true, length: {minimum: 3}, uniqueness: true

  # not required at SEPT
  # validates :department_id, presence: true,
  #                           length: {minimum: 1},
  #                           numericality: { only_integer: true }
  def as_json(options={})
    super(include: :department)
  end
end
