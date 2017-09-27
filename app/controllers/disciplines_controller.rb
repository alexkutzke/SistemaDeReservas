class DisciplinesController < ApplicationController
    before_action :set_discipline, only: [:update, :destroy, :edit, :show]

    # GET /disciplines
    # GET /disciplines.json
    def index
        @disciplines = Discipline.paginate(:page => params[:page], per_page:5)
        @number = Discipline.count

        respond_to do |format|
            format.html
            format.json { render :json => Discipline.all.to_json(include: :department) }
        end
    end

    # GET /disciplines/1.json
    def show
        respond_to do |format|
            format.json { render :json => @discipline.to_json(include: :department) }
        end
    end

    # POST /disciplines/new
    def new
        @discipline = Discipline.new
    end

    # GET /disciplines/edit/1
    def edit
    end

    # POST /disciplines
    # POST /disciplines.json
    def create
        @discipline = Discipline.new(discipline_params)
        respond_to do |format|
            if @discipline.save
                format.html { redirect_to disciplines_path }
                format.json { render :json => @discipline.to_json(include: :department), status: :created }
            else
                format.html { render :new }
                format.json { render json: @discipline.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /disciplines/1
    # PATCH/PUT /disciplines/1.json
    def update
        respond_to do |format|
            if @discipline.update(discipline_params)
                format.html { redirect_to disciplines_path }
                format.json { render :json => @discipline.to_json(include: :department), status: :created }             
            else
                format.html { render :edit }
                format.json { render json: @discipline.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /disciplines/1
    # DELETE /disciplines/1.json
    def destroy
        @discipline.destroy
        respond_to do |format|
            format.html { redirect_to disciplines_path, notice: 'Discipline was successfully removed.' }
            format.json { head :no_content }
        end
    end

    def import
        csvFile = params[:file]
        
        error = true
        message = ""

        begin
            CSV.foreach(csvFile.path, headers: true) do |row|
                if row['Subject'].nil?
                    raise CustomError, "Incorrectly csv room file. Check the columns names"
                end
                @discipline = Discipline.new
                @array = row['Subject'].split(/-/)
                puts "split kk"
                puts @array[0]
                puts @array[1]
                @discipline.discipline_code = @array[0]
                @discipline.name = @array[1]
                puts 'jogoiu oje'
                puts 'here'
                @discipline.department_id = params[:department_id].blank? ? null : params[:department_id]
                puts @discipline.department_id
                puts 'after'
                error = false unless @discipline.save!
                puts error

            end
        rescue CustomError => e
            message << e.message
        rescue CSV::MalformedCSVError
            message = "Encolding error (use UTF-8)"
        rescue ActiveRecord::RecordInvalid => e
            if e.message == 'Validation failed: Room has already been taken'
                message = "Room has already been taken"
            end
        rescue Exception
            message = "Error to read csv file"
        end

        if error
            # @room = Room.new
            # @room.errors[:file] << message
            # render 'new'
            redirect_to new_discipline_path, :flash => { :error => message }
        else
            redirect_to disciplines_path
        end
    end

    private
    def set_discipline
        @discipline = Discipline.find(params[:id])
    end
    def discipline_params
        params.require(:discipline).permit(:name, :discipline_code, :department_id)
    end
end
