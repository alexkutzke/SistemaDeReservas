class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.paginate(:page => params[:page], per_page:5)
    @number = Period.count

    respond_to do |format|
        format.html
        format.json { render json: Period.all }
    end
  end

  # GET /periods/new
  def new
    @period = Period.new
  end

  # GET /periods/1.json
  def show
    respond_to do |format|
      format.json { render json: @period }
    end
  end

  # GET /periods/edit/1
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)
    @period.state = @period.state ? true : false
    respond_to do |format|
      if @period.save
        format.html { redirect_to periods_path }
        format.json { render json:  @period, status: :created }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    @period.state = @period.state ? false : true
    respond_to do |format|
      if @period.update(period_params)
        format.html { redirect_to periods_path }
        format.json { render json: @period, status: :ok }
      else
        format.html { render :edit }
        format.json { render json:  @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_period
    @period = Period.find(params[:id])
  end

  def period_params
    params.require(:period).permit(:state, :name, :start_date, :end_date)
  end
end
