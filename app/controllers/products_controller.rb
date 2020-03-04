class ProductsController < ApplicationController

  def index
    @categories = Category.all
    if params[:category_id].present?
      # params[:category_id]が存在する場合、ジャンルに紐付く商品のみ取得する
      @category = Category.find(params[:category_id].to_i)
      @products = Product.where(category_id: @category.id).order(created_at: :DESC).page(params[:page]).per(6)
    else
      # params[:category_id]が存在しない場合、商品を全て取得する
      @products = Product.order(created_at: :DESC).page(params[:page]).per(6)
    end
  end

  def show
    @categories = Category.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end

  private
    def product_params
      params.require(:product).permit(:name, :content, :price, :product_image, :is_active)
    end

end


