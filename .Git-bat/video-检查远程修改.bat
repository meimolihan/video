@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM ����Ŀ��Ŀ¼
SET "REPO_PATH=%USERPROFILE%\Desktop\GitHub\video"

REM ���Ŀ��Ŀ¼�Ƿ����
IF NOT EXIST "%REPO_PATH%" (
    echo ===========================================
    echo ����Ŀ¼ %REPO_PATH% �����ڣ�����·����
    echo ===========================================
    pause
    EXIT /B 1
)

REM �л���Ŀ��Ŀ¼
CD /D "%REPO_PATH%"

REM ����Ƿ�Ϊ��Ч�� Git �ֿ�
IF NOT EXIST .git (
    echo ===========================================
    echo ����Ŀ¼ %REPO_PATH% ����һ����Ч�� Git �ֿ⡣
    echo ===========================================
    pause
    EXIT /B 1
)

REM ȷ����ǰ��֧�� main ��֧
git rev-parse --abbrev-ref HEAD >nul 2>&1
IF ERRORLEVEL 1 (
    echo ===========================================
    echo �����޷���⵱ǰ��֧����ȷ������һ����Ч�� Git �ֿ⡣
    echo ===========================================
    pause
    EXIT /B 1
)

SET CURRENT_BRANCH=main
git checkout %CURRENT_BRANCH% >nul 2>&1
IF ERRORLEVEL 1 (
    echo ===========================================
    echo �����޷��л�����֧ %CURRENT_BRANCH%�������֧���ơ�
    echo ===========================================
    pause
    EXIT /B 1
)

REM ���Զ�ֿ̲��Ƿ��и���
echo ===========================================
echo ���ڼ��Զ�ֿ̲��Ƿ��и���...
git fetch origin %CURRENT_BRANCH%

IF NOT "!ERRORLEVEL!"=="0" (
    echo �����޷���Զ�ֿ̲��ȡ���£������������ӻ�Զ�����á�
    pause
    EXIT /B 1
)

REM �Ƚϱ��ط�֧��Զ�̷�֧
SET REMOTE_BRANCH=origin/%CURRENT_BRANCH%
git rev-list --left-right --count %REMOTE_BRANCH%...%CURRENT_BRANCH% >nul 2>&1
FOR /F "tokens=1,2 delims=	" %%A IN ('git rev-list --left-right --count %REMOTE_BRANCH%...%CURRENT_BRANCH%') DO (
    SET BEHIND_COUNT=%%A
    SET AHEAD_COUNT=%%B
)

echo ===========================================
echo ���ط�֧��Զ�̷�֧�Ĳ��죺
echo ��ǰ��֧���Զ�̷�֧ !BEHIND_COUNT! ���ύ��
echo ��ǰ��֧����Զ�̷�֧ !AHEAD_COUNT! ���ύ��
echo ===========================================

REM ����и��£�����ȡ����
IF !BEHIND_COUNT! GTR 0 (
    echo ���ڴ�Զ�ֿ̲���ȡ����...
    git pull origin %CURRENT_BRANCH%
    IF "!ERRORLEVEL!"=="0" (
        echo ���³ɹ���
    ) ELSE (
        echo ������ȡ����ʧ�ܣ����ֶ���顣
    )
) ELSE (
    echo ���ط�֧�Ѿ�������״̬��������¡�
)

echo ===========================================
echo �ű�ִ����ɡ�
pause
ENDLOCAL