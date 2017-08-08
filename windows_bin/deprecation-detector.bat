@echo OFF
setlocal DISABLEDELAYEDEXPANSION
php "%~dp0deprecation-detector" %*
