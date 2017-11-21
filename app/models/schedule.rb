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
  def is_not_overlap(from, to, classroom_id)
    overlaps = Schedule.where('(start <= ? AND end >= ?) AND classroom_id = ? AND (state = ? OR state = ?)', to-1, from+1, classroom_id, 1, 2)
    puts "is empty = #{overlaps.empty?}"
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
  def self.import(file, period_id)
    days_of_week = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    @schedule = Schedule.new
    size = CSV.read(file.path).length-1
    puts "size #{size}"
    first = false
    pos = 0;
    begin
      if file.blank?
        raise CustomError, "Select a csv file"
      end
      Schedule.transaction do
        CSV.foreach(file.path, headers: true).with_index(1) do |row, line|
          puts "line #{line}"
          if row['Activity Id'].nil? || row['Day'].nil? || row['Hour'].nil? || row['Students Sets'].nil? || row['Subject'].nil? ||
                            row['Teachers'].nil? || row['Room'].nil?
            raise CustomError, "Incorrectly csv timetable file"
          end

          id = (row['Activity Id'][/\d+/]).to_i

          klass = Klass.find_by_name(row['Students Sets'], period_id)
          raise CustomError, "Klass '#{row['Students Sets']}' not found" if klass.nil?

          @array = row['Subject'].split(/-/)
          discipline = Discipline.find_by_name(@array[1], @array[0])
          raise CustomError, "Discipline '#{@array[1]}' and code, #{@array[0]} not found" if discipline.nil?

          classroom = Classroom.find_by_name(row['Room'])
          raise CustomError, "Classroom '#{row['Room']}' not found" if classroom.nil?

          period = Period.find(period_id)
          raise CustomError, "Period not found" if period.nil?

          user = User.find_by_name(row['Teachers'])

          if row['Day'] != 'Sábado'
            day = (row['Day'][/\d+/]).to_i - 1
          else
            day = 6
          end

          if period.start_date.wday != day
            next_date = period.start_date.days_since(day-1)
          else
            next_date = period.start_date
          end
          next_date = "#{next_date} " + row['Hour']
          next_date = next_date.to_datetime

          if id == pos
            @schedule.end = next_date + 1.hour
            if !@schedule.is_not_overlap(@schedule.start, @schedule.end, @schedule.classroom_id) || !@schedule.save!
              raise ActiveRecord::Rollback
            end
            if size == line
              Schedule.replicate_schedule(@schedule, period, klass, discipline, user, classroom)
            end
          else
            if first
              Schedule.replicate_schedule(@schedule, period, klass, discipline, user, classroom)
            end
            @schedule = Schedule.set_schedule(klass, discipline, user, classroom, next_date, next_date + 1.hour)
            pos = id
            if !@schedule.is_not_overlap(@schedule.start, @schedule.end, @schedule.classroom_id) || !@schedule.save
              raise ActiveRecord::Rollback
            end
            first = true
            if size == line
              Schedule.replicate_schedule(@schedule, period, klass, discipline, user, classroom)
            end
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

  def self.set_schedule(klass, discipline, user, classroom, start_date, end_date)
    @schedule = Schedule.new
    @schedule.klass_id = klass.id
    @schedule.discipline_id = discipline.id
    @schedule.user_id = user.nil? ? :null : user.id
    @schedule.classroom_id = classroom.id
    @schedule.skip_user_validation = true # skip user validation
    @schedule.start = start_date
    @schedule.end = end_date
    @schedule.color = "#969898"
    @schedule.reservation = false
    @schedule.state = 2
    return @schedule
  end

  def self.replicate_schedule(schedule, period, klass, discipline, user, classroom)
    period.end_date = period.end_date + 1.day
    schedule.start = schedule.start + 7.days
    schedule.end = schedule.end + 7.days
    while (schedule.start <= period.end_date) do # replica por semana
      @replicate = Schedule.set_schedule(klass, discipline, user, classroom, schedule.start, schedule.end)
      if !@replicate.is_not_overlap(@replicate.start, @replicate.end, @replicate.classroom_id) || !@replicate.save
        raise ActiveRecord::Rollback
      end
      schedule.start = schedule.start + 7.days
      schedule.end = schedule.end + 7.days
    end
  end
end
