class Schedule < ApplicationRecord
  belongs_to :klass, optional: true
  belongs_to :discipline, optional: true
  belongs_to :classroom
  belongs_to :user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :discipline
  accepts_nested_attributes_for :classroom
  accepts_nested_attributes_for :klass

  attr_accessor :date_range
  attr_accessor :destroyed
  after_destroy :mark_as_destroyed

  validates :start, presence: true, uniqueness: true
  validates :end, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :classroom_id, presence: true

  scope :in_range, -> range {
    where('(start BETWEEN ? AND ?)', range.first, range.last)
  }
  scope :exclude_self, -> id { where.not(id: id) }

  def as_json(options={})
    if options.has_key?(:id) && options[:id] == self.user_id
      super(:include => [:classroom, :user, :klass, :discipline]).merge({:can_destroy => true})
    else
      super(:include => [:classroom, :user, :klass, :discipline])
    end
  end

  # pode deixar assim, mas se tiver muito dados na tabela, pode ficar lento
  def is_not_overlap (from, to)
    range = Range.new from + 1, to - 1
    overlaps = Schedule.exclude_self(id).in_range(range)
    overlaps.empty? ? true : false
  end

  def mark_as_destroyed
    self.destroyed = true
  end

  # We defined this method when a user create a schedule by modal - field title can't be blank
  def validates()
    if self.title.blank?
      errors.add(:title, :blank, message: "cannot be blank") if self.title.blank?
      return false
    end
    return true
  end
end
