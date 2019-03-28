# 簡易仕様書



## バージョン等
- 作者
    - 吉川巧
- アプリ名
    - megurumeApp
- URL 
    - https://github.com/kwtkMe/megurumeApp
- 対象OS 
    - iOS
- 対象Ver
    - 9~12
- 開発環境
    - Xcode 10.1
- 開発言語 
    - Swift 4
- 使用API,SDKなど
    - ぐるなびAPI



## アプリについて

### 機能一覧
- 「ぐるめ」を検索
    - ユーザの現在地を取得し、アプリが提供する範囲の半径から「ぐるめ」を検索する。
- レストラン情報取得
    - 検索条件に基づいた検索結果を表示。
- 電話アプリ連携
    - "店舗詳細画面"から店舗に直接電話をかけることができる(事前に確認のポップアップがある)。
- 地図アプリ連携
    - "店舗詳細画面"から店舗の位置情報をグーグルマップで参照できる。
    - 当該画面の左下のリンクから、グーグルマップAPPにディープリンクできる。

### 画面一覧
- 検索条件入力画面 
    - ユーザの現在地を取得し、アプリが提供する範囲の半径から「ぐるめ」を検索する。
- 検索結果画面
    - "検索条件入力画面"で入力した条件に基づいた検索結果を最大100件まで(ページング処理なし)表示。
- 店舗詳細画面
    - "検索結果画面"で選択した店舗の詳細を表示。
    - 画面右上のボタンから、店舗の位置情報をグーグルマップで参照できる。
    - "電話をかける"ボタンから店舗に直せる電話できる。

### コンセプト
- 「ぐるめ」を検索する！ということで様々なレストラン(料理が出てくるところならなんでも)を検索できるようにしました(結果全件検索という形になってしまいましたが...)。

### こだわったポイント(デザインも)
- アプリが落ちないように慎重に処理を実装しました。
- グーグルマップのアプリを連携させたり、店舗に直接電話ができる機能を実装するなどして、「使える」アプリを目指しました。
- デザイン面に関して、テキストにストレートな黒を使わないようにする、関連のあるデータははっきり集約させるなど、デザインの大原則を意識しながら実装しました。
- ぐるなび公式のブランドカラーに近い色を、アプリを起動した最初の画面に採用しています。
- "電話をかける"ボタンも、公式アプリのイメージカラーを採用しました。

### アドバイスして欲しいポイント
- APIクライアントを用意するとして、シングルトン以外の実装方法や定番の実装パターンがあれば教えていただきたいです。
- アプリの状態(ユーザが位置情報の許可を改めて拒否する、バックグラウンドに入った、など)をフェッチして、安全にアプリを動作させる方法が把握できていないので教えていただきたいです。



## コメントなど

### 自己評価
- 50点。
- これまで幾らかアプリの制作経験があったので、全部わからないというわけではなく、今回の実装がある程度スムーズに行えたことは評価したいと感じました。
- 一方、危惧していたこれまでの経験値がない実装(HTTP通信やAPIの処理をSwiftで書いたことがなかった(!))でかなり手間取ってしまい、不具合を残したまま提出させていただくことになった点、APIの仕様から機能の本質を優先できなかった点で50点です。
- 簡易仕様書の例に「コンセプト」とありましたが、正直なところそこまでこだわっている余裕もなく、春休みに入って悠長にしている場合ではなかったな...という思いです(そのまま体調を崩すなどをして、実質3日ぐらいしか取り組めなかった)。

### 工夫点
- APIクライアントをシングルトンという形で切り出せたのは良かったなと感じます。シングルトンという実装パターン自体のデメリットは理解しながら実装したつもりです。
- 取り組む時間が短い中、開発速度を重視しながら実装できました。特にXibに関しては、使い所を見極めてサッと実装でき、これまでの理解を活かせたと感じました。

### 今回の課題
- エントリーシートに「設計にこだわりたい！」と書かせていただきましたが、今回の課題はかなり愚直なコードで動くものとなってしまいました。
- UIに関して、検索結果画面のサムネイル画像に意図しない反映データの反映がなされてしまいます。
    - UITableViewの仕様を理解しきれていないこと
    - HTTP通信をするタイミング
	のどちらか、もしくは両方が問題かと思います。
- 検索条件をAPIの仕様に(つまりユーザではなく開発者の)都合がいいように実装してしまった点。緯度経度から、該当店舗と現在地との距離を算出するところまでは理解していながらも、実装が間に合わず断念してしまいました。

### 今後の課題 (優先順位うえから)
- UIKitに翻弄されてしまっています。現状満足のいく開発体験ができないのは大方これが原因だと感じているので、特に重視して取り組んでいきたいです。
- プログラミング自体。Optionalやデータ構造に関してかなり理解が危ういと自覚しているためです。
- 命名規則。「Swiftらしい」書き方があるはずだ、と感じながらも学習までに至っていないためです。
- 設計。しかし優先順位は低めと感じました。これまでかなり重視して勉強してきましたが、本質を学ぶのはそれが必要になったタイミングでしかあり得ないかも？と感じたためです。

