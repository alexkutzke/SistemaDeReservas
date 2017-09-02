class MaterielsController < ApplicationController
  before_action :set_materiel, only: [:edit, :show, :update, :destroy]

    def index
        @materiels = Materiel.all
    end

    def new
        @materiel = Materiel.new
    end

    def edit
    end

    def show
    end

    def create
        @materiel = Materiel.new(materiel_params)
        if @materiel.save
            redirect_to @materiel
        else
            render 'new'
        end
    end

    def update
        if @materiel.update(materiel_params)
            redirect_to @materiel
        else
            render 'edit'
        end
    end

    def destroy
        @materiel.destroy
        redirect_to materiels_path
    end

    private
    def set_materiel
        @materiel = Materiel.find(params[:id])
    end

    def materiel_params
        params.require(:materiel).permit(:name, :patrimony, :room_id)
    end
end
