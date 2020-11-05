class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage_payer
  belongs_to :prefecture
  belongs_to :preparation_days

  validates :category, :condition, :prefecture,:postage_payer, :preparation_days, presence: true

  validates :category_id, :condition_id, :postage_payer_id, :prefecture_id, :preparation_days_id, numericality: { other_than: 0 }

end