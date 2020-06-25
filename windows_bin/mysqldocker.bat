
@echo off

REM Check if the "mysql" container is running
FOR /F %%i IN ('docker ps --filter "name=mysql" ^| find /c /v ""') DO set containerrunning=%%i

REM Count of 2 means that the output showed table titles + container.
REM Else, it means output is only 1 line, because the filter is on a specific name and there cannot be 2 containers with the same name.
if %containerrunning% == 2 (
	echo MySQL is already running:
	docker ps --filter "name=mysql"
	
	echo You can stop it by executing "docker stop mysql"
	
	exit /B 0
)

REM Doing the same kind of check but with "-a", to check if the container exists.
FOR /F %%i IN ('docker ps -a --filter "name=mysql" ^| find /c /v ""') DO set containerexists=%%i

if %containerexists% == 1 (
	echo Container does not exist yet, creating it...
	docker create ^
		--name=mysql ^
		--env MYSQL_ROOT_PASSWORD=root ^
		--publish 3316:3306 ^
		--volume=%HOME%\mysql_data\:/var/lib/mysql ^
		mysql:5.7
) else (
	echo Container exists.
)

echo Starting MySQL...
docker start mysql

sleep 0.5

FOR /F %%i IN ('docker ps --filter "name=mysql" ^| find /c /v ""') DO set containerrunning=%%i

if %containerrunning% == 1 (
	echo /!\ Seems like the container did not start.
	echo Last logs:
	
	docker logs mysql --since=2s
)
