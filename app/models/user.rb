class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # ニックネームが必須であること
  validates :nickname, presence: true

  # パスワード半角英数字混合での入力が必須
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
 
  # ユーザー本名は、名字と名前がそれぞれ必須であること
  # ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること
  validates :family_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "には全角（漢字・ひらがな・カタカナ）のみが使えます"}

  # ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること
  # ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること
  validates :family_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/, message: "には全角（カタカナ）のみが使えます"}
  
  # 生年月日が必須であること
  validates :birthday, presence: true
end
