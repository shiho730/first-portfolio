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
  
  def show
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rating).round(2)
    end
  end
# @average_reviewのインスタンス変数を設定
end
