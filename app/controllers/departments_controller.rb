class DepartmentsController < ApplicationController
    before_action :set_department, only: [:update, :destroy, :edit]
    def index
        @departments = Department.paginate(:page => params[:page], per_page:5)
        @number = Department.number_of_records
    end

    def new
        @department = Department.new
    end

    def edit
    end

    def create
        @department = Department.new(department_params)
        if @department.save
            redirect_to departments_path
        else
            render 'new'
        end
    end

    def update
        if @department.update(department_params)
            redirect_to departments_pat
        else
            render 'edit'
        end
    end

    def destroy
        @department.destroy
        redirect_to departments_path
    end

    private
    def set_department
        @department = Department.find(params[:id])
    end

    def department_params
        params.require(:department).permit(:name, :abbreviation, :code, :place)
    end
end