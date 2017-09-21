class RoomsController < ApplicationController
    require 'csv'
    before_action :set_room, only: [:show, :edit, :update, :destroy]

    # GET /rooms
    # GET /rooms.json
    def index
        @rooms = Room.paginate(:page => params[:page], per_page: 5)
        @number = Room.count

        @all = Room.all
        @all.each do |s|
            puts s.room
        end

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
        
        csvFile = params[:room][:Arquivo]#[:file]
        
        deu_certo = true

        begin
            CSV.foreach(csvFile.path, headers: true) do |row|
                @room = Room.new
                @room.room = row['place']
                @room.building = row['building']
                @room.capacity = row['capacity']
                @room.state = true
                @room.category_id = params[:room][:category_id]
                puts @room
                puts @room.room
                deu_certo = false unless @room.save
            end
        rescue Exception
            deu_certo = false
            @room = Room.new
            @room.errors[:file] << "- Error to open csv file"
        end

        if deu_certo
            redirect_to rooms_path
        else
            render 'new'
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
