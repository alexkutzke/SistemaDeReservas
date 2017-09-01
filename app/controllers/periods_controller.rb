class PeriodsController < ApplicationController
    before_action :set_period, only: [:show, :edit, :update, :destroy]

    def index
        @periods = Period.all
    end

    def show
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

    def update
        if @perdio.update(period_params)
            redirect_to @period
        else
            render 'edit'
        end
    end

    def destroy
        @period.destroy
        redirect_to periods_path
    end

    private
    def set_period
        @period = Period.find(params[:id])
    end

    def period_params
        params.require(:period).permit(:year, :semester, :start_date, :end_date, :state)
    end
end
