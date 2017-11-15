class Classroom < ApplicationRecord
  require 'csv'
  belongs_to :category
  has_many :schedules
  validates :capacity, presence: true, length: { minimum: 1 }
  validates :building, presence: true, length: { minimum: 1 }
  validates :room, presence: true, uniqueness: true, length: { minimum: 1 }
  validates :category_id, presence: true, length: { minimum: 1 }, numericality: { only_integer: true }

  def as_json(options={})
    super(include: :category)
  end

  def room_capacity
    "#{room} - Capacidade: #{capacity}"
  end

  def self.import(file, category)
    begin
      if file.blank?
        raise CustomError, "Select a csv file"
      end
      Discipline.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row['Room'].nil? || row['Room Capacity'].nil? || row['Building'].nil?
            raise CustomError, "Incorrectly csv room file."
          end
          @classroom = Classroom.new
          @classroom.room = row['Room']
          @classroom.building = row['Building']
          if !(row['Room Capacity'] !~ /\D/)
            raise CustomError, "Capacity column must have only numbers"
          end
          @classroom.capacity = row['Room Capacity']
          @classroom.state = true
          if category.nil?
            raise CustomError, "Category is required"
          end
          @classroom.category_id = category
          if !@classroom.save! then
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
    rescue ActiveRecord::RecordInvalid => e
      @error = true
      @message = e.message
    rescue Exception
      @error = true
      @message = "Error to read csv file"
    end

    return @error, @message
  end

  private

  def self.find_by_name(room)
    Classroom.where(room: room).first
  end
end
