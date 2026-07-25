# 瑛斗・颯斗 選手カルテ（trampo-karte）

MIC選手育成で運用している「選手カルテ」の仕組みを簡略化して、瑛斗・颯斗（トランポリン、Vanさんの
ご家族）向けに実装したプロジェクト。

## 概要
- ログイン不要、トークン付きURLで選手ごとに閲覧できる「選手カルテ」Webアプリ
- 機能：シーズン目標＋マンダラチャート／短期目標フォームA・B（月次振り返り）／
  技・ジャンプ記録ログ（トランポリン版）／コーチへ共有メモ
- バックエンドは1つのGoogleスプレッドシート＋1つのApps Script（typeパラメータでルーティング）に集約
  （MIC版は5つの別スプレッドシート/Apps Scriptだったが、デプロイの手間を減らすため簡略化）
- シーズン目標・マンダラチャートは、MICの実運用（Googleフォーム＋選手ごとの個別マンダラ
  スプレッドシート）をそのままコピー・adaptする方式で実装（2026-07-25）。新しい選手が増えたら
  フォームの選手名選択肢に追加し、マンダラスプレッドシートをコピーして名簿にURLを追加する運用。

## 公開URL
- コーチ用一覧（トークンなし）: https://vanwhist.github.io/trampo-karte/karte/
- 瑛斗個別ページ: https://vanwhist.github.io/trampo-karte/eito/
- 颯斗個別ページ: https://vanwhist.github.io/trampo-karte/soto/

## 関連リンク
- GitHubリポジトリ: https://github.com/VanWhist/trampo-karte
- Googleスプレッドシート（瑛斗颯斗選手カルテ_DB・名簿など）: https://docs.google.com/spreadsheets/d/1cLgYYs8sqdDYc6_0QFWk-BwXSS-QT0KE7m8hLeH7KBQ/edit
- Apps Script Web App exec URL（2026-07-25、バージョン2に再デプロイ済み）: https://script.google.com/macros/s/AKfycbzOVS9w39ITWrjODvrDuKtUKieeSla-BaDeq1EoHmClTL2tpqC7_KbYw0BzSrvR6aDl/exec
- 瑛斗颯斗 目標設定シート（Googleフォーム、MICの目標設定シートをコピー）: https://docs.google.com/forms/d/1Ejk2E5OoBx3ZSPlkCEBQn1bBTeIPAn5-apBuUdy686E/edit
- 上記フォームの回答スプレッドシート: https://docs.google.com/spreadsheets/d/1Xezq36_rQNOXxralFgeWdJTL7bpA_wLtFqSFCgBt3kc/edit
- マンダラチャート（瑛斗）個別スプレッドシート: https://docs.google.com/spreadsheets/d/1qw0mMZWeFKfbk0un40AsP8FLau6W81Dk7Sc19VKkaqg/edit
- マンダラチャート（颯斗）個別スプレッドシート: https://docs.google.com/spreadsheets/d/1KW7uy7PPisa-yiixmDKIQ2eQop3Tz0zFErKEM87asD0/edit
- Notionプロジェクトページ: https://app.notion.com/p/3a7710fca1f481ea8e37d93bdb67030c
- Notionアプリ・アカウント管理ページ: https://app.notion.com/p/3a7710fca1f4814f998ae85966c34595

## 参照すべき引き継ぎメモ
- handoff_瑛斗颯斗選手カルテ_20260725.md（最新。目標設定シート／マンダラチャートのMICコピー
  実装・Apps Script再デプロイまでの経緯を記載）
- handoff_瑛斗颯斗選手カルテ_20260724.md（実デプロイ・GitHub Pages公開完了までの経緯）

## 注意点
- アップロード用に発行した一時GitHub Personal Access Token（trampo-karte-upload-temp）が
  2026-07-31まで有効。不要になったらVanさん自身での失効を推奨。
- シーズン目標・マンダラチャートの中身（実際の目標文言・9x9マス）はまだ空欄。Vanさんが
  フォームに回答／マンダラスプレッドシートに直接入力する想定。
