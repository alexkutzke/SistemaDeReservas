class PeriodsController < ApplicationController
    def index
        @periods = Period.all
    end
    def new
        @period = Period.new
    end
    def create
        @period = Period.create(period_params)
        if @period.save
            redirect_to period_path
        else
            render 'new'
        end
    end

    private
    def period_params
        params.require(:period).permit(:yare, :semester, :start_date, :end_date, :state)
    end
end
