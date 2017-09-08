class MaterielsController < ApplicationController
  before_action :set_materiel, only: [:edit, :update, :destroy]

    def index
        @materiels = Materiel.paginate(:page => params[:page], per_page:5)
        @number = Materiel.count
    end

    def new
        @materiel = Materiel.new
    end

    def edit
    end

    def create
        @materiel = Materiel.new(materiel_params)
        if @materiel.save
            redirect_to materiels_path
        else
            render 'new'
        end
    end

    def update
        if @materiel.update(materiel_params)
            redirect_to materiels_path
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
