class Schedule < ApplicationRecord
  belongs_to :klass
  belongs_to :discipline
  belongs_to :classroom
end
