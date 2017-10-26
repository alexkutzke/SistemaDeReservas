class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :encrypted_password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :cpf, :role_id])
  end

  def get_current_user
    @arraySession = { schedule: 0, solicitation: 1, role: 2, user: 3, sector: 4, department: 5, category: 6, classroom: 7,  discipline: 8, klass: 9, materiel: 10, period: 11}
    @currentUser = User.find(current_user.id)
  end

  def after_sign_in_path_for(resource)
    management_schedules_path # Or :prefix_to_your_route
  end

  def get_permissions_from_user
    Permission.where(role_id: @currentUser.role_id, session: @session).each do |p|
      @permission = Permission.find(p.id)
    end
  end

  def policy
    Policy.new(@permission)
  end

  def authorize
    controllers = params[:controller].split("/")
    permission = policy.public_send(params[:action] + "?")
    if !permission
      if params[:action] == 'new' || params[:action] == 'edit' || params[:action] == 'destroy'
        redirect_to send("management_#{controllers[1]}_path")
      elsif params[:action] == 'index' && permission
        redirect_to send("management_#{controllers[1]}_path")
      else
        redirect_to management_schedules_path
      end
    end
  end


  # required send session id or session symbol
  def can(action, session)
    @session = @arraySession[session]; get_permissions_from_user
    policy.public_send("#{action}?")
  end

  helper_method :can, :get_current_user
end
