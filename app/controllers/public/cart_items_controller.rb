class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_params)

    # カートの中に同じ商品が重複しないようにして　古い商品と新しい商品の数量を合わせる
    @update_cart_item =  CartItem.find_by(item: @cart_item.item)
    if @update_cart_item.present? && @cart_item.present?
        @cart_item.quantity += @update_cart_item.quantity
        @update_cart_item.destroy
    end

    if @cart_product.save
      flash[:notice] = "カートに商品を追加しました"
      redirect_to cart_items_path
    else
      flash[:notice] = "カートに商品を追加できませんでした"
      redirect_to item_path(params[:id])
    end
  end


  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
    redirect_to request.referer
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
    redirect_to request.referer
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:cart_item][:quantity].to_i)
    flash.now[:success] = "#{@cart_item.item.name}の数量を変更しました"
    redirect_to cart_items_path
  end

  private


  def correct_customer
    customer = Customer.find(params[:customer_id])
    unless current_customer = customer
      redirect_to root_path
    end
  end

  def cart_params
    params.permit(:item_id, :customer_id, :quantity)
  end

end
