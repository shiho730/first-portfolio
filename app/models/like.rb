class Like < ApplicationRecord

  belongs_to :customer
  belongs_to :item

#   validates_uniqueness_of :item_id, scope: :customer_id    # バリデーション（ユーザーと記事の組み合わせは一意）
# # 同じ投稿を複数回お気に入り登録させないため。
end
