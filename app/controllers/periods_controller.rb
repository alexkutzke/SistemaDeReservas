class PeriodsController < ApplicationController
    def index
        @periods = Period.all
    end

    def show
        @period = Period.find(params[:id])
    end

    def new
        @period = Period.new
    end
    def create
        @period = Period.new(period_params)
        if @period.save
            redirect_to @period
        else
            render 'new'
        end
    end

    private
    def period_params
        params.require(:period).permit(:yare, :semester, :start_date, :end_date, :state)
    end
end
