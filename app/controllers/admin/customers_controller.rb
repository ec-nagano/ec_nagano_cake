class Admin::CustomersController < ApplicationController
	def index
		@customers = Customer.all
	end

	def show
		@customer =  Customer.find(params[:id])
    end

    def edit
    end

    def update
    end


end
