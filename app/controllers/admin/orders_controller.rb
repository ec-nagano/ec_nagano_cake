class Admin::OrdersController < ApplicationController
	def index
		@orders = Order.page(params[:page]).reverse_order
	end

	def show
		@order = Order.find(id: params[:id])
		#customerの名前が必要だから
		@customer = @order.customer

		#assosiationでやってみる
		#下の２つは同じ意味
		@ordered_items = Ordered_item.where(order_id: @order.id)
		@ordered_items_asso = @order.ordered_items
	end

	def update
		#注文ステの入金確認がきたら自動で制作ステを制作待ちにする
		if params[:order][:status] && params[:order][:status] == "入金確認"
			@order = Order.find(params[:id])
			@order.update(order_params)

			@order_items = @order.ordered_items
			@order_items.to_a.map! do |item|
				item.status == "制作待ち"
			end
			@order_items.update(ordered_item_params)
			redirect_to("/admin/orders/#{@order.id}")
		end


		#一つの制作ステの製作中がきたら自動で注文ステを製作中にする
		if params[:ordered_item][:status] && params[:ordered_item][:status] == "制作中"
			@order = Order.find(params[:id])
			#多分違う
			@ordered_item = Ordered_item.find_by(order_id: @order.id)
			@ordered_item.updatee(ordered_item_params)

			@order.status == "製作中"
			@order.update(order_params)
			redirect_to("/admin/orders/#{@order.id}")
		end

		#全ての制作ステの製作完了がきたら自動で注文ステを制作完了にする
		if params[:ordered_item][:status] && params[:ordered_item][:status] == "制作完了"
			@order = Order.find(params[:id])
			#多分違う
			@ordered_item = Ordered_item.find_by(order_id: @order.id)
			@ordered_item.updatee(ordered_item_params)

			@order.status == "制作完了"
			@order.update(order_params)
			redirect_to("/admin/orders/#{@order.id}")
		end

		#一つの注文を更新するならこれだけでok
		@order = Order.find(params[:id])
		@order.update(order_params)
		redirect_to("/admin/orders/#{@order.id}")

		#一つの商品を選んで更新できない
		@order = Order.find(params[:id])
		@ordered_item = Ordered_item.find_by(order_id: @order.id)
		@order.update(ordered_item_params)
		redirect_to("/admin/orders/#{@order.id}")
	end

	private

	  	def order_params
	  		params.require(:order).permit(:status)
	  	end

	  	def ordered_item_params
	  		params.require(:ordered_item).permit(:status)
	  	end
end
