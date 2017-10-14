class Management::CategoriesController < ApplicationController
  before_action :authenticate_user!, :get_current_user, :get_permission_from_user
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :update, :destroy, :edit]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(:page => params[:page], per_page:5)
    @number = Category.count

    respond_to do |format|
      format.html
      format.json { render json: Category.all }
    end
  end

  # POST /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1.json
  def show
    respond_to do |format|
      format.json { render json: @category }
    end
  end

  # GET /categories/edit/1
  def edit
  end

  # POST /categories
  # PODT /categories.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to management_categories_path }
        format.json { render json:  @category, status: :created }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to management_categories_path }
        format.json { render json: @category, status: :ok }
      else
        format.html { render :edit }
        format.json { render json:  @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to management_categories_url, notice: 'Category was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
