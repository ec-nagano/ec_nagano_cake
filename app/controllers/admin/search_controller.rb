class Admin::SearchController < ApplicationController

    before_action :authenticate_admin!

    def search_result
        case params[:search_model]
        when "product_name"
            @products = Product.where("name LIKE?", "%#{params[:search_word]}%").page(params[:page])
            render('/admin/products/index')
        when "product_content"
            @products = Product.where("content LIKE?", "%#{params[:search_word]}%").page(params[:page])
            render('/admin/products/index')
        when "customer"
            @customers = Customer.where("name LIKE?", "%#{params[:search_word]}%").page(params[:page])
            render('/admin/customers/index')
        when "order"
            @orders = Order.where(status: params[:search_order_status].to_i).order("created_at DESC").page(params[:page]).per(10)
            render('/admin/orders/index')
        when "category"
            @category = Category.new
            @categories = Category.where("name LIKE?", "%#{params[:search_word]}%")
            render('/admin/categories/index')
        end
    end

end