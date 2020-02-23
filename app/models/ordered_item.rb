class OrderedItem < ApplicationRecord
	belongs_to :product
	belongs_to :order

	enum status: [:着手不可, :製作待ち, :製作中, :製作完了]

	validates :price, presence: true
	validates :amount, presence: true
end
