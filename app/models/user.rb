class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # ニックネームが必須であること
  validates :nickname, presence: true

  # メールアドレスが一意性であること
  validates :email, uniqueness: true

  # パスワードは、確認用を含めて2回入力すること
  #  参照：https://railsguides.jp/active_record_validations.html
  # validates :encrypted_password, confirmation: true, presence: true
  # validates :encrypted_password_confirmation, presence: true

  # パスワード半角英数字混合での入力が必須
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: '英字と数字の両方を含めて設定してください'
 
  # ユーザー本名は、名字と名前がそれぞれ必須であること
  # ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること
  validates :first_name, :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "全角（漢字・ひらがな・カタカナ）のみが使えます"}

  # ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること
  # ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること
  validates :family_name_kana, :family_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/, message: "全角（カタカナ）のみが使えます"}
  
  # 生年月日が必須であること
  validates :birthday, presence: true
end
