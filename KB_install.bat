@echo off
title Windows Server �p�b�`�K�p

SET TEMPDATE=%date:?-10,4%%date:?-5,2%%date:?-2,2%
SET LOGPATH=C:�_temp�_%TEMPDATE%
SET LOGFILE=%LOGPATH%�_�p�b�`�K�p.log

if not exist %LOGFILE% (
	md %LOGPATH%
)

if exist %1 (
    echo %date% %time% %1�̃p�b�`�K�p�J�n >>%LOGFILE%

    wusa %1 /quiet /norestart 

    echo %date% %time% %1�̃p�b�`�K�p�I�� >>%LOGFILE%

)