class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    @user_order_item = UserOrderItem.new
  end

  def create
    @user_order_item = UserOrderItem.new(order_params)
    if @user_order_item.valid?
      pay_item
      @user_order_item.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:user_order_item).permit(:postal_code, :prefecture_id, :city, :house_number, :building, :telephone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
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
end
