class UserOrderItem
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number,
  :building, :telephone

  # バリデーション
  with_options presence:true do
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/}
    validates :prefecture_id, numericality: {other_than: 0}
    validates :city
    validates :house_number
    validates :telephone, length: {maximum: 11}
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building: building, telephone: telephone, order_id: order.id)
  end
end