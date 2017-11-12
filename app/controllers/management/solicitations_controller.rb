class Management::SolicitationsController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize, :set_states
  before_action :set_solicitation, only: [:edit]
  def index
    @solicitations = Schedule.order('start DESC').paginate(:page => params[:page], per_page:5)
    @number = @solicitations.count

    respond_to do |format|
      format.html
      format.json { render json: @solicitations.as_json()}
    end
  end

  def edit
  end

  private
  def set_solicitation
    @solicitation = Schedule.find(params[:id])
  end

  def set_session
    @session = 1
  end

  def set_states
    @states = ['Aguardando aprovação', 'Aprovado', 'Recusado', 'Cancelado']
  end

  def get_state(pos)
    return @states[pos-1]
  end
  helper_method :get_state
end
