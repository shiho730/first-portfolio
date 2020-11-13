class Admin::OrderedItemsController < ApplicationController
   before_action :authenticate_admin!

  def update
    @ordered_item = OrderedItem.find(params[:id])
    redirect_to admin_order_path(@ordered_item.order)
  end

  private

end
