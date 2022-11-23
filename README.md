# firebase_talk_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 注意事項1
flutterfire configureを行う
すでにfirebaseプロジェクトを作成している必要あり。(https://firebase.google.com/?hl=ja)
## 注意事項2
エミュレータの時間のデフォルトはUTCなので、日本時間に変更する必要がある。
UTCに変更するには、エミュレータの設定を開き、 「Date & Time」の「Time Zone」を「Asia/Tokyo」に変更する。
変更しないと、FirebaseのTimestampがUTCになってしまいトークルームがおかしくなる。


flutterfire configure