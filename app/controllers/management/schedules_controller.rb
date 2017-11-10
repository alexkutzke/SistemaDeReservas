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

  def show
    respond_to do |format|
      format.json { render json: @schedule.to_json(:include => [:classroom, :user, :klass, :discipline], :id => @currentUser.id) }
      format.js
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.state = 1
    puts @schedule.state
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
    if @schedule.user_id == @currentUser.id
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
