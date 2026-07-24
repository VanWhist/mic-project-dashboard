# 瑛斗・颯斗 選手カルテ（trampo-karte）

MIC選手育成で運用している「選手カルテ」の仕組みを簡略化して、瑛斗・颯斗（トランポリン、Vanさんの
ご家族）向けに実装したプロジェクト。

## 概要
- ログイン不要、トークン付きURLで選手ごとに閲覧できる「選手カルテ」Webアプリ
- 機能：シーズン目標＋マンダラチャート／短期目標フォームA・B（月次振り返り）／
  技・ジャンプ記録ログ（トランポリン版）／コーチへ共有メモ
- バックエンドは1つのGoogleスプレッドシート＋1つのApps Script（typeパラメータでルーティング）に集約
  （MIC版は5つの別スプレッドシート/Apps Scriptだったが、デプロイの手間を減らすため簡略化）

## 公開URL
- コーチ用一覧（トークンなし）: https://vanwhist.github.io/trampo-karte/karte/
- 瑛斗個別ページ: https://vanwhist.github.io/trampo-karte/eito/
- 颯斗個別ページ: https://vanwhist.github.io/trampo-karte/soto/

## 関連リンク
- GitHubリポジトリ: https://github.com/VanWhist/trampo-karte
- Googleスプレッドシート（瑛斗颯斗選手カルテ_DB）: https://docs.google.com/spreadsheets/d/1cLgYYs8sqdDYc6_0QFWk-BwXSS-QT0KE7m8hLeH7KBQ/edit
- Apps Script Web App exec URL: https://script.google.com/macros/s/AKfycbzOVS9w39ITWrjODvrDuKtUKieeSla-BaDeq1EoHmClTL2tpqC7_KbYw0BzSrvR6aDl/exec
- Notionプロジェクトページ: https://app.notion.com/p/3a7710fca1f481ea8e37d93bdb67030c
- Notionアプリ・アカウント管理ページ: https://app.notion.com/p/3a7710fca1f4814f998ae85966c34595

## 参照すべき引き継ぎメモ
- handoff_瑛斗颯斗選手カルテ_20260724.md（最新。実デプロイ・GitHub Pages公開完了までの経緯を記載）

## 注意点
- アップロード用に発行した一時GitHub Personal Access Token（trampo-karte-upload-temp）が
  2026-07-31まで有効。不要になったらVanさん自身での失効を推奨。
