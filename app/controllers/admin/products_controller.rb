class Admin::ProductsController < ApplicationController
	def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def show
        @product = Product.find(params[:id])
    end

    def edit
    end

    def create
    end

    def update
    end

    private
    def product_params
    params.require(:product).permit(:name, :content, :category_id, :price, :is_active, :product_image)
  end
end
