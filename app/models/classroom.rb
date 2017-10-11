class Classroom < ApplicationRecord
  require 'csv'
  belongs_to :category
  validates :capacity, presence: true, length: { minimum: 1 }
  validates :building, presence: true, length: { minimum: 1 }
  validates :room, presence: true, uniqueness: true, length: { minimum: 1 }

  def as_json(options={})
    super(include: :category)
  end

  def self.import(file, category)
    begin
      Discipline.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row['place'].nil? || row['building'].nil? || row['capacity'].nil?
            raise CustomError, "Incorrectly csv room file. Check the columns names"
          end
          @classroom = Classroom.new
          @classroom.room = row['place']
          @classroom.building = row['building']
          if !(row['capacity'] !~ /\D/)
            raise CustomError, "Capacity column must have only numbers"
          end
          @classroom.capacity = row['capacity']
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
end
