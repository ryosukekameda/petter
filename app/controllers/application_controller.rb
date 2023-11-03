class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  
  def search
    @q = Post.ransack(params[:q])
    @post = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&blank?)
  end

  protected
  
  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_path
      when User
        root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :nickname, :phone_number, :is_deleted, :is_user_status])
  end
end
