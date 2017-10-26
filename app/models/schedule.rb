class Schedule < ApplicationRecord
  belongs_to :klass
  belongs_to :discipline
  belongs_to :classroom
  belongs_to :user
  scope :schedules_between, -> (start_at, end_at) { where("start_at >= ? AND start_at <= ?", start_at, end_at) }

  def as_json(options={})
    super(:include => [:classroom, :user, :klass, :discipline])
  end
end
