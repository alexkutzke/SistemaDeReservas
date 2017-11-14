class Management::ClassroomsController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
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
        format.html { redirect_to management_classrooms_path }
        format.json { render :json =>  @classroom.to_json(include: :category), status: :created }
      else
        puts "format #{format}"
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
        format.html { redirect_to management_classrooms_path }
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
      format.html { redirect_to management_classroom_url, notice: 'Classroom was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def import
    @array = Classroom.import(params[:file], params[:category_id])
    if @array[0]
      redirect_to new_management_classroom_path, :flash => { :error => @array[1] }
    else
      redirect_to management_classrooms_path
    end
  end

  private
  def set_room
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:capacity, :room, :building, :category_id, :state, :description, :responsible_person)
  end

  def set_session
    @session = 7
  end
end
