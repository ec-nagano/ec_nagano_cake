class CartItemsController < ApplicationController

    before_action :authenticate_customer!
    before_action :ensure_correct_customer, only: [:destroy, :update]

    def index
        @cart_items = CartItem.where(customer_id: current_customer.id)
    end

    def create
        cart_item = CartItem.find_by(product_id: params[:cart_item][:product_id], customer_id: current_customer.id)
        # カート内に同じ商品がある場合、数量を追加する
        if cart_item.present?
            cart_item.amount += params[:cart_item][:amount].to_i
            cart_item.save
        else
            cart_item = CartItem.new(cart_item_params)
            cart_item.customer_id = current_customer.id
            if cart_item.valid?
                cart_item.save
                flash[:notice] = "カートに追加しました"
            else
                flash[:notice] = "数値が不正です"
                @product = Product.find(params[:cart_item][:product_id])
                @cart_item = CartItem.new
                @categories=Category.all
                render("products/show")
            end
        end
        redirect_to(cart_items_path)
    end

    # 特定のcart_item一件を削除する
    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        @cart_items = CartItem.where(customer_id: current_customer.id)
    end

    def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(amount: params[:cart_item][:amount])
        @cart_items = CartItem.where(customer_id: current_customer.id)
    end

    # current_customerに紐付く、cart_itemsを取得し、全件削除する。
    def items_destroy
        @cart_items = CartItem.where(customer_id: current_customer.id)
        @cart_items.destroy_all
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:product_id, :amount)
    end

    # 他のcustomer がアクセスできないようにする
    def ensure_correct_customer
        cart_item = CartItem.find(params[:id])
        if cart_item.customer != current_customer
            flash[:notice] = "権限がありません"
            redirect_to("/customers/#{current_customer.id}")
        end
    end

end
