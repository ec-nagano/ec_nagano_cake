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
        @product = Product.find(params[:id])
    end

    def create
        product = Product.new(product_params)
        product.save
        redirect_to admin_product_path(product)
    end

    def update
        product = Product.find(params[:id])
        product.update(product_params)
        redirect_to admin_product_path(product)
    end

    private
    def product_params
    params.require(:product).permit(:name, :content, :category_id, :price, :is_active, :product_image)
  end
end
