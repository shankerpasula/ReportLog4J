@echo off
TITLE Content Management Import Tool
SETLOCAL


REM *** Call setMigrationConfig.bat to set shared configuration
@call "%~dp0..\setMigrationConfig.bat"
set LOG_DIR="%~dp0logs"
mkdir %LOG_DIR%

REM Set the absolute path to the index file.
set INDEX_FILE="D:/workspaces/CMT/ContentManagement/cmt-tool/AttachmentIndex.txt"

%JAVA_HOME%\bin\java -cp "%MYCP%;%CLASSPATH%" %VMARGS% com.paisley.rnj.content.tool.ContentManagementImportTool -driver %DATABASE_DRIVER% -url %DATABASE_URL% -user %DATABASE_USERNAME% -password %DATABASE_PASSWORD% -clientID %CLIENT_ID% -logs %LOG_DIR% %LOG_LEVEL% -threads %NUM_THREADS_FOR_ATTACHMENTS% -indexFile %INDEX_FILE% -maxattachsize 200

:end
PAUSE