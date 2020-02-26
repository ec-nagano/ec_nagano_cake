class CartItemsController < ApplicationController

    # 全てのアクションについて、ログイン済みかを判定する
    before_action :authenticate_customer!
    before_action :ensure_correct_customer, only: [:destroy, :update]

    def index
        @cart_items = CartItem.where(customer_id: current_customer.id)
    end

    def create
        cart_item = CartItem.new(cart_item_params)
        cart_item.customer_id = current_customer.id
        if cart_item.save
            flash[:notice] = "カートに追加しました"
            redirect_to(cart_items_path)
        end
    end

    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        redirect_to(cart_items_path)
    end

    def update
        cart_item = CartItem.find(params[:id])
        cart_item.amount = params[:amount]
        redirect_to(cart_items_path)
    end

    # current_customerに紐付く、cart_itemsを全て取得し、eachメソッドで削除していく。
    def items_destroy
        cart_items = CartItem.where(customer_id: current_customer.id)
        cart_items.each do |e|
            e.destroy
        end
        redirect_to(cart_items_path)
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:product_id, :amount)
    end

    def ensure_correct_customer
        @cart_item = Order.find(params[:id])
        if cart_item.customer_id != current_customer.id
            flash[:notice] = "権限がありません"
            redirect_to("/customers/#{current_customer.id}")
        end
    end
end
