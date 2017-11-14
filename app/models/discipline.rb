class Discipline < ApplicationRecord
  require 'csv'
  has_many :schedules
  belongs_to :department, optional: true
  validates :name, presence: true, length: { minimum: 3 }
  validates :discipline_code, presence: true, length: {minimum: 3 }

  # not required at SEPT
  # validates :department_id, presence: true,
  #                           length: {minimum: 1},
  #                           numericality: { only_integer: true }
  def as_json(options={})
    super(include: :department)
  end

  # import discipline csv file
  def self.import(file, department)
    begin
      if file.blank?
        raise CustomError, "Select a csv file"
      end
      Discipline.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row['Subject'].nil?
            raise CustomError, "Incorrectly csv discipline file. Check the columns names"
          end
          @array = row['Subject'].split(/-/)
          @discipline = Discipline.new
          @discipline.discipline_code = @array[0]
          @discipline.name = @array[1]
          @discipline.department_id = department.blank? ? nil : department
          if !@array[0].nil? && !@array[1].nil?
            if !@discipline.save! then
              raise ActiveRecord::Rollback
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
    rescue ActiveRecord::RecordInvalid => e
      @error = true
      @message = e.message
    rescue Exception
      @error = true
      @message = "Error to read csv file"
    end

    return @error, @message
  end

  def self.find_by_name(name, cod)
    Discipline.where(name: name, discipline_code: cod).first
  end
end
