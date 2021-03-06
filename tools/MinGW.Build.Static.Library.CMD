@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET VU_NAME=Vutils
SET VU_DIR=..
SET VU_INCLUDE=%VU_DIR%\include
SET VU_SRC=%VU_DIR%\src
SET VU_LIB=%VU_DIR%\lib

ECHO *** %VU_NAME% static library for MinGW ***

ECHO.

IF NOT EXIST %VU_LIB% MKDIR %VU_LIB%

SET LIBs=

:: for SOCKET

SET /p response=[+] Enable SOCKET (Y/[N]) ? 
SET "conditions=0"
IF [%response%]==[Y] SET conditions=1
IF [%response%]==[y] SET conditions=1

IF [%conditions%]==[1] (
	ECHO     Socket -^> ENABLED
	SET LIBs=%LIBs%-DVU_SOCKET_ENABLED -lws2_32
) else (
	ECHO     Socket -^> DISABLED
)

ECHO.

:: for GUID

SET /p response=[+] Enable GUID (Y/[N]) ? 
SET "conditions=0"
IF [%response%]==[Y] SET conditions=1
IF [%response%]==[y] SET conditions=1

IF [%conditions%]==[1] (
	ECHO     GUID -^> ENABLED
	SET LIBs=%LIBs% -DVU_GUID_ENABLED -lrpcrt4
) else (
	ECHO     GUID -^> DISABLED
)

ECHO.

:: Execute

ECHO [+] Compiling	-^> OK

G++ -c -std=c++0x %LIBS% -I%VU_INCLUDE% %VU_SRC%\%VU_NAME%.cpp -o %VU_NAME%.o

ECHO [+] Linking	-^> OK

AR rcs %VU_LIB%\lib%VU_NAME%.a %VU_NAME%.o

ECHO [+] Cleaning	-^> OK

DEL %VU_NAME%.o

ECHO [+] Building	-^> OK

ECHO.

PAUSE