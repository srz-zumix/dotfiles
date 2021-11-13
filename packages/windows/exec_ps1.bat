@echo on
rem 管理者権限があるかどうかチェック
whoami /PRIV | find "SeLoadDriverPrivilege" >NUL
if not errorlevel 1 goto start

rem ない場合は powershell 経由で自分自身を実行
rem %0 のドライブレターで検索して UNC パスを取得
for /f "usebackq tokens=1,2,3" %%i in (`net use`) do if "%%j" == "%~d0" SET UNC=%%k
rem net use で割当をしてから実行（既に割当たっている場合もあるので成否にかかわらずコマンド実行）
powershell.exe -Command Start-Process -FilePath cmd.exe -ArgumentList '/c "net use %~d0 %UNC% || %~dp0%~nx0"' -Wait -Verb Runas
goto :EOF

:start
cd /d %~dp0
rem ここからバッチ本来の処理
for %%f in (ps1/*.ps1) do (
  powershell -ExecutionPolicy RemoteSigned -File ps1/%%f
)
pause
