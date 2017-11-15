class Management::SchedulesController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
  before_action :set_schedule, only: [:show, :update, :destroy]

  def index
    @schedule = Schedule.new
    if params.has_key?(:classroom)
      @schedules = Schedule.where(start: params[:start]..params[:end], classroom_id: params[:classroom])
    else
      @schedules = Schedule.where(start: params[:start]..params[:end])
    end
    @classrooms = Classroom.where(state: true)
    respond_to do |format|
      format.html
      format.json { render json: @schedules.as_json()}
    end
  end

  def new
    @schedule = Schedule.new
  end

  def show
    respond_to do |format|
      if @currentUser.role_id == 1 || @currentUser.role_id == 2
        format.json { render json: @schedule.to_json(:admin => true) }
      else
        format.json { render json: @schedule.to_json(:id => @currentUser.id) }
      end
      format.js
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)
    # case user not admin or academic coordenation, set current user id to schedule
    @schedule.user_id = @currentUser.id if @currentUser.role_id != 1 || @currentUser.role_id == 2
    respond_to do |format|
      if @schedule.is_not_overlap( @schedule.start, @schedule.end) && @schedule.validates() &&  @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created }
      else
        format.html { render :new }
        format.json { render :json => {:errors => @schedule.errors}, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    if @schedule.user_id == @currentUser.id || @currentUser.id == 1 || @currentUser.id == 2
      puts 'here'
      @schedule.destroy
    end

    respond_to do |format|
      if @schedule.destroyed
        format.json { head :no_content }
      else
        format.json { render :json => {:errors => "Schedule was not removed"}, :status => 500 }
      end
    end
  end

  def import
    @array = Schedule.import(params[:file], params[:period_id])
    if @array[0]
      redirect_to new_management_schedule_path, :flash => { :error => @array[1] }
    else
      redirect_to management_schedules_path
    end
  end

  private
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_session
      @session = 0
    end

    def schedule_params
      params.require(:schedule).permit(:title, :start, :end, :frequency, :user_id, :classroom_id, :discipline_id, :klass_id)
    end
end
