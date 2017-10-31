class Schedule < ApplicationRecord
  belongs_to :klass, optional: true
  belongs_to :discipline, optional: true
  belongs_to :classroom
  belongs_to :user
  attr_accessor :date_range
  scope :schedules_between, -> (start_at, end_at) { where("start_at >= ? AND start_at <= ?", start_at, end_at) }

  validates :start, presence: true, uniqueness: true
  validates :end, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :classroom_id, presence: true

  def as_json(options={})
    super(:include => [:classroom, :user, :klass, :discipline])
  end
end
