# sync.ps1 - プロジェクト横断ダッシュボード 同期スクリプト
#
# D:\Claude 配下の各プロジェクトフォルダから「タスク.md」「CLAUDE.md」を
# このリポジトリの projects\ 配下にコピーし、manifest.json を更新します。
# このフォルダが git リポジトリとして設定されていれば、そのまま
# git add / commit / push まで自動で行います（GitHub Pages に反映されます）。
#
# 使い方: このファイルではなく、同じフォルダの「sync.bat」をダブルクリックしてください。

$ErrorActionPreference = "Stop"

$sourceRoot = "D:\Claude"
$repoRoot = $PSScriptRoot
$projectsDir = Join-Path $repoRoot "projects"

if (-not (Test-Path $sourceRoot)) {
    Write-Host "エラー: $sourceRoot が見つかりません。"
    Read-Host "Enterキーで終了"
    exit 1
}

if (-not (Test-Path $projectsDir)) {
    New-Item -ItemType Directory -Path $projectsDir | Out-Null
}

$foundProjects = @()

Get-ChildItem -Path $sourceRoot -Directory | ForEach-Object {
    $folderName = $_.Name
    $taskFile = Join-Path $_.FullName "タスク.md"
    if (Test-Path $taskFile) {
        $destDir = Join-Path $projectsDir $folderName
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir | Out-Null
        }
        Copy-Item -Path $taskFile -Destination (Join-Path $destDir "タスク.md") -Force

        $claudeFile = Join-Path $_.FullName "CLAUDE.md"
        if (Test-Path $claudeFile) {
            Copy-Item -Path $claudeFile -Destination (Join-Path $destDir "CLAUDE.md") -Force
        }

        $foundProjects += $folderName
        Write-Host "同期: $folderName"
    }
}

# D:\Claude 側から無くなったプロジェクトフォルダは projects\ 側からも削除
Get-ChildItem -Path $projectsDir -Directory | ForEach-Object {
    if ($foundProjects -notcontains $_.Name) {
        Remove-Item -Path $_.FullName -Recurse -Force
        Write-Host "削除: $($_.Name)（元フォルダにタスク.mdが見つからないため）"
    }
}

$manifestObj = [ordered]@{
    projects  = $foundProjects
    updatedAt = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
}
$manifestJson = $manifestObj | ConvertTo-Json
Set-Content -Path (Join-Path $repoRoot "manifest.json") -Value $manifestJson -Encoding UTF8

Write-Host ""
Write-Host "$($foundProjects.Count) 件のプロジェクトを同期しました。"

Push-Location $repoRoot
try {
    if (Test-Path ".git") {
        git add -A
        $status = git status --porcelain
        if ($status) {
            git commit -m "タスク状況を更新 ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))" | Out-Null
            git push
            Write-Host "GitHub にプッシュしました。数分でサイトに反映されます。"
        } else {
            Write-Host "前回から変更はありませんでした。"
        }
    } else {
        Write-Host ""
        Write-Host "※このフォルダはまだ git リポジトリとして設定されていません。"
        Write-Host "  README.md の手順に従って、最初に1度だけ GitHub への接続設定を行ってください。"
    }
} finally {
    Pop-Location
}

Write-Host ""
Read-Host "完了しました。Enterキーでウィンドウを閉じます"
