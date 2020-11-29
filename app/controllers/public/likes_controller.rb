class Public::LikesController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    like = current_customer.likes.new(item_id: item.id)
    like.save
    redirect_to item_path(item)
  end

  def destroy
    item = Item.find(params[:item_id])
    like = current_customer.likes.find_by(item_id: item.id)
    like.destroy
    redirect_to item_path(item)
  end

  # def show
  #   @customer = Customer.find(params[:id])
  #   @items = @customer.items
  #   likes = Like.where(customer_id: current_customer.id).pluck(:item_id)  # ログイン中のユーザーのお気に入りのitem_idカラムを取得
  #   @like_list = Item.find(items)    # itemsテーブルから、お気に入り登録済みのレコードを取得
  # end


end
