class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
	def index
		@orders = Order.page(params[:page]).reverse_order
	end

	def show
		@order = Order.find(params[:id])
		#customerの名前が必要だから
		@customer = @order.customer
		@ordered_items = OrderedItem.where(order_id: @order.id)
	end

	def update
		order = Order.find(params[:id])

		# ordered_item = OrderedItem.find_by(id: params[:item][:item_id])
		# ordered_item.status = params[:item][:status]
		# ordered_items = @order.ordered_items#all?とany?で使う

		#注文ステータスの分岐
		if params[:order]
			params[:order][:status] = params[:order][:status].to_i

			case params[:order][:status]
			#注文ステの入金確認1がきたら自動で制作ステを制作待ち1にする
			when 1
				# redirect_to root_path
				order.update(order_params)
				ordered_items = order.ordered_items
				ordered_items.each do |item|
					#item.status = 1
					item.update(status: 1)
				end
				redirect_to("/admin/orders/#{order.id}")
			#注文ステが発送済み4の時
			when 4
				order.update(order_params)
				redirect_to("/admin/orders/#{order.id}")
			end
		#製作ステータスの分岐
		else params[:ordered_item]
			params[:ordered_item][:status] = params[:ordered_item][:status].to_i

			case params[:ordered_item][:status]
			#一つの製作ステの製作中2がきたら自動で注文ステを製作中2にする
			when 2
				ordered_item = OrderedItem.find_by(id: params[:ordered_item][:item_id])
				#ordered_item.status = params[:ordered_item][:status]
				ordered_item.update(ordered_item_params)

				order.update(status: 2)
				redirect_to("/admin/orders/#{order.id}")
			#全ての製作ステの製作完了3がきたら自動で注文ステを発送準備中3にする
			when 3
				ordered_item = OrderedItem.find_by(id: params[:ordered_item][:item_id])
				#ordered_item.status = params[:ordered_item][:status]
				ordered_item.update(ordered_item_params)

				ordered_items = order.ordered_items
				if ordered_items.all? { |item| item.status_before_type_cast == 3 }
					order.update(status: 3)
				end
				redirect_to("/admin/orders/#{order.id}")
			end
		end
	end

	private
		def order_params
			params.require(:order).permit(:status)
		end

		def ordered_item_params
			params.require(:ordered_item).permit(:status)
		end
end
