class CartItem < ApplicationRecord
	belongs_to :customer
	belongs_to :product

	validates :amount, presence: true, numericality: { greater: 1 }
end