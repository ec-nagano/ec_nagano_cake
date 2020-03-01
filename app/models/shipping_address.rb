class ShippingAddress < ApplicationRecord
	belongs_to :customer

	validates :customer_id, presence: true
	validates :name, presence: true
	validates :postcode, presence: true, length: { minimum: 7 }, numericality: { only_integer: true }
	validates :address, presence: true
end
