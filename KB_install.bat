@echo off
title Windows Server パッチ適用

SET TEMPDATE=%date:?-10,4%%date:?-5,2%%date:?-2,2%
SET LOGPATH=C:＼temp＼%TEMPDATE%
SET LOGFILE=%LOGPATH%＼パッチ適用.log

if not exist %LOGFILE% (
	md %LOGPATH%
)

if exist %1 (
    echo %date% %time% %1のパッチ適用開始 >>%LOGFILE%

    wusa %1 /quiet /norestart 

    echo %date% %time% %1のパッチ適用終了 >>%LOGFILE%

)