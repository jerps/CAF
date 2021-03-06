 
/*
                 --  BUILD CAF v1.00.0  --
 
 
          This Source Was Automatically Generated
 
 
          To start the build run:
          STRREXPRC SRCMBR(CAFBUILD) SRCFILE(CAF1000/TOOLSRC)
*/
 
trace off
signal off error
say ' '
say ' '
say ' '
say '<<<<<  BUILDING CAF v1.00.0  >>>>>'
say ' '
say ' '
call ex 'ADDLIBLE LIB(CAF1000)', 'q'
say ' '
say 'BUILDING TOOLS 0 . . .'
call ex 'CRTBNDCL PGM(CAF1000/CAFBUILDCO) SRCFILE(CAF1000/TOOLSRC)'
say ' '
say 'BUILDING TOOLS 1 . . .'
call ex 'CALL CAF1000/CAFBUILDCO CAF1000'
say ' '
say 'BUILDING TOOLS 2 . . .'
call ex 'DLTPGM PGM(CAF1000/CAFBUILDCO)'
call ex 'CO SRCMBR(CAFBUILDCO) SRCFILE(CAF1000/TOOLSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFBUILDT)  SRCFILE(CAF1000/TOOLSRC)    TGTLIB(CAF1000)'
call bsp 'CSYSBASE'
call bsp 'CSYSSQLS'
call bsp 'CAPPBASE'
call bsp 'CAPPSSAM'
call bsp 'CAPPDISP'
say ' '
say 'BUILDING TOOLS 3 . . .'
call ex 'CALL CAF1000/CAFBUILDT CAF1000'
say ' '
say 'COMPILING APP COMMANDS . . .'
call ex 'CO SRCMBR(CAFMENU)    SRCFILE(CAF1000/QCMDSRC)    TGTLIB(CAF1000)      PARM1(CAFMENU0)'
call ex 'CO SRCMBR(CAFMENUG)   SRCFILE(CAF1000/QCMDSRC)    TGTLIB(CAF1000)      PARM1(CAFMENUG0)'
call ex 'CO SRCMBR(CAFNWD)     SRCFILE(CAF1000/QCMDSRC)    TGTLIB(CAF1000)      PARM1(CAFNWD0)'
call ex 'CO SRCMBR(CAFNWDT)    SRCFILE(CAF1000/QCMDSRC)    TGTLIB(CAF1000)      PARM1(CAFNWDT0)'
call ex 'CO SRCMBR(CAFSQLS)    SRCFILE(CAF1000/QCMDSRC)    TGTLIB(CAF1000)      PARM1(CAFSQLS0)'
say ' '
say 'COMPILING APP DISPLAYFILES . . .'
call ex 'CO SRCMBR(CAFMENU)    SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFMENUG)   SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFMENUGD)  SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFNWD)     SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFNWDT)    SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFSQLS)    SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFSQLSD)   SRCFILE(CAF1000/QDDSSRC)    TGTLIB(CAF1000)'
say ' '
say 'COMPILING APP PROGRAMS . . .'
call ex 'CO SRCMBR(CAFMENU)    SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFMENUG)   SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFMENUGD)  SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFNWD)     SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFNWDT)    SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFSQLS)    SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFSQLSD)   SRCFILE(CAF1000/QRPGLESRC)  TGTLIB(CAF1000)'
say ' '
say 'COMPILING APP COMMAND PROCESSORS . . .'
call ex 'CO SRCMBR(CAFMENU0)   SRCFILE(CAF1000/QCLLESRC)   TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFMENUG0)  SRCFILE(CAF1000/QCLLESRC)   TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFNWD0)    SRCFILE(CAF1000/QCLLESRC)   TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFNWDT0)   SRCFILE(CAF1000/QCLLESRC)   TGTLIB(CAF1000)'
call ex 'CO SRCMBR(CAFSQLS0)   SRCFILE(CAF1000/QCLLESRC)   TGTLIB(CAF1000)'
say ' '
call ex 'RMVLIBLE LIB(CAF1000)', 'q'
say ' '
say 'READY.'
say ' '
exit 0
bsp:
parse arg sp
say ' '
say 'BUILDING 'sp' . . .'
call ex 'CO SRCMBR('||sp||'B0) SRCFILE(CAF1000/'||sp||'S)  TGTLIB(CAF1000)'
call ex 'CALL PGM(CAF1000/'||sp||'B0) PARM(CAF1000)'
return
ex:
parse arg c,q
say c
if q \= 'q' then
  signal on error
c
signal off error
return
error:
say ' '
say 'ERROR 'rc' : SEE JOBLOG'
exit 99
