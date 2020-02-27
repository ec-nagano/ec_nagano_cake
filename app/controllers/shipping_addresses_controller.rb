class ShippingAddressesController < ApplicationController
  def index
    @shipping_address=ShippingAddress.new
    @shipping_addresses=ShippingAddress.where(customer_id: current_customer.id)
  end

  def edit
    @shipping_address=ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address=ShippingAddress.find(params[:id])
     if @shipping_address.update(shipping_address_params)
    redirect_to shipping_addresses_path
    else
      render action: :edit
    end
  end

  def destroy
    @shipping_address=ShippingAddress.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end


  def create
    @shipping_address=ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      @shipping_addresses=ShippingAddress.all
      redirect_to shipping_addresses_path
    else
      @shipping_addresses=ShippingAddress.all
      render action: :index
    end
  end

  def
    shipping_address_params
    params.require(:shipping_address).permit(:name, :postcode, :address)
  end
end
