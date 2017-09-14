class StudentClassesController < ApplicationController
    before_action :set_student_class, only: [:edit, :update, :destroy]
  def index
    @studentClasses = StudentClass.paginate(:page => params[:page], per_page:5)
    @number = StudentClass.number_of_records
  end

  def new
    @studentClass = StudentClass.new
  end

  def edit
  end

  def create
    @studentClass = StudentClass.new(student_class_params)
    if @studentClass.save
        redirect_to student_classes_path
    else
        render 'new'
    end
  end

  def update
    if @studentClass.update(student_class_params)
        redirect_to student_classes_path
    else
        render 'edit'
    end
  end

  def destroy
    @studentClass.destroy
    redirect_to student_classes_path
  end

  private
  def set_student_class
    @studentClass = StudentClass.find(params[:id])
  end

  def student_class_params
    params.require(:student_class).permit(:name, :period_id)
  end
end
