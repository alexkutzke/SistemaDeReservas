class Management::SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :edit, :update, :destroy]

  # GET /sectors
  # GET /sectors.json
  def index
    @sectors = Sector.paginate(:page => params[:page], per_page: 5)
    @number = Sector.count

    respond_to do |format|
      format.html
      format.json { render :json => Sector.all}
    end
  end

  # GET /sectors/new
  def new
    @sector = Sector.new
  end

  # GET /sectors/1.json
  def show
    respond_to do |format|
      format.json { render :json =>  @sector }
    end
  end

  # GET /sectors/1/edit
  def edit
  end

  # POST /sectors
  # POST /sectors.json
  def create
    @sector = Sector.new(sector_params)
    respond_to do |format|
      if @sector.save
        format.html { redirect_to management_sectors_path }
        format.json { render :json =>  @sector }
      else
        format.html { render :new }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sectors/1
  # PATCH/PUT /sectors/1.json
  def update
    respond_to do |format|
      if @sector.update(sector_params)
        format.html { redirect_to management_sectors_path }
        format.json { render :json => @sector }
      else
        format.html { render :edit }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sectors/1
  # DELETE /sectors/1.json
  def destroy
    @sector.destroy
    respond_to do |format|
      format.html { redirect_to management_sectors_url, notice: 'Sector was successfully removed.' }
      format.json { head :no_content }
  end
  end

  private
  def set_sector
    @sector = Sector.find(params[:id])
  end

  def sector_params
    params.require(:sector).permit(:name)
  end
end
