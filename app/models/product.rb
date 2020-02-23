class Product < ApplicationRecord
	has_many :cart_items
	has_many :ordered_items
	belongs_to :category

	attachment :product_image

	validates :name, presence: true
	validates :content, presence: true
	validates :price, presence: true
	validates :product_image, presence: true
end
