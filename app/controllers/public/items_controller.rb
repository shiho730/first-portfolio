class Public::ItemsController < ApplicationController

  def index
    @items = Item.where(is_active: "Availble").page(params[:page]).per(8)
    @items_n = Item.where(is_active: "Availble")
  end

  def genre
  end

  def show
    @item = Item.find(params[:id])
    #@items = Item.includes(:liked_customers).sort {|a,b| b.liked_customers.size <=> a.liked_customers.size}
    @review = Review.new
    @reviews = @item.reviews.limit(5)
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rate).round(2)
    end
  end

  def top
    @items = Item.all.limit(4)
    #@item = Item.includes(:liked_customers).sort {|a,b| b.liked_customers.size <=> a.liked_customers.size}
                                             # 各投稿のいいね数を比較して昇順で並び替えている

    @item = Item.find(Like.group(:item_id).order('count(item_id) desc').limit(4).pluck(:item_id))
  end

  def about
  end

  def rank
    @items = Item.find(Like.group(:item_id).order('count(item_id) desc').limit(8).pluck(:item_id))
  end
end
