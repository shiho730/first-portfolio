class Order < ApplicationRecord
  has_many :ordered_items
  belongs_to :customer

  def order_total_amount
    order_items = OrderedItem.where(order_id: self.id)
    quantity_list = []
    order_items.each do |items|
    quantity_list.push(items.amount)
  end
    return quantity_list.sum
  end

  def name_address_shipping
    postal_code + address
  end

  validates :customer_id, :name, :postal_code, :address, :shipping_fee, :total_payment, :payment_method, presence: true
	validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
	validates :shipping_fee, :total_payment, numericality: { only_integer: true }
  enum payment_method: { credit: 0, bank: 1}
  # 0入金待ち、1入金確認、2製作中、3発送済み
  enum status: { waiting: 0, paid: 1, preparing: 2, sent: 3}

end
