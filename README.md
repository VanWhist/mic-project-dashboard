# プロジェクト横断ダッシュボード（スマホ対応版）

D:\Claude 配下の各プロジェクトフォルダにある「タスク.md」を GitHub Pages で公開し、
スマホからもタスク状況を確認できるようにするためのフォルダです。

## フォルダの中身

- `index.html` … ダッシュボード本体（GitHub Pages で公開されるページ）
- `manifest.json` … どのプロジェクトを表示するかのリスト（sync.bat が自動更新）
- `projects/` … 各プロジェクトの タスク.md / CLAUDE.md のコピー（sync.bat が自動更新）
- `sync.ps1` / `sync.bat` … D:\Claude の最新内容をこのフォルダにコピーし、GitHubに反映するスクリプト

**このフォルダの中身は直接編集しないでください。** 元データは D:\Claude 側の各プロジェクトフォルダの
タスク.md です。ここでは sync.bat が自動生成したコピーだけを置いています。

## 初回セットアップ（最初の1回だけ）

1. GitHub で新しいリポジトリを作成する
   - https://github.com/new を開く
   - Repository name: 好きな名前（例: `mic-project-dashboard`）
   - Public を選択（Privateだと無料のGitHub Pagesが使えません）
   - 「Create repository」をクリック

2. このフォルダ（`D:\Claude\プロジェクト横断ダッシュボード\repo`）を、作成したリポジトリに接続する

   **GitHub Desktop を使う場合（MICサイトと同じ操作感でおすすめ）**
   - GitHub Desktop → File → Add local repository → このフォルダを選択
   - 「create a repository」を促されたら作成
   - Publish repository ボタンでリモートに公開（Publicのまま）

   **コマンドで行う場合**
   ```
   cd "D:\Claude\プロジェクト横断ダッシュボード\repo"
   git init
   git add -A
   git commit -m "初回コミット"
   git branch -M main
   git remote add origin https://github.com/【あなたのユーザー名】/【リポジトリ名】.git
   git push -u origin main
   ```

3. GitHub Pages を有効化する
   - GitHub上のリポジトリページ → Settings → Pages
   - Source: 「Deploy from a branch」
   - Branch: `main` / `/ (root)` を選択して Save
   - 数分待つと、`https://【あなたのユーザー名】.github.io/【リポジトリ名】/` でアクセスできるようになります
   - このURLをスマホのホーム画面に追加しておくと、アプリのように開けて便利です

## 日常の使い方（タスクを更新したとき）

1. D:\Claude の各プロジェクトの タスク.md を通常通り更新する
2. `sync.bat` をダブルクリックする
   - D:\Claude 配下を自動スキャンし、タスク.md があるプロジェクトをこのフォルダにコピー
   - git のコミット・プッシュまで自動で行う（初回セットアップ済みの場合）
3. 1〜2分待ってから、スマホでダッシュボードのURLを開く（または再読み込み）

## PC単体で確認したいだけの場合

`D:\Claude\プロジェクト横断ダッシュボード\dashboard.html` を直接Chrome/Edgeで開くと、
GitHubを経由せずにその場でD:\Claudeのタスク.mdを読み込んで表示できます（PC専用・スマホ不可）。
こちらはリアルタイム性重視、`repo` フォルダ（このフォルダ）はスマホ閲覧用です。
