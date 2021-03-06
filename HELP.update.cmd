@ECHO OFF

if "%~1"=="?" goto HELP
if "%~1"=="/?" goto HELP

:: Set working folder to batch root folder
pushd "%~dp0"

:: Version number for this batch file
SET MyVer=1.00

:: Display "about"
ECHO.
ECHO Help.update.cmd,  Version %MyVer% 
ECHO Generates a HTML help file for "all" available commands
ECHO Generates a Readme.md help file for "all" available commands


:: Store current code page and then set code page for European languages
FOR /F "tokens=*" %%A IN ('CHCP') DO FOR %%B IN (%%A) DO SET CHCP=%%B
CHCP 1252 >NUL 2>&1

:: Start writing HTML file
ECHO Writing HTML header . . .
> help.htm ECHO ^<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"^>
>>help.htm ECHO ^<HTML^>
>>help.htm ECHO ^<HEAD^>

>>help.htm ECHO ^<TITLE^>Help - 1508 DEPLOYMENT UTILITY SCRIPTS^</TITLE^>
>>help.htm ECHO ^</HEAD^>
>>help.htm ECHO.
>>help.htm ECHO ^<BODY^>
>>help.htm ECHO.
>>help.htm ECHO ^<A NAME="Top"^>^</A^>
>>help.htm ECHO.
rem >>help.htm ECHO ^<CENTER^>
>>help.htm ECHO ^<H1^>Help - 1508 Deployment Utility Scripts^</H1^>
rem FOR /F "tokens=* delims=" %%A IN ('VER') DO SET Ver=%%A
rem >>help.htm ECHO ^<H3^>%Ver%^</H3^>
rem >>help.htm ECHO ^</CENTER^>
>>help.htm ECHO.
>>help.htm ECHO ^<P^>^&nbsp;^</P^>
>>help.htm ECHO.

>Readme.md ECHO # 1508 DEPLOYMENT UTILITY SCRIPTS
>>Readme.md ECHO -------
>>Readme.md ECHO.Utilities used in the automated deployment of Developer enviroments.
>>Readme.md ECHO At 1508 we develop Sitecore CMS and Umbraco solutions, all client solutions are hosted on our QA servers and deployed from there to the local dev machines with the help of these utility scripts.
>>Readme.md ECHO 
>>Readme.md ECHO We hope you can find help and inspiration in these utilities.
>>Readme.md ECHO See the sample for inspiration.
>>Readme.md ECHO.
>>Readme.md ECHO 1508 / Design in Love with Technology
>>Readme.md ECHO.
>>Readme.md ECHO ----------
>>Readme.md ECHO.
ECHO Creating command index table . . .

SET FirstCell=1
>>help.htm ECHO ^<TABLE BORDER="0"^>

FOR /F "tokens=* delims=" %%A IN ('dir *.cmd /B') DO CALL :DispLine "%%A"

>>help.htm ECHO ^</TD^>^</TR^>
>>help.htm ECHO ^</TABLE^>
>>help.htm ECHO.
>>help.htm ECHO ^<P^>^&nbsp;^</P^>
>>help.htm ECHO.

ECHO Writing help for each command:
FOR /F "tokens=* delims=" %%A IN ('dir *.cmd /B') DO CALL :DispFull "%%A"

ECHO Closing HTML file
>>help.htm ECHO.
rem >>help.htm ECHO ^<DIV ALIGN="Center"^>
>>help.htm ECHO ^<P^>This file was generated by:
>>help.htm ECHO ^<B^>HELP.update.cmd^</B^>, Version %MyVer%^</P^>
rem >>help.htm ECHO ^</DIV^>
>>help.htm ECHO.
>>help.htm ECHO ^</BODY^>
>>help.htm ECHO ^</HTML^>

>>Readme.md ECHO.
>>Readme.md ECHO ----------
>>Readme.md ECHO.
>>Readme.md ECHO This Readme.md is generated with the HELP.update.cmd Script.
>>Readme.md ECHO We hope you can find help and inspiration in these utilities.
>>Readme.md ECHO.
>>Readme.md ECHO The 1508 Development Team
>>Readme.md ECHO.

ECHO.
ECHO An HTML help file "help.htm" has been created and stored in the current
ECHO directory.
ECHO.
ECHO Now starting display of "help.htm" . . .
START "Help" help.htm

popd

:: End of main batch program
CHCP %CHCP% >NUL 2>&1
ENDLOCAL
GOTO:EOF


:: Subroutines


:DispLine
SET Command=%1
IF DEFINED Command CALL :DispCmdLine %Command%
rem FOR /F "tokens=1* delims= " %%a IN ('ECHO.%*') DO SET Descr=%%b
rem FOR /F "tokens=1* delims= " %%a IN ('call "%~1" "/?"') DO SET Descr=%%b
rem SET Descr=%Descr:"=%
rem >>help.htm ECHO.%Descr%
GOTO:EOF


:DispCmdLine
IF "%FirstCell%"=="0" IF DEFINED Command (>>help.htm ECHO ^</TD^>^</TR^>)
SET Command=%~1
IF DEFINED Command (>>help.htm ECHO ^<TR^>^<TH ALIGN="left" VALIGN="top"^>^<A HREF="#%Command%"^>%Command%^</A^>^</TH^>^<TD^>^&nbsp;^&nbsp;^&nbsp;^</TD^>^<TD^>)
SET FirstCell=0
SET Command=
GOTO:EOF


:DispFull
SET Command=%1
IF DEFINED Command CALL :WriteFull %Command%
SET Command=
GOTO:EOF


:WriteFull
ECHO.  %1 . . .
>>help.htm ECHO.
>>help.htm ECHO ^<A NAME="%~1"^>^</A^>
>>help.htm ECHO.
>>help.htm ECHO ^<H2^>%~1^</H2^>
>>help.htm ECHO.
>>help.htm ECHO ^<PRE^>
call "%~1" "/?" >>help.htm
>>help.htm ECHO ^</PRE^>
>>help.htm ECHO.
>>help.htm ECHO ^<A HREF="#Top"^> Top^</A^>
>>help.htm ECHO.
>>help.htm ECHO ^<P^>^&nbsp;^</P^>
>>help.htm ECHO.

>>Readme.md ECHO.
>>Readme.md ECHO ## %~1
>>Readme.md ECHO.
call "%~1" "/?" >>Readme.md
>>Readme.md ECHO.
>>Readme.md ECHO.

GOTO:EOF


:HELP
echo   Generates help.htm
echo.   
GOTO:EOF

:End
