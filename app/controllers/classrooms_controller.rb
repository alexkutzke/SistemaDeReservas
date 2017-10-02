class ClassroomsController < ApplicationController
    require 'csv'
    before_action :set_room, only: [:show, :edit, :update, :destroy]

    # GET /classrooms
    # GET /classrooms.json
    def index
        @classrooms = Classroom.paginate(:page => params[:page], per_page: 5)
        @number = Classroom.count

        respond_to do |format|
            format.html
            format.json { render :json => Classroom.all.to_json(include: :category) }
        end
    end

    # GET /classrooms/new
    def new
        @classroom = Classroom.new
    end

    # GET /classrooms/1.json
    def show
        respond_to do |format|
            format.json { render :json =>  @classroom.to_json(include: :category) }
        end
    end

    # GET /classrooms/edit/1
    def edit
    end

    # POST /classrooms
    # POST /classrooms.json
    def create
        @classroom = Classroom.new(classroom_params)
        @classroom.state = @classroom.state ? true : false
        respond_to do |format|
            if @classroom.save
                format.html { redirect_to classrooms_path }
                format.json { render :json =>  @classroom.to_json(include: :category), status: :created }
            else
                # render new, buy change the url
                format.html { render :new }
                format.json { render json: @classroom.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /classrooms/1
    # PATCH/PUT /classrooms/1.json
    def update
        @classroom.state = @classroom.state ? false : true
        respond_to do |format|
            if @classroom.update(classroom_params)
                format.html { redirect_to classrooms_path }
                format.json { render :json => @classroom.to_json(include: :category), status: :created }             
            else
                format.html { render :edit }
                format.json { render json: @classroom.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /classrooms/1
    # DELETE /classrooms/1.json
    def destroy
        @room.destroy
        respond_to do |format|
            format.html { redirect_to classroom_url, notice: 'Classroom was successfully removed.' }
            format.json { head :no_content }
        end
    end

    def import
        
        csvFile = params[:file]
        
        error = true
        message = ""

        begin
            CSV.foreach(csvFile.path, headers: true) do |row|
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
                @classroom.category_id = params[:category_id]
                error = false unless @classroom.save!

            end
        rescue CustomError => e
            message << e.message
        rescue CSV::MalformedCSVError
            message = "Encolding error (use UTF-8)"
        rescue ActiveRecord::RecordInvalid => e
            error = true
            if e.message == 'Validation failed: Room has already been taken'
                message = "Room has already been taken"
            end
        rescue Exception
            message = "Error to read csv file"
        end

        if error
            # @classroom = Classroom.new
            # @classroom.errors[:file] << message
            # render 'new'
            redirect_to new_classroom_path, :flash => { :error => message }
        else
            redirect_to classrooms_path
        end
    end

    private
    def set_room
        @classroom = Classroom.find(params[:id])
    end

    def classroom_params
        params.require(:room).permit(:capacity, :room, :building, :category_id, :state, :description, :responsible_person)
    end
end
