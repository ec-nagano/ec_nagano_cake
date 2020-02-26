class CustomersController < ApplicationController
  def show
  	@customer=Customer.find(params[:id])
  end

  def confirm_unsubscribing
  	@customer=current_customer
  end
  #  customer.is_active = false
  # end
  def customer_params
    params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_cana, :postcode, :address,:phone_number,:email)
  end
end
