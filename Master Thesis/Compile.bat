@ECHO OFF
TITLE Select action
SET de=0
CLS

taskkill /fi "WindowTitle eq Main.pdf - Adobe Reader"
taskkill /fi "WindowTitle eq Main.pdf - SumatraPDF"

IF [%1] == [](GOTO 0)
IF "%1"=="1" (GOTO 1)
IF "%1"=="2" (GOTO 2)
IF "%1"=="3" (GOTO 3)

:0
ECHO 1 - Compile fast
ECHO 2 - Compile with Table of contents
ECHO 3 - Compile with references
ECHO D - Delete files
ECHO Q - Exit

SET /P comp=Your choice [1, 2, 3, D, E, Q]: 



start .\_clean.bat

CLS
IF %comp%==d (
    SET de=1
    GOTO d
)
IF %comp%==e GOTO ea
IF %comp%==q EXIT

SET c=%comp%
SET /A r=1

IF %comp% EQU 1 GOTO 1
IF %comp% EQU 2 GOTO 2
IF %comp% EQU 3 GOTO 3
ECHO Bad choice!
PAUSE
EXIT

:3
TITLE pdflatex: %r%/%c%
pdflatex Main
SET /A r=%r%+1
CLS
TITLE bibtex
bibtex Main
CLS

:2
TITLE pdflatex: %r%/%c%
pdflatex Main
SET /A r=%r%+1
CLS

:1
TITLE pdflatex: %r%/%c%
pdflatex Main
CLS

:errlvl

:d
TITLE Deleting
DEL *.log
DEL *.aux
DEL *.out
DEL *.toc
DEL *.gz
DEL *.gz(busy)
DEL *.bbl
DEL *.blg
DEL *.tdo
DEL *.r*
DEL *.lof
DEL design\syntaks\*.bak
DEL design\syntaks\*.log
DEL *.mine

IF %de% EQU 1 EXIT

REM Check compile error level

TITLE Opening
IF %USERNAME%==Malakahh (
    START "" "C:\Program Files (x86)\Adobe\Reader 11.0\Reader\AcroRd32.exe" "Main.pdf"
    EXIT
)
IF %USERNAME%==Zigs (
    START "" "C:\Program Files (x86)\SumatraPDF\SumatraPDF.exe" "Main.pdf"
    EXIT
)

IF %USERNAME%==Golvin EXIT

IF %USERNAME%==Dennis goto :dennis

:mik
Main.pdf


:ad
"Main.pdf"