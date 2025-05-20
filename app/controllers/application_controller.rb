class ApplicationController < ActionController::Base
  skip_forgery_protection

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:first_name, :last_name])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:first_name, :last_name])
  end
end
