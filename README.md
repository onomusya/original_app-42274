# 🏕 オリジナルキャンプ場予約サイト

## 概要

1つの架空のキャンプ場に対して、A〜Dの4サイトの予約管理ができるWebアプリケーションです。  
ユーザー登録から予約・決済までをシームレスに提供します。

---

## 使用技術

- フロントエンド: HTML, CSS, JavaScript
- バックエンド: Ruby 3.2.0 / Rails 7.1
- データベース: MySQL 8
- 認証: Devise
- カレンダーUI: simple_calendar
- 決済: PAY.JP
- その他: Google Maps API

---

## 機能一覧

### 🔐 ユーザー機能（Devise）
- 新規登録 / ログイン / ログアウト
- ログインユーザーのみ予約可能

### 📅 予約機能
- simple_calendar によるカレンダーUI
- サイト別予約可否表示（○, ▲, ×）
- 予約作成 / キャンセル

### 💳 決済機能（PAY.JP）
- クレジットカードによる事前決済

### 📖 その他のページ
- サイト紹介ページ
- 施設ルールページ
- レンタル/販売品ページ
- アクセス（Google Maps）

---

## ER図（簡略）

User -< Reservation >- Site | Payment


---

## テーブル構成（抜粋）

### users

| カラム名           | 型       | 備考                         |
|--------------------|----------|------------------------------|
| email              | string   | Deviseで自動生成             |
| encrypted_password | string   | Deviseで自動生成             |
| name               | string   | ユーザー名                   |

### sites

| カラム名    | 型     | 備考           |
|-------------|--------|----------------|
| name        | string | A〜Dなどの識別名|
| description | text   | サイト紹介文   |

### reservations

| カラム名     | 型     | 備考                      |
|--------------|--------|---------------------------|
| user_id      | integer| 外部キー                   |
| site_id      | integer| 外部キー                   |
| start_date   | date   | 予約開始日                 |
| end_date     | date   | 予約終了日                 |
| status       | string | 予約状態（pendingなど）    |
| payment_status | string | 支払い状態（paidなど）   |
| total_price  | integer| 合計金額                   |

### payments

| カラム名         | 型     | 備考                      |
|------------------|--------|---------------------------|
| reservation_id   | integer| 外部キー                   |
| payjp_charge_id  | string | PAY.JPの決済ID            |
| amount           | integer| 支払い金額                 |

### rental_items

| カラム名    | 型     | 備考                      |
|-------------|--------|---------------------------|
| name        | string | 商品名                     |
| description | text   | 商品説明                   |
| price       | integer| 価格                       |
| category    | string | "rental" or "sale"         |
