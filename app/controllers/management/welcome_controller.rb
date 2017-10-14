class Management::WelcomeController < ApplicationController
  before_action :set_session, :get_current_user, :get_permissions_from_user, :authorize
  def index
  end

  private
  def set_session
    @session = 0
  end
end
