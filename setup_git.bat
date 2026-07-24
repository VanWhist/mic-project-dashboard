@echo off
chcp 65001 >nul
cd /d "%~dp0"

if exist ".git" goto ALREADY_SETUP

echo このフォルダをGitHubのリポジトリと接続します。

git init
if errorlevel 1 goto ERROR_INIT

git remote add origin https://github.com/VanWhist/mic-project-dashboard.git
if errorlevel 1 goto ERROR_REMOTE

echo GitHub上の最新内容を取得しています...
git fetch origin
if errorlevel 1 goto ERROR_FETCH

git checkout -b main origin/main -f
if errorlevel 1 goto ERROR_CHECKOUT

echo.
echo 完了しました。このフォルダはGitHubリポジトリと接続されました。
echo 今後はsync.batを実行するだけで、自動的にGitHubへ反映されます。
goto END

:ALREADY_SETUP
echo すでにgitリポジトリとして設定されているようです。何もせず終了します。
goto END

:ERROR_INIT
echo エラー: git initに失敗しました。gitがインストールされているか確認してください。
goto END

:ERROR_REMOTE
echo エラー: リモートの追加に失敗しました。
goto END

:ERROR_FETCH
echo エラー: fetchに失敗しました。インターネット接続、またはGitHubへのログイン状態を確認してください。
goto END

:ERROR_CHECKOUT
echo エラー: チェックアウトに失敗しました。
goto END

:END
echo.
pause
