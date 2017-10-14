class Management::SchedulesController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
  def index
  end
  def set_session
    @session = 0
  end
end
