Windwos2012R2で動作確認済み

# 事前準備
C:\temp配下へ事前に資材を置くこと

# 構造
ExecPowershell.batがGoKBPatch.psを呼び出し、KBファイルのフルパスを取得しKB_install.batに渡す
渡された引数のファイルの存在確認を実施した上で、msiファイルのサイレントインストールを実施する。

