class DisciplinesController < ApplicationController
    def index
        @disciplines = Discipline.paginate(:page => params[:page], per_page:5)
        @number = Discipline.number_of_records
    end

    def show
        @discipline = Discipline.find(params[:id])
    end

    def new
        @discipline = Discipline.new
    end

    def edit
        @discipline = Discipline.find(params[:id])
    end

    def create
        @discipline = Discipline.new(discipline_params)
        if @discipline.save
            redirect_to disciplines_path
        else
            render 'new'
        end
    end

    def update
        @discipline = Discipline.find(params[:id])
        if @discipline.update(discipline_params)
            redirect_to disciplines_path
        else
            render 'edit'
        end
    end

    def destroy
        @discipline = Discipline.find(params[:id])
        @discipline.destroy
        redirect_to disciplines_path
    end

    private
    def discipline_params
        params.require(:discipline).permit(:name, :discipline_code, :department_id)
    end
end
