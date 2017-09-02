class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    def index
        @rooms = Room.all
    end

    def show
    end

    def new
        @room = Room.new
    end

    def create
        @room = Room.new(room_params)
        @room.state = @room.state ? true : false
        if @room.save
            redirect_to @room
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        @room.state = @room.state ? false : true
        if @room.update(room_params)
            redirect_to @room
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
