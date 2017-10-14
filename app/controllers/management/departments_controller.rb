class Management::DepartmentsController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
  before_action :set_department, only: [:show, :update, :destroy, :edit]
  before_action :get_departments, only: [:new, :edit]

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.paginate(:page => params[:page], per_page:5)
    @number = Department.count
    respond_to do |format|
      format.html
      format.json { render json: Department.all }
    end
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1.json
  def show
    respond_to do |format|
      format.json { render json: @department }
    end
  end

  # GET /departments/edit/1
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    respond_to do |format|
      if @department.save
        format.html { redirect_to management_departments_path }
        format.json { render json:  @department, status: :created}
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to management_departments_path }
        format.json { render json: @department, status: :ok }
      else
        format.html { render :edit }
        format.json { render json:  @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to management_departments_url, notice: 'Department was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :abbreviation, :code, :place)
  end

  def get_departments
    @departments = Department.all
  end

  def set_session
    @session = 5
  end
end
