@echo off

if "%2" == "" goto x64
if "%2" == "x64" goto x64
if "%2" == "x86" goto x86

:x64
echo Setting x64
call "%VS120COMNTOOLS%\..\..\VC\vcvarsall.bat" x86_amd64
"C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd" /x64
goto parsebuild

:x86
echo Setting x86
call "%VS120COMNTOOLS%\..\..\VC\vcvarsall.bat"
goto parsebuild

:parsebuild
if "%1" == "" goto all

if /i %1 == all       goto all
if /i %1 == clean     goto all
if /i %1 == compile   goto compile

:all
nmake -f makefile.win clean 
if /i %1 == clean     goto :eof

:compile
nmake -f makefile.win
goto :eof

:missing
echo The specified configuration type is missing.  The tools for the
echo configuration might not be installed.
goto :eof
