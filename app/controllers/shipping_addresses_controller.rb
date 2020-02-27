class ShippingAddressesController < ApplicationController
  def index
    @shipping_addresses=Shipping_address.where(customer_id:params[:customer_id])
    @shipping_address=Shipping_address.new
  end

  def edit
    @shipping_address=Shipping_address.find(params[:id])
  end

  def update
    @shipping_address=Shipping_address.find(params[:id])
     if @shipping_address.update(shipping_address_params)
    redirect_to shipping_addresses_path
    else
      render action: :edit
    end
  end

  def destroy
    @shipping_address=Shipping_address.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end


  def create
    @shipping_address=Shipping_address.new(shipping_address_params)
    @shipping_addresses=Shipping_address.all
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
      render action: :index
    end
  end

  def
    shipping_address_params
    params.require(:shipping_address).permit(:name, :postcode, :address)
  end
end
