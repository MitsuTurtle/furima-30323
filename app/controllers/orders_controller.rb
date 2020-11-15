class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
    @user_order_item = UserOrderItem.new
  end

  def create
    @item = Item.find(params[:item_id])
    @user_order_item = UserOrderItem.new(order_params)
    if @user_order_item.valid?
      @user_order_item.save
      redirect_to root_path
    else
      render :index
      # render "orders/index"
      # redirect_to item_orders_path
    end
  end

  private
  
  def order_params
    params.require(:user_order_item).permit(:postal_code, :prefecture_id, :city, :house_number, :building, :telephone).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
