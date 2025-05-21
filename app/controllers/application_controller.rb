class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :set_item_search

  private
  def set_item_search
    # ensures @q is always a Ransack::Search for Items
    @q = Item.ransack(params.fetch("q", {}))
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:first_name, :last_name])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:first_name, :last_name])
  end
end
