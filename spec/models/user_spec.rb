require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録がうまくいくとき' do
      it 'すべての要素が正しく入力されていると登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'ニックネームが未入力だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが未入力だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '既登録のメールアドレスだと登録できない' do
        user2 = FactoryBot.create(:user)
        @user.email = user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@が含まれていないと登録できない' do
        @user.email = 'test55gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが未入力だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、5文字以下だと登録できない' do
        @user.password = '0000a'
        @user.password_confirmation = '0000a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが半角数字のみだと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it '確認用パスワードが未入力だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードと確認用パスワードの値が不一致だと登録できない' do
        @user.password_confirmation = ("#{Faker::Internet.password(min_length: 4)}2a")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe '新規登録/本人情報確認' do
    # ↓上記『describe '新規登録/ユーザー情報' do』で確認済み
    # context '新規登録がうまくいくとき' do
    #   it "すべての要素が正しく入力されている" do
    #     expect(@user).to be_valid
    #   end
    # end

    context '新規登録がうまくいかないとき' do
      it 'ユーザー本名は、名字が未入力だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'ユーザー本名は、名前が未入力だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.family_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name には全角（漢字・ひらがな・カタカナ）のみが使えます')
      end
      it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name には全角（漢字・ひらがな・カタカナ）のみが使えます')
      end
      it 'ユーザー本名のフリガナは、名字が未入力だと登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、名前が未入力だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名の名字のフリガナは、全角（カタカナ）でないと登録できない' do
        @user.family_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana には全角（カタカナ）のみが使えます')
      end
      it 'ユーザー本名の名前のフリガナは、全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角（カタカナ）のみが使えます')
      end
      it '生年月日が未入力だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
