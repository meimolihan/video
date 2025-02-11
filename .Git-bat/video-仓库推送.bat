@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM ������ɫΪ��ɫ������Ĭ������ɫ����
COLOR 0A
CLS
PROMPT $P$G

REM ����Ŀ��Ŀ¼
SET "REPO_PATH=%USERPROFILE%\Desktop\GitHub\video"

REM ���Ŀ��Ŀ¼�Ƿ����
IF NOT EXIST "%REPO_PATH%" (
    ECHO ============================================
    ECHO ����Ŀ¼ %REPO_PATH% �����ڣ�����·����
    ECHO ============================================
    pause
    EXIT /B 1
)

REM �л���Ŀ��Ŀ¼
CD /D "%REPO_PATH%" 2>NUL
IF ERRORLEVEL 1 (
    ECHO ============================================
    ECHO �����޷��л���Ŀ¼ %REPO_PATH%������ Git �ֿ⡣
    ECHO ============================================
    pause
    EXIT /B 1
)

REM ����Ƿ�Ϊ��Ч�� Git �ֿ�
IF NOT EXIST .git (
    ECHO ============================================
    ECHO ����Ŀ¼ %REPO_PATH% ����һ����Ч�� Git �ֿ⡣
    ECHO ============================================
    pause
    EXIT /B 1
)

REM ����Ƿ����޸���Ҫ�ύ
ECHO ============================================
ECHO ���ڼ���Ƿ����ļ���Ҫ�ύ...
ECHO ============================================
ECHO.

git status >nul 2>&1
IF ERRORLEVEL 1 (
    ECHO �����޷���ȡ Git �ֿ�״̬�����黷����
    pause
    EXIT /B 1
)

FOR /F "delims=" %%D IN ('git status --porcelain') DO (
    IF "%%D" NEQ "" (
        SET "CHANGES=YES"
    )
)

IF DEFINED CHANGES (
    ECHO ��⵽�ļ��޸ģ���ʼ�ύ...

    REM ������и���
    ECHO.
    ECHO ����������и���...
    git add .
    IF ERRORLEVEL 1 (
        ECHO �����޷�����ļ������� Git �ֿ⡣
        pause
        EXIT /B 1
    )

    REM �ύ����
    ECHO.
    ECHO �����ύ����...
    git commit -m "update"
    IF ERRORLEVEL 1 (
        ECHO �����ύʧ�ܣ����� Git �ֿ⡣
        pause
        EXIT /B 1
    )

    REM ���͸���
    ECHO.
    ECHO �������͸��ĵ�Զ�ֿ̲�...
    git push
    IF ERRORLEVEL 1 (
        ECHO ��������ʧ�ܣ������������ӻ�Զ�����á�
        pause
        EXIT /B 1
    )

    ECHO.
    ECHO �ύ�����ͳɹ���
) ELSE (
    ECHO û���ļ���Ҫ�ύ��
)

REM ��ʾ���
ECHO.
ECHO ============================================
ECHO �ű�ִ����ɡ�
ECHO ============================================
pause
ENDLOCAL