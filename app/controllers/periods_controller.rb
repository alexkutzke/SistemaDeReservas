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
        @period.state = @period.state ? true : false
        if @period.save
            redirect_to @period
        else
            render 'new'
        end
    end

    def update
        @period.state = @period.state ? false : true
        if @period.update(period_params)
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
        params.require(:period).permit(:state, :year, :semester, :start_date, :end_date)
    end
end
