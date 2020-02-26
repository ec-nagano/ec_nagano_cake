class ApplicationController < ActionController::Base
    $delivery_fee = 800
    $tax_rate = 0.1

before_action :configure_permitted_parameters, if: :devise_controller?
	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :address, :postcode, :phone_number])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :address, :postcode, :phone_number])
	end

	def after_sign_in_path_for(resource)
	  root_path
	end
	def after_sign_out_path_for(resource)
	  root_path
	end
end
