@echo off
chcp 65001 >nul

echo 自動実行の設定を登録します。

schtasks /create /tn "ProjectDashboardSync_Logon" /tr "powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File \"D:\Claude\プロジェクト横断ダッシュボード\repo\sync.ps1\" -Silent" /sc onlogon /rl limited /f
if errorlevel 1 goto ERROR_LOGON

schtasks /create /tn "ProjectDashboardSync_Hourly" /tr "powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File \"D:\Claude\プロジェクト横断ダッシュボード\repo\sync.ps1\" -Silent" /sc hourly /mo 1 /rl limited /f
if errorlevel 1 goto ERROR_HOURLY

echo.
echo 完了しました。パソコン起動時と、1時間ごとに自動でsync.batと同じ処理が実行されます。
echo 画面には何も表示されず、静かに実行されます。
goto END

:ERROR_LOGON
echo エラー: ログオン時の自動実行の登録に失敗しました。
goto END

:ERROR_HOURLY
echo エラー: 定期実行の登録に失敗しました。
goto END

:END
echo.
pause
