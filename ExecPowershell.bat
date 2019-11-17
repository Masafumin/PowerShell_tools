Rem 引数（フルパス）のPowershellを実行する
if exist %1 (
	powershell -ExecutionPolicy RemoteSigned -File %1

　pause
)