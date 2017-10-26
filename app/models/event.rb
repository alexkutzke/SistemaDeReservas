class Event < ApplicationRecord
  belongs_to :klass, optional: true
  belongs_to :discipline, optional: true
  belongs_to :classroom
  belongs_to :user

  validates :title, presence: true
  attr_accessor :date_range

  def as_json(options={})
    super(:include => [:classroom, :user, :klass, :discipline])
  end
end
