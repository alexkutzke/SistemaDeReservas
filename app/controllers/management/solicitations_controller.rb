class Management::SolicitationsController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize, :set_states
  before_action :set_solicitation, only: [:edit, :approve, :refuse, :cancel]

  def index
    if @currentUser.id == 1 ||  @currentUser.id == 2
      @solicitations = Schedule.order('start DESC').paginate(:page => params[:page], per_page:5)
    else
      @solicitations = Schedule.where(user_id: @currentUser.id).order('start DESC').paginate(:page => params[:page], per_page:5)
    end
    @number = @solicitations.count

    respond_to do |format|
      format.html
      format.json { render json: @solicitations.as_json()}
    end
  end

  def edit
  end

  def approve
    respond_to do |format|
      if @solicitation.update_attributes(:state => 2, :color => "#16a086")
        format.html { redirect_to management_solicitations_path}
        format.json { render json: @solicitations.as_json()}
      else
        format.html { render :index, notice: 'Schedule was not approve. Try again later.' }
        format.json { render json: @solicitations.errors}
      end
    end
  end

  def refuse
    respond_to do |format|
      if @solicitation.update_attribute(:state, 3)
        format.html { redirect_to management_solicitations_path}
        format.json { render json: @solicitations.as_json()}
      else
        format.html { render :index, notice: 'Schedule was not refused. Try again later.' }
        format.json { render json: @solicitations.errors}
      end
    end
  end

  def cancel
    respond_to do |format|
      if @solicitation.update_attribute(:state, 4)
        format.html { redirect_to management_solicitations_path}
        format.json { render json: @solicitations.as_json()}
      else
        format.html { render :index, notice: 'Schedule was not canceled. Try again later.' }
        format.json { render json: @solicitations.errors}
      end
    end
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
