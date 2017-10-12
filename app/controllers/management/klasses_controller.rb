class Management::KlassesController < ApplicationController
  before_action :set_klass, only: [:show, :edit, :update, :destroy]
  before_action :get_periods, only: [:new, :edit, :import]

  # GET /classes
  # GET /classes.json
  def index
    @klasses = Klass.paginate(:page => params[:page], per_page:5)
    @number = Klass.count

    respond_to do |format|
        format.html
        format.json { render :json => Klass.all.to_json(include: :period) }
    end
  end

  # GET /classes/new
  def new
    @klass = Klass.new
  end

  # GET /classes/1.json
  def show
      respond_to do |format|
          format.json { render json: @klass }
      end
  end

  # GET /classes/edit/1
  def edit
  end

  # POST /classes
  # POST /classes.json
  def create
    @klass = Klass.new(klass_params)
    respond_to do |format|
          if @klass.save
              format.html { redirect_to management_klasses_path }
              format.json { render :json => @klass.to_json(include: :period), status: :created }
          else
              format.html { render :new }
              format.json { render json: @klass.errors, status: :unprocessable_entity }
          end
      end
  end

  # PATCH/PUT /classes/1
  # PATCH/PUT /classes/1.json
  def update
    respond_to do |format|
          if @klass.update(klass_params)
              format.html { redirect_to management_klasses_path }
              format.json { render :json => @klass.to_json(include: :period), status: :ok }
          else
              format.html { render :edit }
              format.json { render json:  @klass.errors, status: :unprocessable_entity }
          end
      end
  end

  # DELETE /classes/1
  # DELETE /classes/1.json
  def destroy
    @klass.destroy
    respond_to do |format|
          format.html { redirect_to management_klasses_url, notice: 'Class was successfully removed.' }
          format.json { head :no_content }
      end
  end

  def import
    @array = Klass.import(params[:file], params[:period_id])
    if @array[0]
      redirect_to new_management_klass_path, :flash => { :error => @array[1] }
    else
      redirect_to management_klasses_path
    end
  end

  private
  def set_klass
    @klass = Klass.find(params[:id])
  end

  def klass_params
    params.require(:klass).permit(:name, :period_id)
  end

  def get_periods
    @periods = Period.all
  end
end
