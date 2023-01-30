FactoryBot.define do
  factory :order_address do
    postal_code   {'111-1111'}
    city          {'テスト市'}
    addresses     {'テスト町'}
    building      {'テストビル'}
    phone_number  {'09012345678'}
    prefecture_id {10}
  end
end