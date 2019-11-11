# PowerShell_tools
PowerShellとBatを駆使ししてサイレントインストールするツール
Windowsであれば、どこでも使えます。

■powershell.bat
パワーシェルを実行する
powershell -ExecutionPolicy RemoteSigned -File C:\temp\test.ps1
pause

■test.ps1
Write-Host "PowerShell実行開始"

get-hotfix -ComputerName CONTOSOMEMSVR | ft HotFixID,InstalledOn -AutoSize > CONTOSOMEMSVR-beforeKB.txt

cd C:\temp
<# in.txtをインプットにファイルを検索#>
$i=1

foreach ($l in Get-Content in.txt) {
    Write-Host $i : $l

    $regFile = "^" +  $l + "$"
    $full_Path_File = Get-ChildItem -Recurse "C:\temp\hwtest"  -Filter $l | ? { ! $_.PSIsContainer } | % { $_.FullName }
#    $fulpathfile = Get-ChildItem -Recurse "C:\temp\hwtest" | ? { ! $_.PSIsContainer } | % { $_.FullName } | Select-String $l -SimpleMatch
    Write-Output $full_Path_File | Add-Content out.txt -Encoding Default

    Write-Host "bat実行開始"
    Start-Process KB_install.bat -ArgumentList $full_Path_File -Wait
    Write-Host "bat実行終了"

    $i++
}

get-hotfix -ComputerName CONTOSOMEMSVR | ft HotFixID,InstalledOn -AutoSize > CONTOSOMEMSVR-afterKB.txt


Write-Host "PowerShell実行終了"


■KB_install.bat
@echo off
title Windows Server 2012 R2パッチ適用


set TEMPDATE=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set TEMPTIME2=%time: =0%
set TEMPTIME=%TEMPTIME2:~0,2%%time:~3,2%%time:~6,2%
echo %TEMPDATE%-%TEMPTIME%

SET LOGPATH=C:\temp\HW\%TEMPDATE%-%TEMPTIME%
SET LOGFILE=%LOGPATH%\パッチ適用.log
MD %LOGPATH%

echo %date% %time% Windows Server 2012 R2パッチ適用開始 >>%LOGFILE%
echo %date% %time% ログは%LOGPATH%に保存されます

cd C:\temp

if exist %1 (
  
    echo %date% %time% %1のパッチ適用開始 >>%LOGFILE%

    wusa %1 /quiet /norestart /log:%LOGPATH%\%TEMPTIME%.log

    echo %date% %time% %1のパッチ適用終了 >>%LOGFILE%

)
