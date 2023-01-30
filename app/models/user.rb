class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  ZENKAKU_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  KATAKANA_REGEXP = /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/.freeze

  validates :password, format: {
    with: VALID_PASSWORD_REGEX,
    message: ' is invalid.Include both letters and numbers'
  }
  validates :nickname, presence: true
  validates :last_name, presence: true,
                        format: {
                          with: ZENKAKU_REGEX,
                          message: ' is invalid.Input full-width characters'
                        }
  validates :first_name, presence: true,
                         format: {
                           with: ZENKAKU_REGEX,
                           message: ' is invalid.Input full-width characters'
                         }
  validates :last_name_kana, presence: true,
                             format: {
                               with: KATAKANA_REGEXP,
                               message: ' is invalid.Input full-width katakana characters'
                             }
  validates :first_name_kana, presence: true,
                              format: {
                                with: KATAKANA_REGEXP,
                                message: ' is invalid.Input full-width katakana characters'
                              }
  validates :birth_date, presence: true
end
