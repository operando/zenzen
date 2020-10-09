## zenzen

Slackのほとんどのチャンネルから退出できるコマンドラインツールです。

退出したチャンネル情報はJSONファイルに出力されるので、そのJSONファイルを利用して、退出したチャンネルにまとめて再入場することもできます。

以下のチャンネルは自動退出対象外です。

- Archived channel 
- Private channel 
- General channel

## Run

```
// leave channels
zennzenn leave

or
// rejoin channels
zennzenn rejoin
```

## Config File

```
[slack]
user_id="UXXXXXX"
token="xoxp-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
rejoin_channel_json_file="XXXXXXXXXXX.json"
not_leave_channels=["C0XXXXX","todo","#android"]
```


## Build

```
dart2native bin/slack_leave_rejoin_channel.dart -o zenzen
```