class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy]

    # GET /rooms
    # GET /rooms.json
    def index
        @rooms = Room.paginate(:page => params[:page], per_page: 5)
        @number = Room.count

        respond_to do |format|
            format.html
            format.json { render json: Room.all }
        end
    end

    # GET /rooms/new
    def new
        @room = Room.new
    end

    # GET /rooms/1.json
    def show
        respond_to do |format|
            format.json { render json: @room }
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
        if @room.save
            redirect_to rooms_path
        else
            render 'new'
        end
    end

    def update
        @room.state = @room.state ? false : true
        if @room.update(room_params)
            redirect_to rooms_path
        else
            render 'edit'
        end
    end

    def destroy
        @room.destroy
        redirect_to rooms_path
    end

    private
    def set_room
        @room = Room.find(params[:id])
    end

    def room_params
        params.require(:room).permit(:capacity, :place, :block, :category_id, :state)
    end
end
