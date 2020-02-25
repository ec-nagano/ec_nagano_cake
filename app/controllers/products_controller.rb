class ProductsController < ApplicationController
  def index
    @product=Product.all
    @categories=Categories.all
  end

  def show
    @categories=Categories.all
    @product=Product.find(params[:id])
  end

   private
  def product_params
    params.require(:product).permit(:name, :content, :price, :product_image, :is_active)
end
end