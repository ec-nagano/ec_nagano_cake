class HomesController < ApplicationController
	def top
		#ランダムにproductのレコードを取得
		@products = Product.order("RAND()").limit(4)
	end

	def about
	end
end
