class SchedulesController < ApplicationController
  # GET /reservas.json
  def index
    @schedule = Schedule.new
    @schedule.date_at = params[:start]
    @schedules = Schedule.where("date_at >= ? AND date_at <= ?", params[:start], params[:end])
    @schedules.each do |s|
      puts s.date_at
    end
    respond_to do |format|
      format.json { render :json => @schedules }
    end
  end
end
