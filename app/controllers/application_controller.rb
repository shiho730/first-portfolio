class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def name
    last_name + first_name
  end

#ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    case resource
      when :admin
        new_admin_session_path
      when :customer
        root_path
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :last_name, :first_name, :kana_last_name, :kana_first_name, :zip_code, :address, :phone_number, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end


end
