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
| postal_code        | string   | 郵便番号                     |
| address            | string   | 住所                        |

### sites

| カラム名    | 型         | 備考           |
|-------------|----------|----------------|
| name        | string   | A〜Dなどの識別名  |
| capacity    | integer  | 収容人数         |
| price       | integer  | 1泊の基本料金     |
| description | text     | サイトの説明（任意）|

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


トップページ
-----------------------------------------------------------
| ロゴ | メニュー（サイト紹介 | 予約する | マイページ | ログイン） |
-----------------------------------------------------------
|                メインビジュアル（大きなキャンプ場の写真）                |
|                 [スライドショー機能]                                     |
-----------------------------------------------------------
|     空き状況を確認する（ボタン/リンク）          初めての方へ（ボタン/リンク）    |
|     【予約する】                                    【施設情報】                    |
-----------------------------------------------------------
|     施設紹介（カード形式）                           レンタル品紹介（カード形式）    |
|     【施設名】【写真】【簡単な紹介】            【品名】【アイコン】【料金】   |
-----------------------------------------------------------
|     フッター（会社情報、利用規約、プライバシーポリシー）                   |
-----------------------------------------------------------
メインビジュアル: 魅力的なキャンプ場の写真を大きく表示して、ユーザーの関心を引く。

空き状況確認ボタン: 仕事終わりにすぐに予約を確認できるよう、視認性高く配置。

施設紹介: 各施設（サイトA〜D）を紹介するセクションで、各施設をイメージしやすいアイコンや簡単な紹介を掲載。

レンタル品紹介: どんなレンタル品があり、どれを選ぶかを一目で確認できるようにカード型のレイアウト。


予約カレンダー画面
-----------------------------------------------------------
| ヘッダー（戻るボタン | サイト選択 | カレンダー）                           |
-----------------------------------------------------------
|              月単位カレンダー（シンプルカレンダー表示）                   |
|    [日] [月] [火] [水] [木] [金] [土]                                   |
|    01  02  03  04  05  06  07   →  ⚪︎   ⚪︎    ▲    ×   ⚪︎   ⚪︎   ▲   |
|    08  09  10  11  12  13  14   →  ×   ⚪︎   ▲    ⚪︎   ⚪︎   ⚪︎   ▲    |
|    ....                                                            |
-----------------------------------------------------------
|     日付をクリックすると予約フォームへ遷移                             |
-----------------------------------------------------------

カレンダー表示: 月ごとに曜日と日付を並べ、空き状況を⚪︎（空き）、▲（少し空き）、×（満席）で表示。

視覚的にわかりやすい: 色分けして、ユーザーが空き日を一目で判断できるように。


予約フォーム画面
-----------------------------------------------------------
| ヘッダー（戻るボタン | サイト選択 | 予約フォーム）                        |
-----------------------------------------------------------
| 【サイト選択】（ドロップダウンメニュー）                                   |
| 【日付】（カレンダーから選択）                                            |
| 【人数】（ドロップダウンメニュー）                                        |
| 【レンタル品】（チェックボックス形式）                                   |
|    - バーナー（+500円）                                                   |
|    - テント（+1000円）                                                   |
|    - クーラーボックス（+300円）                                           |
-----------------------------------------------------------
| 【クレジットカード決済】（カード情報入力フォーム）                       |
|    - クレジットカード番号                                                 |
|    - 有効期限                                                             |
|    - セキュリティコード（CVV）                                           |
-----------------------------------------------------------
| 【確認画面へ】（ボタン）                                                 |
-----------------------------------------------------------

選択項目: サイト、人数、レンタル品を選択するシンプルなフォーム。

クレジットカード決済: 支払いに必要なカード情報を入力できるフィールド。

ボタン: 「確認画面へ」で最終確認後、予約確定。


予約完了画面
-----------------------------------------------------------
| ヘッダー（マイページ | 予約確認 | ログイン）                               |
-----------------------------------------------------------
|      予約完了メッセージ（キャンプ場名、日付、サイト名）                    |
|      「ご予約ありがとうございます」                                       |
-----------------------------------------------------------
|      予約詳細（予約内容、金額、レンタル品）                               |
|      - サイト名: A                                                           |
|      - 日付: 2025年5月15日〜2025年5月16日                                   |
|      - レンタル品: バーナー（+500円）                                      |
|      - 合計金額: 3000円                                                     |
-----------------------------------------------------------
|      [予約確認メールを送信しました]（ボタン）                               |
-----------------------------------------------------------

予約確認: 確定した予約内容がすぐに表示され、ユーザーが間違いなく確認できる。

確認メール通知: メールが送信されたことを通知し、安心感を提供。


マイページ画面
-----------------------------------------------------------
| ヘッダー（マイページ | 予約履歴 | 設定）                                   |
-----------------------------------------------------------
| 【ユーザー情報】                                                          |
|    - 名前                                                                  |
|    - メールアドレス                                                        |
|    - 連絡先                                                                |
-----------------------------------------------------------
| 【現在の予約】（一覧）                                                    |
|    - キャンプ場A 2025年5月15日〜16日                                       |
|    - キャンプ場B 2025年6月1日〜3日                                        |
-----------------------------------------------------------
| 【過去の予約】（一覧）                                                    |
|    - キャンプ場A 2025年4月20日〜21日（キャンセル済み）                    |
-----------------------------------------------------------
| 【キャンセルボタン】（キャンセルしたい予約に）                            |
-----------------------------------------------------------
ユーザー情報: ユーザーの基本情報を簡単に表示。

予約履歴: 現在と過去の予約が一覧で確認でき、キャンセルや変更のオプションを提供。