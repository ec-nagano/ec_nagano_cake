class Order < ApplicationRecord
	belongs_to :customer
	has_many :ordered_items

	enum payment: [:クレジットカード, :銀行振込]
	enum status: [:入金待ち, :入金確認, :製作中, :発送準備中, :発送済み]

	validates :recipient, presence: true
	validates :address, presence: true
	validates :postcode, presence: true
	validates :billing_amount, presence: true
	validates :payment, presence: true

	def ordered_items
		return OrderedItem.where(order_id: self.id)
	end
end
