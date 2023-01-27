class OrderAddress
  include ActiveModel::Model
  attr_accessor :user, :item, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :addresses
    validates :phone_number,format: {with: \A0\d{9,10}\z, message: "is invalid. Input only number"}
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user: user.id, item: item.id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number:phone_number, order: order.id)
  end
end