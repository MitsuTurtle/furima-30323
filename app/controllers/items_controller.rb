class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :order_all, only: [:index, :show, :edit]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if user_signed_in? && @orders.exists?(item_id: @item.id) == false
      if current_user.id == @item.user_id
        render :edit
      else
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in?
      if current_user.id == @item.user_id
        @item.destroy
        redirect_to items_path
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :introduction, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :shipping_time_id, :price
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def order_all
    @orders = Order.all
  end
end
