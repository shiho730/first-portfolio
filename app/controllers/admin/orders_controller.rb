class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.ordered_items
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == 'paid'
        @order.ordered_items.update_all(status: "waiting")
      end
    end

    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
