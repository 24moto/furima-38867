class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
		@order_address = OrderAddress.new
  end

end
