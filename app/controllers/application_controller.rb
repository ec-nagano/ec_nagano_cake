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
		case resource
		when Customer
			root_path
		when Admin
			admin_path
		end
	end

	# def after_sign_out_path_for(resource)
	# 	case resource
	# 	when Customer
	# 		root_path
	# 	when Admin
	# 		new_admin_session_path
	# 	end
	# end
	Refile.secret_key = '5b6cc0f4e3a9c624f19437b916a8e775e146fa3e3ba083fd49e6bc3fbcc30a2e873e4430e78295df77219ba3a4c44f5e8438cae94e20d54f24129855b688038c'
	def after_sign_out_path_for(resource)
		case resource
		when Customer
			root_path
		when Admin
			new_admin_session_path
		end
	end
end