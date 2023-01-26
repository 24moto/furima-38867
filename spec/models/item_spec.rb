require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品登録' do
    context '出品登録できるとき' do
      it 'image、name、info、category_id、sales_status_id、shipping_fee_status_id、prefecture_id、scheduled_delivery_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品登録できないとき' do
      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it 'infoが空だと登録できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Info can't be blank"
      end
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Sales status can't be blank"
      end
      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee status can't be blank"
      end
      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Scheduled delivery can't be blank"
      end
      it '価格が空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it '価格が300円より安いと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is out of setting range'
      end
      it '価格が9999999円より高いと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is out of setting range'
      end
      it '価格に半角数字以外が含まれている場合は出品できない' do
        @item.price = '1000a'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price Half-width number'
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
