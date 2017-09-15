class StudentClassesController < ApplicationController
  before_action :set_student_class, only: [:show, :edit, :update, :destroy]

    # GET /classes
    # GET /classes.json
    def index
      @studentClasses = StudentClass.paginate(:page => params[:page], per_page:5)
      @number = StudentClass.count

      respond_to do |format|
          format.html
          format.json { render :json => StudentClass.all.to_json(include: :period) }
      end
    end

    # GET /classes/new
    def new
      @studentClass = StudentClass.new
    end

    # GET /classes/1.json
    def show
        respond_to do |format|
            format.json { render json: @studentClass }
        end
    end

    # GET /classes/edit/1
    def edit
    end

    # POST /classes
    # POST /classes.json
    def create
      @studentClass = StudentClass.new(student_class_params)
      respond_to do |format|
            if @studentClass.save
                format.html { redirect_to student_classes_path }
                format.json { render :json => @studentClass.to_json(include: :period), status: :created }
            else
                format.html { render :new }
                format.json { render json: @studentClass.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /classes/1
    # PATCH/PUT /classes/1.json
    def update
      respond_to do |format|
            if @studentClass.update(student_class_params)
                format.html { redirect_to student_classes_path }
                format.json { render :json => @studentClass.to_json(include: :period), status: :ok }
            else
                format.html { render :edit }
                format.json { render json:  @studentClass.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /equipments/1
    # DELETE /equipments/1.json
    def destroy
      @studentClass.destroy
      respond_to do |format|
            format.html { redirect_to student_classes_url, notice: 'Class was successfully removed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_student_class
      @studentClass = StudentClass.find(params[:id])
    end

    def student_class_params
      params.require(:student_class).permit(:name, :period_id)
    end
end
