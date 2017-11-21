class Management::UsersController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :authorize
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /usuarios
  # GET /usuarios.json
  def index
    @users = User.paginate(:page => params[:page], per_page: 30)
    @number = User.count

    respond_to do |format|
      format.html
      format.json { render :json => User.all}
    end
  end

  # GET /usuarios/new
  def new
    @user = User.new
  end

  # GET /usuarios/1.json
  def show
    respond_to do |format|
      format.json { render :json =>  @user }
    end
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @user = User.new(user_params)
    @user.password = @user.cpf
    @user.password_confirmation = @user.cpf
    respond_to do |format|
      if @user.save
        format.html { redirect_to management_users_path }
        format.json { render :json =>  @user }
      else
        format.html { render :controller => 'users', :action =>'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    if params[:user][:encrypted_password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:encrypted_password)
      params[:user].delete(:password_confirmation)
    else
      @user.password = params[:user][:encrypted_password]
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to management_users_path }
        format.json { render :json => @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    respond_to do |format|
      if @user.id != @currentUser.id && @user.destroy
        format.html { redirect_to  management_users_url, notice: 'User was successfully removed.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    @array = User.import(params[:file], params[:role_id])
    if @array[0]
      redirect_to new_management_user_path, :flash => { :error => @array[1] }
    else
      redirect_to management_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :cpf, :phone_number, :role_id, :registration_number)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_session
    @session = 3
  end
end
