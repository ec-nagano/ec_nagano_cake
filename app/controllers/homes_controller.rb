class HomesController < ApplicationController
	def top
		#ランダムにproductのレコードを取得
		@products = Product.order("random()").limit(4)
	end

	def about
	end
end
