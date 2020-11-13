class OrderedItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def each_total_payment
    amount * price_including_tax
  end
 
  validates :item_id, :order_id, :amount,
			  		:price_including_tax, presence: true
	validates :price_including_tax, :amount, numericality: { only_integer: true }

end
