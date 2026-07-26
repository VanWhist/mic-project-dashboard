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
- シーズン目標設定シートの9セクションの並び順について、チャッピー（ChatGPT）に相談のうえ
  「自己分析」を「将来の目標」の前に、「大会使用予定技」を「今年の目標」の直後に移動し、
  後者のセクション名を「大会で使う演技・挑戦したい演技」に変更（2026-07-25）。新しい順番は
  目標設定シート→競技について→自己分析(5段階評価)→将来の目標→今年の目標→
  大会で使う演技・挑戦したい演技→生活習慣→サポートについて→最後に。質問文自体は未変更。
- 「大会振り返り」フォームを個人競技／シンクロ競技で分岐する構成（6→13セクション）に
  再設計（2026-07-25）。「個人競技の確認」「シンクロ競技の確認」というラジオボタン質問
  （はい/いいえ）で、出場していない種目のセクションを自動スキップ。シンクロには
  「ペアとのタイミングはどうだった？」等の専用設問も追加。
- シーズン中（大会が月1回ペース）は、短期目標（月次）フォームを省略し、大会振り返り→
  次の大会前目標のサイクルで運用する方針を決定（2026-07-25、チャッピーと相談）。
  オフシーズン・大会間隔6週間以上のときは短期目標（月次）フォームを使う。あわせて
  「大会前の目標」フォームに「大会とは別に、今月取り組みたいことはありますか？」
  「そのために何をしますか？」の2問を追加し、大会目標だけでは拾いにくい育成課題
  （新技習得・体力・生活習慣など）を補足できるようにした。
- 大会振り返りフォームは、MICを流用せずチャッピー（ChatGPT）と相談してトランポリン競技特化で
  新規設計（2026-07-25）。瑛斗・颯斗共通の1フォーム（回答時に名前を選択）方式、PDCA型の設問構成。
- 4シート連動（中長期目標／短期目標／大会振り返り／次の大会の目標シート）は、チャッピー提案の
  「年間→月間→大会前→大会後」コーチングサイクル＋テーマ制の本格導入を来シーズンに送り、今シーズン
  中は短期目標・大会前目標をシンプルな単体フォームとして別々に作る方針で決定（2026-07-25）。
  「短期目標（月次）」「大会前の目標」の両フォームを単体フォームとして新規作成・公開済み（2026-07-25）。
  どちらもkarte/index.html・Code.gsへの組み込みはまだ（現状はGoogleフォーム単体）。
- 選手カルテのUIについてチャッピー（ChatGPT）にレビューを依頼し、改善提案を受けて実装（2026-07-25）。
  karte/index.html内の既存VIEW_MODE変数（コーチ用一覧=coach／選手個別ページ=player）を使い、
  コーチ用一覧は現行レイアウトを維持したまま、瑛斗・颯斗の個別ページにのみ「今、大事にしたいこと」
  カード新設・シーズン目標カードの分割・マンダラの案内文/表記の子ども向け化・生活習慣タイル2列化・
  文字サイズ拡大を適用。あわせて選手個別ページのURLを正しいローマ字読みに合わせて
  /eito/・/soto/ → /akito/・/hayato/ に変更。
- 目標設定フォームの「競技について」6項目（開始時期・きっかけ・好きなところ・尊敬する選手・強み・
  今の課題）が回答済みなのに画面に一切表示されていなかった表示漏れを発見・修正（2026-07-26）。
  Code.gsに抽出ロジックを追加し、karte/index.htmlに新しい「競技について」カードを新設。
  Apps Scriptはバージョン4として再デプロイ済み。

## 公開URL
- コーチ用一覧（トークンなし）: https://vanwhist.github.io/trampo-karte/karte/
- 瑛斗個別ページ（akito）: https://vanwhist.github.io/trampo-karte/akito/
- 颯斗個別ページ（hayato）: https://vanwhist.github.io/trampo-karte/hayato/

