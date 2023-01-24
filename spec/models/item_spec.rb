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
      it 'category_idが空だと登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'sales_status_idが空だと登録できない' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Sales status can't be blank"
      end
      it 'shipping_fee_status_idが空だと登録できない' do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee status can't be blank"
      end
      it 'prefecture_idが空だと登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'scheduled_delivery_idが空だと登録できない' do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Scheduled delivery can't be blank"
      end
      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceが300円より安いと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
      it 'priceが9999999円より高いと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
      it '価格に半角数字以外が含まれている場合は出品できない' do
        @item.price = '1000a'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price Half-width number"
      end
    end
  end
end
