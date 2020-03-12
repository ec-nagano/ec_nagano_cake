class Admin::CategoriesController < ApplicationController

    before_action :authenticate_admin!

    def index
		@category = Category.new
		@categories = Category.all
 	end

	def create
		@category = Category.new(category_params)
        @categories = Category.all
		if @category.save

        else
    		render(:index)
    	end
	end

	def edit
		@category = Category.find(params[:id])
	end

    def update
    	@category = Category.find(params[:id])
		if @category.update(category_params)
			flash[:notice] = "カテゴリーを編集しました"
    	   redirect_to(admin_categories_path)
    	else
    	   render(:edit)
    	end
    end

    private
    def category_params
    	params.require(:category).permit(:name, :is_active)
    end

end