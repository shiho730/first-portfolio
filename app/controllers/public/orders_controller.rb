class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def create
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items

    if @order.save
      @cart_items.each do |cart|
        @ordered_item =  OrderedItem.new
        @ordered_item.order_id = @order.id
        @ordered_item.item_id = cart.item.id
        @ordered_item.amount = cart.quantity
        @ordered_item.price_including_tax = cart.item.including_tax

        @ordered_item.save
      end

      # お届け先が新規登録なら配送先一覧に追加
      if params[:postal_code].present?
        @shipping_address = ShippingAddress.new(shipping_params)
        @shipping_address.customer_id = current_customer.id
        @shipping_address.save
      end

      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      flash[:notice] = "情報の入力を完了してください"
      redirect_to orders_information_path
    end
  end

  def index
    @orders = current_customer.orders
  end

  def information
    @shipping_addresses = current_customer.shipping_addresses
  end

  def new
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = OrderedItem.where(order_id: params[:id])
  end

  def thanks
  end

  def confirm
    # ユーザーのカート内商品の取得
    @cart_items = current_customer.cart_items
    # ↓送料の指定
    @shipping_fee = 800

    # ↓お届け先の条件分岐
    if params["radio"] == "r1"
      # payment_methodのみ取得
      @order_info = Order.new(order_select_params)
      # 住所は会員情報から取得
      render :new

    elsif params["radio"] == "r2"
      # payment_methodのみ取得
      @order_info = Order.new(order_select_params)
      # 住所は配送先一覧から取得
      @shipping_address = ShippingAddress.find(params[:shipping_select])
      render :new

    elsif params["radio"] == "r3"
      # text_fieldからもデータ取得
      @order_info = Order.new(order_form_params)
      render :new
    else
      #ラジオボタン自動選択なので、基本的には発生しない
      flash[:notice] = "配送先が選択されていません"
      render :information
    end
  end

    private

  # 宛先選択のラジオボタンが１(現在住所)か２(配送先一覧から選択)だった場合
  def order_select_params
    params.permit(:payment_method)
  end

  # 宛先選択のラジオボタンが３(新規入力)だった場合
  def order_form_params
    params.permit(:payment_method, :name, :postal_code, :address)
  end

  def order_params
    params.permit(:customer_id, :name, :postal_code, :address, :shipping_fee, :total_payment, :payment_method)
  end

  def shipping_params
    params.permit(:name, :postal_code, :address)
  end
end
