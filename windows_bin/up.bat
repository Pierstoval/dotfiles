@echo off

REM Set the bash prompt color
set GITBRANCH=
for /f %%I in ('git.exe rev-parse --abbrev-ref HEAD 2^> NUL') do set GITBRANCH=%%I

REM Bash prompt look & colors

set PS1=$E[0;36m[$T$H$H$H]$E[0m$s$E[0;32m$E[0m$E[0;33m$P$E[0m$E[0;32m$s

if not "%GITBRANCH%" == "" (
    set PS1=%PS1%$E[0;36m$C%GITBRANCH%$F$E[0m$s
)

REM Dollar (or sharp) will change color depending on last exit code
if errorlevel 0 (
    set PS1=%PS1%$E[0;32m
) else (
    set PS1=%PS1%$E[0;31m
)

set PS1=%PS1%$$$E[0m 

prompt %PS1%
