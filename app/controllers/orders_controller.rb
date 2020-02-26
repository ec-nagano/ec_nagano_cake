class OrdersController < ApplicationController

    # 全てのアクションについて、ログイン済みかを判定する
    before_action :authenticate_customer!
    before_action :ensure_correct_customer, only: [:show]

    def index
        @orders = Order.where(customer_id: current_customer.id)
    end

    def show
        @order = Order.find(params[:id])
        @ordered_items = OrderedItems.where(order_id: @order.id)
    end

    def new
        @addresses = ShppingAddress.where(customer_id: current_user.id)
    end

    def confirm
        @cart_items = CartItem.where(customer_id: current_customer.id)
        # 選択されたラジオボタンによってパラメーターを変化する
        case "address_type"
        # "ご自身の住所"の場合
        when 0
            params[:order][:postcode] = current_customer.postcode
            params[:order][:address] = current_customer.address
            params[:order][:recipient] = "#{current_customer.first_name} + ' ' + #{current_customer.last_name}"
        # "登録済み住所"の場合
        when 1
            address = ShppingAddress.find(params[:existing_address])
            params[:order][:postcode] = address.postcode
            params[:order][:address] = address.address
            params[:order][:recipient] = address.name
        # "新しい住所"の場合    
        when 2
            params[:order][:postcode] = params[:new_postcode]
            params[:order][:address] = params[:new_address]
            params[:order][:recipient] = params[:new_recipient]
        end
        params[:order][:delivery_fee] = $delivery_fee
        # 請求額を計算する処理
        @cart_items.each do |e|
            billing_amount += (e.product.price * (1 + $tax_rate)).round
        end
        params[:order][:billing_amount] = billing_amount
        params[:order][:payment] = params[:payment]
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        unless @order.valid?
            @addresses = ShppingAddress.where(customer_id: current_user.id)
            render(:new)
        end
    end

    def create
        # ordersテーブルのレコードを作成する処理
        order = Order.new(order_params)
        order.customer_id = current_customer.id
        order.save
        # ordered_itemsテーブルのレコードを作成する処理
        @cart_items = CartItem.where(customer_id: current_customer.id)
        @cart_items.each do |e|
            ordered_item = OrderedItems.new(
                order_id: @order.id,
                product_id: e.id,
                price: (e.price * (1 * $tax_rate)).round,
                amount: e.amount
            )
            ordered_item.save
            # ordered_itemsテーブルにレコードの作成処理が終了したcart_itemsレコードを削除する
            e.destroy
        end
        redirect_to(orders_thanks_path)
    end

    def thanks

    end

    private
    def order_params
        params.require(:order).permit(:postcode, :address, :recipient, :delivery_fee, :billing_amount, :payment)
    end

    def ensure_correct_customer
        @order = Order.find(params[:id])
        if @order.customer_id != current_customer.id
            flash[:notice] = "権限がありません"
            redirect_to("/customers/#{current_customer.id}")
        end
    end
end