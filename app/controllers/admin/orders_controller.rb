class Admin::OrdersController < ApplicationController

	before_action :authenticate_admin!

	def index
		# 注文日が新しい順番に表示
		@orders = Order.order("created_at DESC").page(params[:page]).per(10)
	end

	def show
		@order = Order.find(params[:id])
		# 注文者を取得
		@customer = @order.customer
		@ordered_items = @order.ordered_items
	end

	def update
		order = Order.find(params[:id])
		ordered_items = order.ordered_items
		
		if params[:order]
			# true: 注文ステータスが変更された場合
			# f.selectから送られてくるparamsはstring型なのでinteger型に変換する
			params[:order][:status] = params[:order][:status].to_i

			case params[:order][:status]
			#注文ステータスが1: 入金確認に変更された場合、製作ステータスを1: 製作待ちに変更する
			when 1
				order.update(order_params)
				ordered_items.each do |ordered_item|
					ordered_item.update(status: 1)
				end
				redirect_to(admin_order_path(order.id))
			#注文ステータスが4: 発送済みに変更された場合
			when 4
				order.update(order_params)
				redirect_to(admin_order_path(order.id))
			end

		else 
			# false: 製作ステータスが変更された場合
			# f.selectから送られてくるparamsはstring型なのでinteger型に変換する
			params[:ordered_item][:status] = params[:ordered_item][:status].to_i

			case params[:ordered_item][:status]
			# 注文商品のどれか一つが2: 製作中に変更された場合、注文ステータスを2: 製作中に変更する
			when 2
				ordered_item = OrderedItem.find_by(id: params[:ordered_item][:item_id])
				ordered_item.update(ordered_item_params)
				order.update(status: 2)
				redirect_to(admin_order_path(order.id))
			#　注文商品のどれか一つが3: 製作完了に変更された場合の分岐
			when 3
				ordered_item = OrderedItem.find_by(id: params[:ordered_item][:item_id])
				ordered_item.update(ordered_item_params)

				# ordered_items のステータスが全て、3: 製作完了になった場合、注文ステータスを3: 発送準備中に変更する
				# item.statusだと定義したstring型の方が呼ばれるので_before_type_castをつけてinteger型にする
				if ordered_items.all? do |item| 
						item.status_before_type_cast == 3 
					end
					order.update(status: 3)
				end
				redirect_to(admin_order_path(order.id))
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
