## zenzen

今現在入っているほとんどのSlackチャンネルから簡単に退出できるコマンドラインツールです。

退出したチャンネル情報はJSONファイルに出力されるので、そのJSONファイルを利用して、退出したチャンネルにまとめて再入場するコマンドも用意しています。

![](images/zenzen.gif)

## Run

```
// leave channels
zennzenn leave

or

// rejoin channels
zennzenn rejoin
```

### zennzenn leave

今現在入っているほとんどのSlackチャンネルから退出します。

以下のチャンネルは自動退出対象外です。

- Archived channel 
- Private channel 
- General channel

また、`zennzenn leave`実行時に、退出したくないチャンネルの情報をconfig fileに記載できます。

退出したチャンネル情報はJSONファイルに出力されます。このファイルは`zennzenn rejoin`実行時に必要になります。

### zennzenn rejoin

`zennzenn leave`実行時に出力される退出したチャンネル情報が記載されたJSONファイルを利用します。

そのJSONに記載されているチャンネルすべてに再入場します。

ファイルの指定はconfig fileに記載します。

## Setup

### Create a Slack App

以下のリンクから本ツールを動かすためのSlack Appを作成します。

https://api.slack.com/apps

### Setup user token scopes

Slack Appを作成したら、User Token Scopesを以下の画像のように設定します。

![](images/slack_user_token_scopes.png)


### Add an app to your workspace

作成したSlack Appをワークスペースにインストールします。


### Create config file

zennzennコマンドを実行するディレクトリと同じところに、`config.toml` を作成します。

`config.toml` の内容は以下のように書きます。

```
[slack]
# 自身のslack user id（required）
user_id="UXXXXXX"

# Slack AppのOAuth Access Token (required)
token="xoxp-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 

# zennzenn leave実行時に、退出したSlackチャンネル情報がJSONファイルで書き出されます。
# zennzenn rejoinで、そのJSONに記載されているチャンネルすべてに再入場します。
# (required : zennzenn rejoin実行時)
rejoin_channel_json_file="XXXXXXXXXXX.json"

# zennzenn leave実行時に、退出したくないチャンネルの情報を記載できます (optional)
not_leave_channels=["C0XXXXX","todo","#android"] 
```

`config.toml`の内容に問題がなければ、`zennzenn leave` と `zennzenn rejoin` が動くようになります。


## Build

```
dart2native bin/zennzenn.dart -o zenzen
```