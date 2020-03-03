class ShippingAddressesController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_correct_customer, except: [:index]

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def create
    shipping_address = ShippingAddress.new(shipping_address_params)
    shipping_address.customer_id = current_customer.id
    if shipping_address.valid?
      shipping_address.save
      flash[:notice] = "住所を保存しました"
      redirect_to(shipping_addresses_path)
    else
      @shipping_addresses=ShippingAddress.all
      flash[:notice] = "入力内容に不備があります"
      render(:index)
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    shipping_address = ShippingAddress.find(params[:id])
    if shipping_address.update(shipping_address_params)
      flash[:notice] = "住所を更新しました"
      redirect_to(shipping_addresses_path)
    else
      @shipping_address = ShippingAddress.find(params[:id])
      flash[:notice] = "入力内容に不備があります"
      render(:edit)
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    flash[:notice] = "住所を削除しました"
    redirect_to(shipping_addresses_path)
  end

  private
  def shipping_address_params
    params.require(:shipping_address).permit(:name, :postcode, :address)
  end

  # 他のcustomer がアクセスできないようにする
  def ensure_correct_customer
    shipping_address = ShippingAddress.find(params[:id])
      if shipping_address.customer != current_customer
        flash[:notice] = "権限がありません"
        redirect_to("/customers/#{current_customer.id}")
      end
  end

end
