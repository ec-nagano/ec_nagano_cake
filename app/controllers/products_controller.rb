
class ProductsController < ApplicationController
    # 全てのアクションについて、ログイン済みかを判定する
    # before_action :authenticate_customer!
  def index
    if params[:category_id].blank?
      @products=Product.all
    else
      # category.idを持つ商品のみを表示する。　to_iはparmasのidが文字列のため整数に変換するために必要。
      @products=Product.where(category_id:params[:category_id].to_i)
      @category=Category.find(params[:category_id].to_i)
    end
    # @product=Product.find(params[:id])
    @categories=Category.all
  end

  def show
    @product=Product.find(params[:id])
    @categories=Category.all
  end

   private
  def product_params
    params.require(:product).permit(:name, :content, :price, :product_image, :is_active)
end
end


