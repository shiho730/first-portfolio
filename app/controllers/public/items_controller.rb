class Public::ItemsController < ApplicationController
  
  def index
    @genres = Genre.all
    @items = Item.where(is_active: "Availble").page(params[:page]).per(8)
    @items_n = Item.where(is_active: "Availble")
  end

  def genre
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end

  def top
    #@items = Item.order("RANDOM()").limit(4)
    #@genres = Genre.all
  end

  def about
  end
end
