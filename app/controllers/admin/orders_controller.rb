class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
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
		order = Order.find(params[:id])

		ordered_item = Ordered_item.find_by(id: params[:item][:item_id])
		ordered_item.status = params[:item][:status]
		ordered_items = @order.ordered_items#all?とany?で使う

		#注文ステータスの分岐
		case order.status
		#注文ステの入金確認1がきたら自動で制作ステを制作待ち1にする
		when 1
			@order.update(order_params)
			@ordered_items = @order.ordered_items
			@ordered_items.each do |item|
				item.status = 1
				item.update
			end
			redirect_to("/admin/orders/#{@order.id}")
		#注文ステが発送済み4の時
		when 4
			@order.update(order_params)
			redirect_to("/admin/orders/#{@order.id}")
		end

		#製作ステータスの分岐
		#一つの制作ステの製作中2がきたら自動で注文ステを製作中2にする
		#どっちか、うまくいった方

		# ordered_items = @order.ordered_items
		# if ordered_items.any? { |item| item.status == 2 }
		#   ordered_item.update
		#   order.status = 2
		# 	order.update
		# 	redirect_to("/admin/orders/#{@order.id}")
		# end
		if ordered_item.status == 2
			ordered_item.update

			order.status = 2
			order.update
			redirect_to("/admin/orders/#{@order.id}")
		end

		#全てのステの製作完了3がきたら自動で注文ステを発送準備中3にする
		if ordered_items.all? { |item| item.status == 3 }
			ordered_item.update

			order.status = 3
			order.update
			redirect_to("/admin/orders/#{@order.id}")
		end
	end

	private
	  	def order_params
	  		params.require(:order).permit(:status)
	  	end
end
