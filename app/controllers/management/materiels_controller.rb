class Management::MaterielsController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
  before_action :set_materiel, only: [:show, :edit, :update, :destroy]
  before_action :get_rooms, only: [:new, :edit]

  # GET /equipments
  # GET /equipments.json
  def index
    @materiels = Materiel.paginate(:page => params[:page], per_page:5)
    @number = Materiel.count

    respond_to do |format|
      format.html
      format.json { render :json => Materiel.all.to_json(include: :room) }
    end
  end

  # GET /equipments/new
  def new
    @materiel = Materiel.new
  end

  # GET /equipments/1.json
  def show
    respond_to do |format|
      format.json { render json: @materiel }
    end
  end

  # GET /equipments/edit/1
  def edit
  end

  # POST /equipments
  # POST /equipments.json
  def create
    @materiel = Materiel.new(materiel_params)
    respond_to do |format|
      if @materiel.save
        format.html { redirect_to management_materiels_path }
        format.json { render :json => @materiel.to_json(include: :room), status: :created }
      else
        format.html { render :new }
        format.json { render json: @materiel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipments/1
  # PATCH/PUT /equipments/1.json
  def update
    respond_to do |format|
      if @materiel.update(materiel_params)
        format.html { redirect_to management_materiels_path }
        format.json { render :json => @materiel.to_json(include: :room), status: :ok }
      else
        format.html { render :edit }
        format.json { render json:  @materiel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipments/1
  # DELETE /equipments/1.json
  def destroy
    @materiel.destroy
    respond_to do |format|
      format.html { redirect_to management_materiels_url, notice: 'Equipment was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_materiel
    @materiel = Materiel.find(params[:id])
  end

  def materiel_params
    params.require(:materiel).permit(:name, :patrimony, :classroom_id)
  end

  def get_rooms
    @rooms = Classroom.all
  end

  def set_session
    @session = 10
  end
end
