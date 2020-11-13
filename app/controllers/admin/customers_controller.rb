class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end
   
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path
      flash[notice] = '編集に成功しました'
    else
      render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:is_deleted,:last_name,:first_name,:kana_last_name,:kana_first_name,:zip_code,:address,:phone_number,:email)
  end
end
