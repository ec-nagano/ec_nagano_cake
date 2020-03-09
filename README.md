![ec_nagano_cake](https://user-images.githubusercontent.com/59187251/75845555-d1ca1b00-5e1c-11ea-840a-4f0dd74c12f3.jpg)
# Built with

- **Ruby** v.2.5.7
- **Rails** v.5.2.4.1
- **SQlite3** v.1.4.2
- **HTML5 & CSS3**
- **Gems**
    - **jQuery-rails** v.4.3.5
    - **Bootstrap-sass** v.3.4.1
    - **devies** v.4.7.1
    - **RSpec-rails** v.3.9.0

# Introduction

DMM WEB CAMP２ヶ月目のチーム開発での製作物です。  
ケーキ販売店のECサイトのデモアプリです。  
管理者としてログインした場合、商品の登録、注文状況の管理等ができ、顧客としてログインした場合、
商品をカートに追加、注文等の処理をすることができます。
# How to start

```
$ git clone https://github.com/ec-nagano/ec_nagano_cake.git
$ cd ec_nagano_cake
$ rails db:seed
$ rails s -b 0.0.0.0
```
[ローカルサーバー](http://localhost:3000/)にアクセスしてください。  
管理者としてログインする場合、[http://localhost:3000/admins/sign_in](http://localhost:3000/admins/sign_in)にアクセスし、  
メールアドレス：　**ec_nagano_cake@email**  
パスワード：　**password**  
で、ログインしてください。

# Team member
- [Tama](https://github.com/hewhe)
    - 顧客側、管理者側ログイン処理関連
    - 管理者側注文処理関連
    - トップページ
    - レイアウト
    - コードレビュー
- [MHR-2477380](https://github.com/MHR-2477380)
    - 管理者側商品、ジャンル管理処理関連
    - 管理者側顧客処理関連
    - レイアウト
- [stat-ki](https://github.com/stat-ki)
    - 顧客側カート、注文処理関連
    - ヘッダー（検索機能）実装
    - ajax実装
    - UIテスト
    - コードレビュー
    - リファクタリング
- [takanari-y](https://github.com/takanari-y)
    - 顧客側登録情報処理関連
    - 顧客側商品情報処理関連
    - レイアウト

# README.md　Author
[stat-ki](https://github.com/stat-ki)  
mail to: per_ik at outlook.com
