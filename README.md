HMP
====

Yaml形式の設定ファイルを使う、簡単なバックアップツールです。
名前は人類は衰退しましたのヒト・モニュメント計画の英訳、`Human Monument Project`の頭文字から来ています。

## Description
簡単に**ラフな**バックアップを行いたいと思い、GSuiteのGoogle Driveとローカルでそれぞれバックアップを保持するツールです。
Google Driveは無制限なのでフルバックアップのみ対応予定です。

## Demo

## VS. 

## Requirement

## Usage
1. `config.yml`で設定をする。

## Install

## Settings
### config.yml
ルートディレクトリにあるconfig.yml
```yaml
config_dir: './config' # バックアップの設定ファイルを置くディレクトリ

default: # デフォルト値、それぞれの設定ファイルで同じ値を指定した場合、上書きされる。
  target: './target' # バックアップ先
  format: 'zip'      # バックアップの圧縮形式(現在zipのみ) ※未使用
  time: '06:00:00'   # バックアップ開始時間
  keep: 7            # バックアップの保持日数(0ならば削除なし)
```

### (samename).yml
config.ymlの`config_dir`の中のymlファイル
```yaml
name: "Minecraft_Server" # バックアップの名前
description: "Minecraft Server" # 説明 ※未使用
backup: # config.ymlのデフォルト値と対応
  source: "/home/jo3qma/works/Twikeshi" # バックアップ元
```

## Contribution

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[JO3QMA](https://github.com/JO3QMA)