class Klass < ApplicationRecord
  require 'csv'
  has_many :schedules
  belongs_to :period
  validates :name, presence: true, length: { minimum: 3 }
  validates :period_id, presence: true, length: { minimum: 1 }, numericality: { only_integer: true }

  def as_json(options={})
      super(include: :period)
  end

  def self.import(file, period)
    begin
      if file.blank?
        raise CustomError, "Select a csv file"
      end
      Klass.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row['Students Sets'].nil?
            raise CustomError, "Incorrectly csv klass file"
          end
          @klass = Klass.new
          @klass.name = row['Students Sets']
          if period.nil?
            raise CustomError, "Period is required"
          end
          @klass.period_id = period
          @found = Klass.find_by(name: @klass.name)
          if @found.nil? then
            if !@klass.save! then
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
    rescue Exception => e
      @error = true
      @message = "Error to read csv file"
    end

    return @error, @message
  end

  def self.find_by_name(name, period)
    Klass.where(name: name, period_id: period).first
  end
end
