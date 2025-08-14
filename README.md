# ClassView

ClassView は、学生の時間割情報とキャンパスの地図を連携させ、**学生生活をサポートする Web アプリ**です。  
Rails を基盤として構築され、関係モデルによるデータ設計を行っています。

> ※学内利用を前提としたデータを使用しています

---

## 📌 特徴

- Rails を基盤にした堅牢な Web アプリ
- Google・Twitter の**Omniauth 認証**および **Devise** によるユーザー認証
- **Leaflet + OpenStreetMap** を用いた地図表示でキャンパスや教室を可視化
- **Bootstrap** によるレスポンシブで使いやすい UI
- 関係モデルを活用したデータ設計により、時間割とキャンパス情報を効率的に管理

---

## 🛠 使用技術

- Ruby on Rails
- Devise
- OmniAuth (Google, Twitter)
- Leaflet.js + OpenStreetMap
- Bootstrap 5
- HTML/CSS/JavaScript

---

## 🚀 セットアップ方法

```bash
# リポジトリをクローン
git clone git@github.com:AoiKarakuchi/ClassView.git
cd classview

# 依存関係をインストール
bundle install
yarn install

# データベース作成とマイグレーション
rails db:create db:migrate

# サーバー起動
bin/dev

---

## 💡 注意
- チームメンバー全員がRails未経験で作成したため、現在テストは未実装です
- ただし、主要機能は動作確認済みです

```
