class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :encrypted_password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :cpf, :role_id])
  end

  protected
  def get_current_user
    @currentUser = User.find(current_user.id)
  end

  def get_permissions_from_user
    Permission.where(role_id: @currentUser.role_id, session: @session).each do |p|
      @permission = Permission.find(p.id)
    end
  end

  def policy
    Policy.new(@currentUser,@permission)
  end

  def authorize
    redirect_to management_schedules_path unless policy().public_send(params[:action] + "?")
  end
end
