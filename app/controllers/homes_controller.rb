class HomesController < ApplicationController

	before_action :ensure_active_customer, only: [:top]

	def top
		#ランダムにproductのレコードを取得
		@products = Product.order("random()").limit(4)
		render(layout: "top")
	end

	def about

	end

	private
	# 退会済みのcustomerを判定
	def ensure_active_customer
		if customer_signed_in? && current_customer.is_active == false
			sign_out
			flash[:notice] = "退会済みです"
			redirect_to(root_path)
		end
	end
	
end