## 関連リンク
- GitHubリポジトリ: https://github.com/VanWhist/trampo-karte
- Googleスプレッドシート（瑛斗颯斗選手カルテ_DB・名簿など）: https://docs.google.com/spreadsheets/d/1cLgYYs8sqdDYc6_0QFWk-BwXSS-QT0KE7m8hLeH7KBQ/edit
- Apps Script Web App exec URL（2026-07-26、バージョン4に再デプロイ済み。競技について6項目を追加）: https://script.google.com/macros/s/AKfycbzOVS9w39ITWrjODvrDuKtUKieeSla-BaDeq1EoHmClTL2tpqC7_KbYw0BzSrvR6aDl/exec
- 瑛斗颯斗 目標設定シート（Googleフォーム、MICの目標設定シートをコピー）: https://docs.google.com/forms/d/1Ejk2E5OoBx3ZSPlkCEBQn1bBTeIPAn5-apBuUdy686E/edit
- 上記フォームの回答スプレッドシート: https://docs.google.com/spreadsheets/d/1Xezq36_rQNOXxralFgeWdJTL7bpA_wLtFqSFCgBt3kc/edit
- マンダラチャート（瑛斗）個別スプレッドシート: https://docs.google.com/spreadsheets/d/1qw0mMZWeFKfbk0un40AsP8FLau6W81Dk7Sc19VKkaqg/edit
- マンダラチャート（颯斗）個別スプレッドシート: https://docs.google.com/spreadsheets/d/1KW7uy7PPisa-yiixmDKIQ2eQop3Tz0zFErKEM87asD0/edit
- 大会振り返り（Googleフォーム、チャッピーと相談して新規設計）: https://docs.google.com/forms/d/1jIWlx-w9tAXe6cdfpayB6DPT8sMx9bx-agrML-0c0XM/edit
- 上記フォームの回答用URL（公開リンク）: https://docs.google.com/forms/d/e/1FAIpQLSfaPnJcaxOli7M3hlmYKpFDDJ444fdwfHmL7okReWJEiHHQ-A/viewform
- 大会振り返りの回答スプレッドシート: https://docs.google.com/spreadsheets/d/1TjKIxJ6rMGokRVKnNcxGC6zAzpFbIxpSVhffqDplyKQ/edit
- 短期目標（月次）（Googleフォーム）: https://docs.google.com/forms/d/1wsWHNnfkVXUeNKgzvugsdx66mZWSVlCCBDKKBwnwIlU/edit
- 上記フォームの回答用URL（公開リンク）: https://docs.google.com/forms/d/e/1FAIpQLSdHaaKZbi-bEHQMSBuZaELo5_ckUF2DQLtBCiu7bReWAUhXcg/viewform
- 短期目標（月次）の回答スプレッドシート: https://docs.google.com/spreadsheets/d/1lk4IpGZ4Ve_MYyDvBX8n7qi0TQKeg33wZ7RmYdNZMNg/edit
- 大会前の目標（Googleフォーム）: https://docs.google.com/forms/d/1t_RcOqa3qJNyeU9sKY0kCYv0gV9n1huUVvGd-urE77c/edit
- 上記フォームの回答用URL（公開リンク）: https://docs.google.com/forms/d/e/1FAIpQLSfuBZ_W7-YT-dB6FhsZIasEMFpWh9Kq9obIGLxolwSf0hOalg/viewform
- 大会前の目標の回答スプレッドシート: https://docs.google.com/spreadsheets/d/15sq-EO41KCYYpkfYorOtKqcUL84JPowTNYD0oeAUxcw/edit
- Notionプロジェクトページ: https://app.notion.com/p/3a7710fca1f481ea8e37d93bdb67030c
- Notionアプリ・アカウント管理ページ: https://app.notion.com/p/3a7710fca1f4814f998ae85966c34595

## 参照すべき引き継ぎメモ
- handoff_瑛斗颯斗選手カルテ_20260726_2.md（最新。「競技について」カード追加・開閉UI修正、
  および本チャット＝選手カルテ更新専用チャットとしての役割確定までの経緯を記載）
- handoff_瑛斗颯斗選手カルテ_20260725_3.md（コーチ/本人ビュー分岐・URLリネーム(/akito/・/hayato/)
  までの経緯）
- handoff_瑛斗颯斗選手カルテ_20260725_2.md（MIC選手カルテ風デザインへの全面リニューアルまでの経緯）
- handoff_瑛斗颯斗選手カルテ_20260725.md（目標設定シート／マンダラチャートのMICコピー実装・
  Apps Script再デプロイまでの経緯を記載）
- handoff_瑛斗颯斗選手カルテ_20260724.md（実デプロイ・GitHub Pages公開完了までの経緯）

## 本チャットの役割
- 本チャット（brief_4_選手カルテ更新チャット.md）は、選手カルテ（trampo-karte）の見た目・
  使いやすさの改善、新しいデータの選手カルテ画面への反映方法の設計・実装、UI/UX向上など
  システム面を専任で扱う（2026-07-26確定）。技術・フィジカル・メンタルのコーチング内容の
  相談は、専用の専門チャット（brief_1〜3）または総合コーチングチャットで行う。

## 注意点
- アップロード用に発行した一時GitHub Personal Access Token（trampo-karte-upload-temp）が
  2026-07-31まで有効。不要になったらVanさん自身での失効を推奨。
- コーチ/本人ビュー分岐実装のpush用に、2026-07-25にもう1つ一時的なfine-grained PAT
  （trampo-karte-upload-temp-2、リポジトリtrampo-karte限定・Contents読み書き権限のみ）を
  発行済み。使い終わったため、Vanさん自身での失効を推奨。
- シーズン目標・マンダラチャートの中身（実際の目標文言・9x9マス）はまだ空欄。Vanさんが
  フォームに回答／マンダラスプレッドシートに直接入力する想定。
