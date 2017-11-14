class Schedule < ApplicationRecord
  require 'csv'
  require 'date'

  belongs_to :klass, optional: true
  belongs_to :discipline, optional: true
  belongs_to :classroom
  belongs_to :user, optional: true

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :discipline
  accepts_nested_attributes_for :classroom
  accepts_nested_attributes_for :klass

  attr_accessor :date_range
  attr_accessor :destroyed
  attr_accessor :skip_user_validation
  after_destroy :mark_as_destroyed

  validates :start, presence: true, uniqueness: true
  validates :end, presence: true, uniqueness: true
  validates :user_id, presence: true, unless: :skip_user_validation
  validates :classroom_id, presence: true

  scope :in_range, -> range {
    where('(start BETWEEN ? AND ?)', range.first, range.last)
  }
  scope :exclude_self, -> id { where.not(id: id) }

  def as_json(options={})
    if options.has_key?(:admin) && options[:admin]
      super(:include => [:classroom, :user, :klass, :discipline]).merge({:can_destroy => true, :users => User.all})
    elsif options.has_key?(:id) && options[:id] == self.user_id
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

  def should_validate_user?
    :skip_user_validation?
  end

  private
  def self.import(file, period)
    puts '********************'
    begin
      puts file.blank?
      if file.blank?
        raise CustomError, "Select a csv file"
      end
      i = 1;
      Schedule.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row['Day'].nil? || row['Hour'].nil? || row['Students Sets'].nil? || row['Subject'].nil? ||
                            row['Teachers'].nil? || row['Room'].nil?
            raise CustomError, "Incorrectly csv timetable file"
          end

          klass = Klass.find_by_name(row['Students Sets'], period)
          raise CustomError, "Klass name not found" if klass.nil?

          @array = row['Subject'].split(/-/)
          discipline = Discipline.find_by_name(@array[1], @array[0])
          raise CustomError, "Discipline name and discipline code not found" if discipline.nil?

          classroom = Classroom.find_by_name(row['Room'])
          raise CustomError, "Classroom name not found" if classroom.nil?

          day = row['Day']
          if day != 'Sábado'  
            day = row['Day'].scan( /\d+$/ ).first - 1
          else
            day = 6
          end



          user = User.find_by_name(row['Teachers'])

          @schedule = Schedule.new
          @schedule.klass_id = klass.id
          @schedule.discipline_id = discipline.id
          @schedule.user_id = user.nil? ? :null : user.id
          @schedule.classroom_id = classroom.id
          @schedule.skip_user_validation = true # skip user validation

          period = Period.find(period)

          puts period.start_date
          puts period.end_date

          puts Time.now
          time = Time.now
          puts time.wday
          puts Time.now + 7.days

          date_of_next(day)

          if !@schedule.save! then
            raise ActiveRecord::Rollback
          end
        end
      end
    rescue CustomError => e
      @error = true
      @message = e.message
    rescue CSV::MalformedCSVError
      @error = true
      @message = "Encolding error (use UTF-8)"
    end
    return @error, @message
  end

  def replicate_schedule
    s = IceCube::Schedule.new
  end

  def date_of_next(day)
    array = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')
    puts '****'
    puts day
    puts array[day]
    date  = Date.parse(array[day])
    puts date
    delta = date > Date.today ? 0 : 7
    puts delta
    date + delta
  end
end
