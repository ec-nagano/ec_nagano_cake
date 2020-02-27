class Admin::CategoriesController < ApplicationController
	def index
		@category = Category.new
		@categories = Category.all
 	end

	def edit
		@category = Category.find(params[:id])
	end

	def create
		category = Category.new(category_params)
		category.save
		redirect_to admin_categories_path
    end

    def update
    	category = Category.find(params[:id])
    	category.update(category_params)
    	redirect_to admin_categories_path
    end

    private
    def category_params
    	params.require(:category).permit(:name, :is_active)
    end

end
