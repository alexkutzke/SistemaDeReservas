class RoomsController < ApplicationController
    before_action :set_room, only: [:edit, :update, :destroy]
    def index
        @rooms = Room.paginate(:page => params[:page], per_page: 5)
        @number = Room.number_of_records
    end

    def new
        @room = Room.new
    end

    def create
        @room = Room.new(room_params)
        @room.state = @room.state ? true : false
        if @room.save
            redirect_to rooms_path
        else
            render 'new'
        end
    end

    def edit
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
