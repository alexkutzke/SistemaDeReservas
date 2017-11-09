class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show]
  # GET /reservas.json
  def index
    @schedule = Schedule.new
    if params.has_key?(:by_day)
      @schedules = Schedule.where(start: params[:start]..params[:end], classroom_id: params[:classroom])
    elsif params.has_key?(:classroom) && !params.has_key?(:by_day)
      @schedules = Schedule.where(start: params[:start]..params[:end], classroom_id: params[:classroom])
    else
      @schedules = Schedule.where(start: params[:start]..params[:end])
    end
    @classrooms = Classroom.where(state: true)
    respond_to do |format|
      format.html
      format.json { render json: @schedules }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @schedule.to_json(:include => [:classroom, :user, :klass, :discipline]) }
    end
  end

  private
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
