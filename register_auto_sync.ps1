﻿# register_auto_sync.ps1
#
# sync.ps1 を「パソコン起動時（ログオン時）」と「1時間ごと」に
# 自動実行するよう、Windowsのタスクスケジューラに登録します。
# 実行は1度だけで大丈夫です。
#
# 使い方: このファイルを右クリックして「PowerShellで実行」を選んでください。

$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
$scriptPath = Join-Path $repoRoot "sync.ps1"

$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`" -Silent"

$triggerLogon = New-ScheduledTaskTrigger -AtLogOn

$triggerHourly = New-ScheduledTaskTrigger -Once -At (Get-Date) `
    -RepetitionInterval (New-TimeSpan -Hours 1) `
    -RepetitionDuration (New-TimeSpan -Days 3650)

Write-Host "ログオン時の自動実行を登録しています..."
Register-ScheduledTask -TaskName "ProjectDashboardSync_Logon" -Action $action -Trigger $triggerLogon -RunLevel Limited -Force | Out-Null

Write-Host "1時間ごとの自動実行を登録しています..."
Register-ScheduledTask -TaskName "ProjectDashboardSync_Hourly" -Action $action -Trigger $triggerHourly -RunLevel Limited -Force | Out-Null

Write-Host ""
Write-Host "完了しました。パソコン起動時と、1時間ごとに自動でsync.batと同じ処理が実行されます。"
Write-Host "画面には何も表示されず、静かに実行されます。実行結果は sync_log.txt に記録されます。"
Write-Host ""
Read-Host "Enterキーでウィンドウを閉じます"
