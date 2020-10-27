
## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| first_name       | string | null: false |
| family_name      | string | null: false |
| first_name_kana  | string | null: false |
| family_name_kana | string | null: false |
| birth_year       | string | null: false |
| birth_month      | string | null: false |
| birth_day        | string | null: false |

### Association

- has_many :items
- has_many :purchases

# items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| introduction     | string     | null: false                    |
| condition        | string     | null: false                    |
| postage_payer    | string     | null: false                    |
| prefecture       | string     | null: false                    |
| preparation_days | string     | null: false                    |
| price            | string     | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase
- has_many :items_categories
- has_many :categories, through: :items_categories

## items_categories テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| item     | references | null: false, foreign_key: true |
| category | references | null: false, foreign_key: true |

### Association

- belongs_to :items
- belongs_to :category

## categories テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| text   | string | null: false |

### Association

- has_many :items_categories
- has_many :items,  through: :items_categories

# purchases テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item    | string     | null: false                    |
| user    | string     | null: false                    |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |
| address | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :item
- belongs_to :address

## addresses テーブル

| Column       | Type   | Options     |
| -----------  | ------ | ----------- |
| postal_code  | string | null: false |
| prefecture   | string | null: false |
| city         | string | null: false |
| house_number | string | null: false |
| building     | string | null: false |
| telephone    | string | null: false |

### Association

- has_many :purchases