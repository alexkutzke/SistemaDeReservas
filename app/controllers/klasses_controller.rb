class KlassesController < ApplicationController
    before_action :set_klass, only: [:show, :edit, :update, :destroy]

    # GET /classes
    # GET /classes.json
    def index
      @klasses = Klass.paginate(:page => params[:page], per_page:5)
      @number = Klass.count

      respond_to do |format|
          format.html
          format.json { render :json => Klass.all.to_json(include: :period) }
      end
    end

    # GET /classes/new
    def Klass
      @klass = StudentClass.new
    end

    # GET /classes/1.json
    def show
        respond_to do |format|
            format.json { render json: @klass }
        end
    end

    # GET /classes/edit/1
    def edit
    end

    # POST /classes
    # POST /classes.json
    def create
      @klass = StudentClass.new(klass_params)
      respond_to do |format|
            if @klass.save
                format.html { redirect_to klasses_path }
                format.json { render :json => @klass.to_json(include: :period), status: :created }
            else
                format.html { render :new }
                format.json { render json: @klass.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /classes/1
    # PATCH/PUT /classes/1.json
    def update
      respond_to do |format|
            if @klass.update(student_class_params)
                format.html { redirect_to klasses_path }
                format.json { render :json => @klass.to_json(include: :period), status: :ok }
            else
                format.html { render :edit }
                format.json { render json:  @klass.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /classes/1
    # DELETE /classes/1.json
    def destroy
      @klass.destroy
      respond_to do |format|
            format.html { redirect_to klasses_url, notice: 'Class was successfully removed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_klass
      @studentClass = Klass.find(params[:id])
    end

    def klass_params
      params.require(:student_class).permit(:name, :period_id)
    end
end
