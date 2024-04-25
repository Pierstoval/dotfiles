@echo off

set PROGRAM_NAME=vcxsrv.exe
set PROGRAM_FULLPATH=C:\Users\Pierstoval\scoop\shims\%PROGRAM_NAME%

tasklist.exe /FI "IMAGENAME eq %PROGRAM_NAME%" 2>NUL | C:\Windows\System32\find.exe /I /N "%PROGRAM_NAME%">NUL
IF "%ERRORLEVEL%"=="0" (
	set SERVER_RUNNING=1
) ELSE (
	set SERVER_RUNNING=0
)

IF "%~1"=="" (
	echo Start a new X server with predefined configuration
	echo;
	echo Usage:
	echo;
	echo   start		Start the X server in the background.
	echo   stop		Stop the running X server.
	echo;
	exit

) ELSE IF "%~1"=="start"  (
	IF "%SERVER_RUNNING%"=="1" (
		echo Server is already running
		exit 1
	)

	echo Starting X server...

	START /B "" "%PROGRAM_FULLPATH%" -ac -terminate -lesspointer -multiwindow -clipboard -nowgl -dpi auto -displayfd 644

	echo Done!

) ELSE IF "%~1"=="stop"  (
	IF "%SERVER_RUNNING%"=="0" (
		echo Server is not running
		exit 1
	)

	echo Stopping X server...

	TASKKILL.EXE /F /T /IM %PROGRAM_NAME%

	exit 0

) ELSE IF "%~1"=="restart"  (
	cmd /c %~f0 stop
	cmd /c %~f0 start
	exit 0

) ELSE (
	echo Usage
	echo.
	echo x [start^|stop]
)
