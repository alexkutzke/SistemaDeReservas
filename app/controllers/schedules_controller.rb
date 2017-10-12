class SchedulesController < ApplicationController
  # GET /schedules.json
  def index
    respond_to do |format|
      format.json { render :json => Schedule.all }
    end
  end
end
