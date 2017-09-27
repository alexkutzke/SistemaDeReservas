class RoomsController < ApplicationController
    require 'csv'
    before_action :set_room, only: [:show, :edit, :update, :destroy]

    # GET /rooms
    # GET /rooms.json
    def index
        @rooms = Room.paginate(:page => params[:page], per_page: 5)
        @number = Room.count

        respond_to do |format|
            format.html
            format.json { render :json => Room.all.to_json(include: :category) }
        end
    end

    # GET /rooms/new
    def new
        @room = Room.new
    end

    # GET /rooms/1.json
    def show
        respond_to do |format|
            format.json { render :json =>  @room.to_json(include: :category) }
        end
    end

    # GET /rooms/edit/1
    def edit
    end

    # POST /rooms
    # POST /rooms.json
    def create
        @room = Room.new(room_params)
        @room.state = @room.state ? true : false
        respond_to do |format|
            if @room.save
                format.html { redirect_to rooms_path }
                format.json { render :json =>  @room.to_json(include: :category), status: :created }
            else
                # render new, buy change the url
                format.html { render :new }
                format.json { render json: @room.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /rooms/1
    # PATCH/PUT /rooms/1.json
    def update
        @room.state = @room.state ? false : true
        respond_to do |format|
            if @room.update(room_params)
                format.html { redirect_to rooms_path }
                format.json { render :json => @room.to_json(include: :category), status: :created }             
            else
                format.html { render :edit }
                format.json { render json: @room.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /rooms/1
    # DELETE /rooms/1.json
    def destroy
        @room.destroy
        respond_to do |format|
            format.html { redirect_to rooms_url, notice: 'Room was successfully removed.' }
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
                @room = Room.new
                @room.room = row['place']
                @room.building = row['building']
                if !(row['capacity'] !~ /\D/)
                    raise CustomError, "Capacity column must have only numbers" 
                end
                @room.capacity = row['capacity']
                @room.state = true
                @room.category_id = params[:category_id]
                error = false unless @room.save!

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
            redirect_to new_room_path, :flash => { :error => message }
        else
            redirect_to rooms_path
        end
    end

    private
    def set_room
        @room = Room.find(params[:id])
    end

    def room_params
        params.require(:room).permit(:capacity, :room, :building, :category_id, :state, :description, :responsible_person)
    end
end
