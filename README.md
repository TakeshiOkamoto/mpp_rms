# ご依頼管理システム
Ruby on Railsの練習用に作成したものです。 [DEMO](https://www.petitmonte.com/rails-demo/rms) ※デモ運用にメモリ50-100MB使用。
  
Railsはメモリ食べ過ぎなので、サーバーのメモリ節約の為に1つのプロジェクト内に複数プロジェクトを混在できる設計になっています。その為、モデル名がUserであるべき所がRmsUserなどになっています。

```rb
mpp_rmsの意味
```
  
mpp = My Practice Project  
rms = Request Management System 
   
## 1. 環境
・Ruby 2.6.5  
・Rails 6.0.1  
・MariaDB 10.2.2以上(MySQL5.5.8以上でも可)  
 
 
## 2. インストール方法
私のメモ用に書いておきます。

### bundle  
```rb
bundle install 
```

### マスタキーの生成 
・/config/master.key  
・/config/credentials.yml.enc  
は削除しています。次のコマンドで再生成します。  
```rb
EDITOR=vi bin/rails credentials:edit   
```  
ファイル生成後、credentials.yml.encの編集画面が表示されるので:q!で終了します。

development.rb/production.rbの両方に  
```rb
config.require_master_key = true  
``` 
を定義しているのでマスタキーの生成は必須です。   
  
### Webpackerのインストール  
node_modulesフォルダ及びyarn.lockファイルを削除していますので次のコマンドでインストールします。  
```rb  
bin/rails webpacker:install  
```
### CSS/JSファイルをプリコンパイルする
```rb  
bin/rails assets:precompile  
```  

### ユーザーの作成
```rb  
bin/rails c  
  
user = RmsUser.new(name: '名前', password: 'パスワード', password_confirmation:'パスワード', admin: true)  
user.save  
exit 
```  

## 3. Rails6プロジェクトの各種初期設定
その他は次の記事を参照してください。  
  
[Rails6プロジェクトの各種初期設定](https://www.petitmonte.com/ruby/rails6_project.html)  
