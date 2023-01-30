require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物名が空白でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '購入できないとき' do
      it '郵便番号が空だと購入できない' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号は3桁ハイフン4桁の半角文字列じゃないと購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '発送先の地域に「---」が選択されている場合は購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市区町村が空だと購入できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空だと購入できない' do
        @order_address.addresses = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Addresses can't be blank"
      end
      it '電話番号が空だと購入できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Phone number can't be blank"
      end
      it '電話番号が10桁未満だと購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it '電話番号が11桁より多いだと購入できない' do
        @order_address.phone_number = '1234567890123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it '電話番号に半角数値以外が含まれている場合は購入できない' do
        @order_address.phone_number = '123-4567-8901'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "User can't be blank"
      end
      it '商品が紐付いていなければ投稿できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Item can't be blank"
      end
      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
