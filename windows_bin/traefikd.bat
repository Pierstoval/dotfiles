
@echo off
setlocal enableextensions 

REM Check if the "traefik" container is running
FOR /F %%i IN ('docker ps --filter "name=traefik" ^| find /c /v ""') DO set containerrunning=%%i

REM Count of 2 means that the output showed table titles + container.
REM Else, it means output is only 1 line, because the filter is on a specific name and there cannot be 2 containers with the same name.
if %containerrunning% == 2 (
	echo Traefik is already running:
	docker ps --filter "name=traefik"
	
	exit /B 0
)

echo Checking network...

REM Using same method to check if the "proxy" network exists.
FOR /F %%i IN ('docker network ls --filter "name=proxy" ^| find /c /v ""') DO set networkexists=%%i
if %networkexists% == 1 (
	echo Creating proxy network...
	docker network create proxy
)

REM Doing the same kind of check but with "-a", to check if the container exists.
FOR /F %%i IN ('docker ps -a --filter "name=traefik" ^| find /c /v ""') DO set containerexists=%%i

if %containerexists% == 1 (
	echo Container does not exist yet, creating it...
	docker create ^
		-p 8080:8080 ^
		-p 80:80 ^
		-p 443:443 ^
		--name=traefik ^
		--env TRAEFIK_API=true ^
		--env TRAEFIK_API_DASHBOARD=true ^
		--volume %HOME%/.traefik/traefik.yml:/etc/traefik/traefik.yml ^
		--network proxy ^
		traefik:v2.2 ^
		traefik ^
		--api=true ^
		--api.dashboard=true ^
		--api.insecure=true
) else (
	echo Container exists.
)

echo Starting Traefik...
docker start traefik

sleep 0.5

FOR /F %%i IN ('docker ps --filter "name=traefik" ^| find /c /v ""') DO set containerrunning=%%i

if %containerrunning% == 1 (
	echo /!\ Seems like the container did not start.
	echo Last logs:
	
	docker logs traefik --since=2s
)