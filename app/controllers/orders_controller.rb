class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
		@order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    binding.pry
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
