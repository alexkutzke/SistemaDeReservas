class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :get_roles, only: [:new, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page], per_page: 5)
    @number = User.count

    respond_to do |format|
      format.html
      format.json { render :json => User.all}
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1.json
  def show
    respond_to do |format|
      format.json { render :json =>  @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password = user_params[:encrypted_password]
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path }
        format.json { render :json =>  @user }
      else
        format.html { render :controller => 'users', :action =>'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path }
        format.json { render :json => @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :password_confirmation, :cpf, :phone_number, :role_id)
  end

  def set_user
    @user = User.find(param[:id])
  end

  def get_roles
    @roles = Role.all
  end
end
