class Management::WelcomeController < ApplicationController
  before_action :set_session, :get_current_user, :get_permissions_from_user, :authorize
  def index
    @classrooms = Classroom.where(state: true)
    @schedule = Schedule.new
  end

  private
  def set_session
    @session = 0
  end
end
