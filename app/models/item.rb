class Item < ApplicationRecord
  has_many :cart_items
  has_many :ordered_items
  has_many :likes, dependent: :destroy
  has_many :liked_customers, through: :likes, source: :customer
  has_many :reviews, dependent: :destroy

  def liked_by?(customer)
    likes.where(customer_id: customer.id).exists?
  end

  belongs_to :genre

  attachment :image

  enum is_active: {Availble: true, Invalid: false}

  #商品の税込み単価
  def including_tax
    (price_excluding_tax * 1.1).round(0)
  end

  validates :name, presence: true
	validates :description, presence: true, length: {maximum: 200}
	validates :price_excluding_tax, presence: true, numericality: { only_integer: true }
	validates :genre_id, presence: true
	validates :is_active, presence: true
end
