
## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :purchases

# items テーブル

| Column              | Type       | Options           |
| ------------------- | ---------- | ----------------- |
| name                | string     | null: false       |
| introduction        | text       | null: false       |
| category_id         | integer    | null: false       |
| condition_id        | integer    | null: false       |
| postage_payer_id    | integer    | null: false       |
| prefecture_id       | integer    | null: false       |
| shipping_time_id    | integer    | null: false       |
| price               | integer    | null: false       |
| user                | references | foreign_key: true |
| order               | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :order

# orders テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| item    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| postal_code   | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| house_number  | string     | null: false       |
| building      | string     |                   |
| telephone     | string     | null: false       |
| order         | references | foreign_key: true |

### Association

- belongs_to :order