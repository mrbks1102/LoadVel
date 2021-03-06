# ROADVEL

![TOP](https://user-images.githubusercontent.com/58883305/98902393-fffa1180-24f8-11eb-80b1-248954a27eb2.png)


## 概要
「バイクで行ける観光地を共有・発見しよう!」  
  バイクライダーに向けた、観光地投稿・発見するサービスです。

## URL
https://www.roadvel.com  
【ゲストログイン】ボタンよりゲストユーザーとして簡単にログインができます。

## 本サービスの制作背景
私は趣味でバイクに跨る機会が多く、休日にはよく仲間と旅に出かける機会が多いです。  
ある日に旅に出ようと思った矢先、行き先が中々決まりませんでした。

そこで私は「他にも同じ問題を抱えている人がいるのでは？...」と考え、バイク仲間に「旅の行き先をいつもどうやって探してる？」
と伺ったところ、様々なプラットフォームを駆使して探しているとの答えを頂きました。  
多種多様なプラットフォームを使用するとバイクで行ける観光地を探すことは時間もかかり、困難です。

そして本サービスで、上記の問題を解消したいと考え制作致しました。

## マーケット
・趣味でバイクに乗る人  
・バイクで遠出する人  
・自分の見つけた観光地を共有したい人

## 機能一覧
### 認証機能  
+ サインイン、サインアップ機能 ( devise )  
  * email、パスワード、ユーザー名必須  
  * ゲストログイン機能( アカウント削除・プロフィール編集不可 )
  * omniauth認証によるSNSログイン( Twitter・Facebook )  
+ パスワード編集機能 ( devise )

### 投稿機能
+ 新規投稿ページ
  * 新規投稿機能
  * 投稿確認機能
  * 画像投稿機能( carrierwave )
+ 投稿一覧ページ
  * カテゴリー別投稿表示(人気新着はランキング・他カテゴリーはランダム表示)
+ 投稿詳細ページ
  * コメント表示機能
  * サイドバーにておすすめ・ 新着一覧表示機能
  * 編集リクエスト機能
  * いいね機能
  * お気に入り機能
  * SNSシェア機能( Twiter・ Facebook )
  * 投稿編集ボタンの設置 ( ログイン済み投稿者のみ表示 )
  * 投稿削除ボタンの設置 ( ログイン済み投稿者のみ表示 )
+ 投稿編集ページ
  * 投稿編集機能
+ googlemapAPIによる位置情報表示機能( Geocoding API・ Maps Javascript API )
+ カテゴリー分け機能
  * カテゴリー別投稿一覧機能
  + ページネーション機能
  * ページネーションの非同期通信化 ( Ajax )
### ユーザー機能
+ マイページ  
  * 自身のページ以外は設定アイコン非表示
  * 自身の投稿、コメントした投稿、いいねした投稿、お気に入りした投稿をスライドバーにて表示( jquery )
+ ユーザープロフィール編集ページ
  * ユーザー名、メールアドレス、パスワード、プロフィール画像( Ajaxにてプレビュー表示実装 )の変更
+ セッティングページ
  * アカウント削除機能
  * ログアウト機能
  * フッター各種リンク( about、利用規約、お問い合わせ、プライバシーポリシー )
### 検索機能
+ カテゴリー別チェックボックス、フリーワードにて検索可能。併用で検索も可能 ( ransack )
### 通知機能
+ ヘッダー部ベルマークにて通知機能を実装 ( コメント、いいねされた時に通知 )
+ 新規通知バッジ機能
+ ページネーション機能
+ ページネーションの非同期通信化 ( Ajax )
### カテゴリー機能
+ 中間テーブルにてPostテーブルと多対多で提携 ( ER図参照 )
+ チェックボックスを採用した実装
### いいね・お気に入り機能
+ 非同期通信にて即時反映( Ajax )
### コメント機能
+ 各投稿にコメント機能を実装
+ コメント削除機能 ( ログイン済み投稿者のみ表示 )
### 問い合わせ機能
+ フッター・プロフィール設定ページ・投稿詳細ページ編集リクエストボタンにて、問い合わせが可能  
( ActionMailer )
### 管理者機能
+ rails_admin gemにて管理者ページを実装
+ DBに保存されているデータを管理者が容易に編集可能
### CSV出力機能
+ 全投稿の住所、観光地名一括CSV出力する機能 ( 全観光地のデータ取得 )

## 環境・使用技術
### フロントエンド
* javascript
* jQuery
* HTML/CSS
* Slim
* Scss

### バックエンド
+ Ruby 2.6.3
+ Rails 5.2.4.3

### 開発環境
+ Docker/docker-compose
+ PostgreSQL

### 本番環境
+ AWS ( EC2、RDS for postgresql、ALB、Route53、VPC、ACM )
+ Nginx、unicorn
+ CircleCI/CD( Rspec、Rubocop自動化 )
+ Capistrano( 自動デプロイ )

### その他技術
+ レスポンシブデザイン
+ Rspecを導入しテスト記述( 単体/統合 )
+ Rubocopを導入しリンター機能の活用
+ Git flowを意識した開発
+ Git チーム開発を意識したissue・プルリクエストの活用
+ Git コミットメッセージからissueを開けるようissue番号の紐付け
+ AWS ACMにてSSL証明書を発行しSSL化
+ ドメインを取得し、分かりやすいURLの実装
+ dotenv-rails gem を使用し環境変数を設定

## AWS構成図
![AWS構成図](https://user-images.githubusercontent.com/58883305/94923332-a31d3b80-04f6-11eb-9732-41d6630dfe1b.png)
## ER図
![erd](https://user-images.githubusercontent.com/58883305/95363729-cd159a00-090a-11eb-9290-40d641175405.png)


## 工夫点
+ フロントエンド  
  * ユーザーにとって直感的に操作できるようUI/UXをなるべくシンプルで分かりやすいデザインにした。  
  * ユーザーで無くとも疑問点があった場合にコンタクトが取れるようフッター部に問い合わせ機能を実装。
  * ヘッダー部はレスポンシブ時の利便性を考え、ハンバーガーバーを実装
  * 一目で通知がわかるようバッジ機能の実装

+ バックエンド
  * 観光地の共有ということで、地図APIを用いて地図を可視化できるよう実装
  * 手軽にログインできるようomniauth認証を採用し、SNSログインを実装( Twitter・Facebbok )
  * 観光地を目視する為に、画像投稿機能の実装。
  * 投稿間違いを防止する為投稿確認ページの実装。またユーザーの工数を減らす為前ページ戻った際に値を維持するよう実装
  * 様々な編集を容易に行う為、管理者画面の実装
  * ファットコントローラーとならぬよう出来る限りモデル側に処理を実装


+ 技術
  * モダンな技術の採用。( CircleCI・Docker・AWS・Capistrano )  
    常に新しい技術に挑戦し、Railsだけの知識では無く様々な技術の知識を蓄えた。
  * Rubocopを使用し、コードの品質維持
  * Rspecを使用し、保守性の高いアプリケーションの実現
  + 変更後即時に本番環境で確認できるようcapistranoの( 自動デプロイ )実装

## 今後実装する機能
詳細は[issue](https://github.com/mrbks1102/RoadVel/issues)に記述しておりますのでご覧ください。

## About me
現在21歳で某鉄道会社勤務の4年目になります。webエンジニアを目指して日々勉強しアウトプットを行なっています。  
[Twitter](https://twitter.com/otterminal)  
[Qiita](https://qiita.com/otterminal)


