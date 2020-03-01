class Admin::ProductsController < ApplicationController

    before_action :authenticate_admin!


	def index
        @products = Product.order(created_at: :asc).page(params[:page])
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
        @product = Product.new(product_params)
        if @product.save
           redirect_to admin_product_path(@product)
        else
           render :new
        end
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
           redirect_to admin_product_path(@product)
        else
           render :edit
        end
    end


    private
    def product_params
          params.require(:product).permit(:name, :content, :category_id, :price, :is_active, :product_image)
    end


end