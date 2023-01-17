# DB 設計

## users table

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date_year    | string | null: false               |
| birth_date_month   | string | null: false               |
| birth_date_day     | string | null: false               |

### Association
- has_many :items
- has_many :orders


## items table

| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| sales_status        | string     | null: false                    |
| shipping_fee_status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled_delivery  | string     | null: false                    |
| price               | integer    | null: false                    |
| add_tax_price       | integer    | null: false                    |
| profit              | integer    | null: false                    |
| user_id             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order


## orders table

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | string     | null: false                    |
| user_id      | references | null: false, foreign_key: true |
| item_id      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :item