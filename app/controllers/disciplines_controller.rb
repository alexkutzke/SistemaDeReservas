class DisciplinesController < ApplicationController
    before_action :set_discipline, only: [:update, :destroy, :edit, :show]
    def index
        @disciplines = Discipline.paginate(:page => params[:page], per_page:5)
        @number = Discipline.number_of_records

        respond_to do |format|
            format.html
            format.json {render json: Discipline.all}
        end
    end

    def show
        respond_to do |format|
            format.html
            format.json {render json: @discipline}
        end
    end

    def new
        @discipline = Discipline.new
    end

    def edit
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
        if @discipline.update(discipline_params)
            redirect_to disciplines_path
        else
            render 'edit'
        end
    end

    def destroy
        @discipline.destroy
        redirect_to disciplines_path
    end

    private
    def set_discipline
        @discipline = Discipline.find(params[:id])
    end
    def discipline_params
        params.require(:discipline).permit(:name, :discipline_code, :department_id)
    end
end
