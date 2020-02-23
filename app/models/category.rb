class Category < ApplicationRecord
	hac_many :products

	validates :name,presence: true
end
