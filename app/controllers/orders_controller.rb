class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item
  before_action :move_to_root_path, only: :index
  before_action :move_to_root_path2, only: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root_path
    return unless current_user.id == Item.find(params[:item_id]).user.id

    redirect_to root_path
  end

  def move_to_root_path2
    return unless @item.order.present?

    redirect_to root_path
  end
end
