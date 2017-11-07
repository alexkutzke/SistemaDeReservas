class Schedule < ApplicationRecord
  belongs_to :klass, optional: true
  belongs_to :discipline, optional: true
  belongs_to :classroom
  belongs_to :user
  attr_accessor :date_range

  validates :start, presence: true, uniqueness: true
  validates :end, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :classroom_id, presence: true

  scope :in_range, -> range {
    where('(start BETWEEN ? AND ?)', range.first, range.last)
  }
  scope :exclude_self, -> id { where.not(id: id) }

  def as_json(options={})
    super(:include => [:classroom, :user, :klass, :discipline])
  end

  # pode deixar assim, mas se tiver muito dados na tabela, pode ficar lento
  def is_not_overlap (from, to)
    range = Range.new from + 1, to - 1
    overlaps = Schedule.exclude_self(id).in_range(range)
    overlaps.empty? ? true : false
  end
end
