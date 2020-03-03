class OrdersController < ApplicationController

    before_action :authenticate_customer!
    before_action :ensure_correct_customer, only: [:show]

    def index
        @orders = Order.where(customer_id: current_customer.id)
    end

    def show
        @order = Order.find(params[:id])
        @ordered_items = @order.ordered_items
    end

    def new
        cart_items = CartItem.where(customer_id: current_customer.id)
        # カートに商品がない場合redirectする
        if cart_items.blank?
            flash[:notice] = "カートに商品がありません"
            redirect_to(products_path)
        end
        @addresses = ShippingAddress.where(customer_id: current_customer.id)
    end

    def confirm
        if params[:payment].blank? || params[:address_type].blank?
            flash[:notice] = "未入力の項目があります。"
            cart_items = CartItem.where(customer_id: current_customer.id)
            @addresses = ShippingAddress.where(customer_id: current_customer.id)
            render(:new)
        end
        @order = Order.new
        @cart_items = CartItem.where(customer_id: current_customer.id)
        # 選択されたラジオボタンによってインスタンス変数に代入する値を変化する
        case params[:address_type].to_i
        # "ご自身の住所"の場合
        when 0
            @postcode = current_customer.postcode
            @address = current_customer.address
            @recipient = current_customer.first_name + ' ' + current_customer.last_name
        # "登録済み住所"の場合
        when 1
            address = ShippingAddress.find(params[:existing_address])
            @postcode = address.postcode
            @address = address.address
            @recipient = address.name
        # "新しい住所"の場合
        when 2
            address = ShippingAddress.new(
                customer_id: current_customer.id,
                postcode: params[:new_postcode],
                address: params[:new_address],
                name: params[:new_recipient]
            )
            if address.invalid?
                address.save
                flash[:notice].now = "住所を登録しました。"
            else
                @addresses = ShippingAddress.where(customer_id: current_customer.id)
                flash[:notice] = "新しい住所に不備があります。"
                render(:new)
            end
            @postcode = address.postcode
            @address = address.address
            @recipient = address.name
        end
        # 請求額を計算する処理
        @billing_amount = 0
        @cart_items.each do |cart_item|
            @billing_amount += (cart_item.product.price * (1 + $tax_rate)).round * cart_item.amount
        end
        @delivery_fee = $delivery_fee
        @payment = params[:payment].to_i
    end

    def create
        # ordersテーブルのレコードを作成する処理
        params[:order][:payment] = params[:order][:payment].to_i
        order = Order.new(order_params)
        order.customer_id = current_customer.id
        order.save
        # ordered_itemsテーブルのレコードを作成する処理
        cart_items = CartItem.where(customer_id: current_customer.id)
        cart_items.each do |cart_item|
            ordered_item = OrderedItem.new(
                order_id: order.id,
                product_id: cart_item.product.id,
                price: (cart_item.product.price * (1 * $tax_rate)).round,
                amount: cart_item.amount
            )
            ordered_item.save
            # ordered_itemsテーブルにレコードの作成処理が終了したcart_itemsレコードを削除する
            cart_item.destroy
        end
        redirect_to(orders_thanks_path)
    end

    def thanks

    end

    private
    def order_params
        params.require(:order).permit(:postcode, :address, :recipient, :delivery_fee, :billing_amount, :payment)
    end

    # 他のcustomer がアクセスできないようにする
    def ensure_correct_customer
        order = Order.find(params[:id])
        if order.customer != current_customer
            flash[:notice] = "権限がありません"
            redirect_to("/customers/#{current_customer.id}")
        end
    end
    
end