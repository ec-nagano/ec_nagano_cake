class Admin::HomesController < ApplicationController
	before_action :authenticate_admin!
	def top
		#本日の注文の呼び出し where
		@orders = Order.where(created_at: Time.current.beginning_od_day..Time.current.end_of_day)
	end
end
