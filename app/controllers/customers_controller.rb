class CustomersController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:show]

  def show
  	@customer = Customer.find(params[:id])
  end

  def confirm_unsubscribing
  	@customer = current_customer
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_cana, :postcode, :address,:phone_number,:email)
  end

  # 他のcustomer がアクセスできないようにする
  def ensure_correct_customer
    customer = Customer.find(params[:id])
    if customer != current_customer
        flash[:notice] = "権限がありません"
        redirect_to("/customers/#{current_customer.id}")
    end
  end

end
