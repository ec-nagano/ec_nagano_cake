class Admin::OrdersController < ApplicationController
	def index
		@orders = Order.page(params[:page]).reverse_order
	end

	def show
		@order = Order.find(id: params[:id])
		#customerの名前が必要だから
		@customer = @order.customer
		@ordered_items = Ordered_item.where(order_id: @order.id)
	end

	def update
		@order = Order.find(params[:id])
		@ordered_item = Ordered_item.find_by(id: params[:item][:item_id])
		@ordered_item.status = params[:item][:status]

		@order.update(order_params)
		@ordered_item.update

		#注文ステの入金確認1がきたら自動で制作ステを制作待ち1にする
		if @order.status == 1

			@order_items = @order.ordered_items
			@order_items.each do |item|
				item.status = 1
				item.update
			end
			redirect_to("/admin/orders/#{@order.id}")
		end

		#一つの制作ステの製作中2がきたら自動で注文ステを製作中2にする
		#どっちか、うまくいった方
		# order_items = @order.ordered_items
		# if order_items.any? { |item| item.status == 2 }
		# 	@order.status = 2
		# 	@order.update
		# 	redirect_to("/admin/orders/#{@order.id}")
		# end
		if @ordered_item.status == 2

			@order.status = 2
			@order.update
			redirect_to("/admin/orders/#{@order.id}")
		end

		#全てのステの製作完了3がきたら自動で注文ステを発送準備中3にする
		ordered_items = @order.ordered_items
		if ordered_items.all? { |item| item.status == 3 }

			@order.status = 3
			@order.update
			redirect_to("/admin/orders/#{@order.id}")
		end

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
