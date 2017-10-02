class Discipline < ApplicationRecord
  belongs_to :department, optional: true

  validates :name, presence: true, length: { minimum: 3}

  validates :discipline_code, presence: true, length: {minimum: 3}

  # not required at SEPT
  # validates :department_id, presence: true,
  #                           length: {minimum: 1},
  #                           numericality: { only_integer: true }
  def as_json(options={})
    super(include: :department)
  end

  # import discipline csv file
  def self.import(file)
    error = true
    message = "Error to read csv file"
    begin
      Discipline.transaction do
        CSV.foreach(csvFile.path, headers: true) do |row|
          if row['Subject'].nil?
            raise Exception, "Incorrectly csv room file. Check the columns names"
          end
          @discipline = Discipline.new
          @discipline.discipline_code = @array[0]
          @discipline.name = @array[1]
          @discipline.department_id = params[:department_id].blank? ? nil : params[:department_id]
          if !@array[0].nil? && !@array[1].nil?
            if @discipline.save! then                          
              error = false 
            else   
              raise ActiveRecord::Rollback
            end
          end
        end
      end
    rescue CSV::MalformedCSVError
      message = "Encolding error (use UTF-8)"
    rescue ActiveRecord::RecordInvalid => e
      message = e.message
    rescue Exception => e
      message = e.message
    end
    
    if error
      redirect_to new_discipline_path, :flash => { :error => message }
    else
      redirect_to disciplines_path
    end
  end
end
