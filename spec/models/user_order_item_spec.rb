require 'rails_helper'

RSpec.describe UserOrderItem, type: :model do
  describe '購入情報の保存' do
    before do
      seller = FactoryBot.create(:user)
      buyer = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user_id: seller.id)
      @user_order_item = FactoryBot.build(:user_order_item, user_id: buyer.id, item_id: item.id)
    end

    context '購入情報が保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@user_order_item).to be_valid
      end
      it '建物名が空でも保存できること' do
        @user_order_item.building = nil
        expect(@user_order_item).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'user_idが空では登録できないこと' do
        @user_order_item.user_id = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できないこと' do
        @user_order_item.item_id = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @user_order_item.token = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @user_order_item.postal_code = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @user_order_item.prefecture_id = 0
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include('Prefecture must be other than 0')
      end
      it '市区町村が空だと保存できないこと' do
        @user_order_item.city = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @user_order_item.house_number = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @user_order_item.telephone = nil
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include("Telephone can't be blank")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @user_order_item.postal_code = '1234567'
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include('Postal code is invalid')
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @user_order_item.telephone = '090-123-456'
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include('Telephone is invalid')
      end
      it '電話番号が12桁だと保存できないこと' do
        @user_order_item.telephone = '090123456789'
        @user_order_item.valid?
        expect(@user_order_item.errors.full_messages).to include('Telephone is too long (maximum is 11 characters)')
      end
    end
  end
end
