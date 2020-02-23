class ShippingAddress < ApplicationRecord
	belongs_to :customer

	validates :customer_id, presence: true
	validates :name, presence: true
	validates :postcode, presence: true
	vakidates :address, presence: true
end
