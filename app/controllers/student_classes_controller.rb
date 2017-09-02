class StudentClassesController < ApplicationController
    before_action :set_student_class, only: [:edit, :update, :show, :destroy]
  def index
    @studentClasses = StudentClass.all
  end

  def new
    @studentClass = StudentClass.new
  end

  def edit
  end

  def show
  end

  def create
    @studentClass = StudentClass.new(student_class_params)
    if @studentClass.save
        redirect_to @studentClass
    else
        render 'new'
    end
  end

  def update
    if @studentClass.update(student_class_params)
        redirect_to @studentClass
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
