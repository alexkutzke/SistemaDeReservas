class Management::SchedulesController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @event = Event.new
    if params.has_key?(:classroom)
      @events = Event.where(start: params[:start]..params[:end], classroom_id: params[:classroom])
    else
      @events = Event.where(start: params[:start]..params[:end])
    end
    @classrooms = Classroom.where(state: true)
    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @event.to_json(:include => [:classroom, :user, :klass, :discipline]) }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def set_session
      @session = 0
    end
end
