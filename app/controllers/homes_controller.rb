class HomesController < ApplicationController

	before_action :ensure_active_customer, only: [:top]
	def top
		#ランダムにproductのレコードを取得
		@products = Product.order("random()").limit(4)
	end

	def about

	end

	private
	# 退会済みのcustomerを判定
	def ensure_active_customer
		if customer_signed_in? && current_customer.is_active = 0
			sign_out_and_redirect(root_path)
			flash[:notice] = "退会済みです"
		end
	end
end
