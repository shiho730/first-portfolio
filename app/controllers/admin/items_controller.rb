class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @items = Item.all
    @genres = Genre.all
  end

  def create
    @item = Item.new(product_params)
    if @item.save
      flash[notice] = "商品登録しました"
      redirect_to admin_item_path(@item)
    else
      flash[notice] = "商品登録ができませんでした"
      render :new

    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[notice] = '編集に成功しました'
      redirect_to admin_item_path(@item)
    else
      flash[notice] = "編集ができませんでした"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:is_active, :name, :description, :price_excluding_tax, :genre_id, :image)
  end

end
