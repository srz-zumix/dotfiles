@echo on
rem �Ǘ��Ҍ��������邩�ǂ����`�F�b�N
whoami /PRIV | find "SeLoadDriverPrivilege" >NUL
if not errorlevel 1 goto start

rem �Ȃ��ꍇ�� powershell �o�R�Ŏ������g�����s
rem %0 �̃h���C�u���^�[�Ō������� UNC �p�X���擾
for /f "usebackq tokens=1,2,3" %%i in (`net use`) do if "%%j" == "%~d0" SET UNC=%%k
rem net use �Ŋ��������Ă�����s�i���Ɋ��������Ă���ꍇ������̂Ő��ۂɂ�����炸�R�}���h���s�j
powershell.exe -Command Start-Process -FilePath cmd.exe -ArgumentList '/c "net use %~d0 %UNC% || %~dp0%~nx0"' -Wait -Verb Runas
goto :EOF

:start
cd /d %~dp0
rem ��������o�b�`�{���̏���
for %%f in (ps1/*.ps1) do (
  powershell -ExecutionPolicy RemoteSigned -File ps1/%%f
)
pause
