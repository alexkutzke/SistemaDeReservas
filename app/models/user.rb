class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :role
  has_many :schedules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :cpf, presence: true, uniqueness: true,length: { minimum: 11, maximum: 11 }
  validates :registration_number, presence: true

  private
  def self.find_by_name(name)
    User.where(name: name).first
  end

  def self.import(file, role)
    begin
      if file.blank?
        raise CustomError, "Select a csv file"
      end
      User.transaction do
        CSV.foreach(file.path, headers: true) do |row|
          if row['NOME'].nil? || row['EMAILS'].nil? || row['CPF'].nil? || row['MATRÍCULA'].nil?
            raise CustomError, "Incorrectly csv user file"
          end
          @user = User.new
          @user.name = row['NOME']
          @user.email = row['EMAILS']
          @user.cpf = row['CPF']
          @user.cpf = @user.cpf.gsub!('.', '')
          @user.cpf = @user.cpf.gsub!('-', '')
          puts @user.cpf
          @user.registration_number = row['MATRÍCULA']
          @user.password = @user.cpf
          @user.password_confirmation = @user.cpf
          if role.nil?
            raise CustomError, "Role is required"
          end
          @user.role_id = role
          @find = User.where("email = ? OR cpf = ?", @user.email, @user.cpf)
          if @find.empty?
            if !@user.save! then
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
end
