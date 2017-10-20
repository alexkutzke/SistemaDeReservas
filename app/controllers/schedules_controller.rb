class SchedulesController < ApplicationController
  # GET /reservas.json
  def index
    @schedules = Schedule.where(start_at: params[:start]..params[:end])
    # @schedules = Schedule.schedules_between(params[:start],params[:end])
    # puts @schedules.count
    # respond_to do |format|
    #   format.json { render :json => @schedules.to_json(:include => [:classroom, :user, :klass, :discipline]) }
    # end
  end
end
