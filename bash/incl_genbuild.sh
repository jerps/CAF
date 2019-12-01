
#  (c) 2019 John Erps
#  This software is licensed under the MIT license (see LICENSE)


#  Include: Generate REXX BUILD Script to build CAF.


if [ -f $BUILDMBR ]; then
  rm $BUILDMBR
fi

echo " "                                                                                                            >  $BUILDMBR
echo "/*"                                                                                                           >> $BUILDMBR
echo "                 --  BUILD CAF $CAFVERT  --"                                                                  >> $BUILDMBR
echo " "                                                                                                            >> $BUILDMBR
echo " "                                                                                                            >> $BUILDMBR
echo "          This Source Was Automatically Generated"                                                            >> $BUILDMBR
echo " "                                                                                                            >> $BUILDMBR
echo " "                                                                                                            >> $BUILDMBR
echo "          To start the build run:"                                                                            >> $BUILDMBR
echo "          STRREXPRC SRCMBR(CAFBUILD) SRCFILE($HLIB/TOOLSRC)"                                                  >> $BUILDMBR
echo "*/"                                                                                                           >> $BUILDMBR
echo " "                                                                                                            >> $BUILDMBR

echo "trace off"                                                                                                    >> $BUILDMBR
echo "signal off error"                                                                                             >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say '<<<<<  BUILDING CAF $CAFVERT  >>>>>'"                                                                    >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say ' '"                                                                                                      >> $BUILDMBR
echo "call ex 'ADDLIBLE LIB($HLIB)', 'q'"                                                                           >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'BUILDING TOOLS 0 . . .'"                                                                                >> $BUILDMBR
echo "call ex 'CRTBNDCL PGM($HLIB/CAFBUILDCO) SRCFILE($HLIB/TOOLSRC)'"                                              >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'BUILDING TOOLS 1 . . .'"                                                                                >> $BUILDMBR
echo "call ex 'CALL $HLIB/CAFBUILDCO $HLIB'"                                                                        >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'BUILDING TOOLS 2 . . .'"                                                                                >> $BUILDMBR
echo "call ex 'DLTPGM PGM($HLIB/CAFBUILDCO)'"                                                                       >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFBUILDCO) SRCFILE($HLIB/TOOLSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFBUILDT)  SRCFILE($HLIB/TOOLSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR

for sl in "${SRC1[@]}"
do
  echo "call bsp '$sl'"                                                                                             >> $BUILDMBR
done

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'BUILDING TOOLS 3 . . .'"                                                                                >> $BUILDMBR
echo "call ex 'CALL $HLIB/CAFBUILDT $HLIB'"                                                                         >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'COMPILING APP COMMANDS . . .'"                                                                           >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENU)    SRCFILE($HLIB/QCMDSRC)    TGTLIB($HLIB)      PARM1(CAFMENU0)'"                 >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENUG)   SRCFILE($HLIB/QCMDSRC)    TGTLIB($HLIB)      PARM1(CAFMENUG0)'"                >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWD)     SRCFILE($HLIB/QCMDSRC)    TGTLIB($HLIB)      PARM1(CAFNWD0)'"                  >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWDT)    SRCFILE($HLIB/QCMDSRC)    TGTLIB($HLIB)      PARM1(CAFNWDT0)'"                 >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFSQLS)    SRCFILE($HLIB/QCMDSRC)    TGTLIB($HLIB)      PARM1(CAFSQLS0)'"                 >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'COMPILING APP DISPLAYFILES . . .'"                                                                       >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENU)    SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENUG)   SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENUGD)  SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWD)     SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWDT)    SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFSQLS)    SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFSQLSD)   SRCFILE($HLIB/QDDSSRC)    TGTLIB($HLIB)'"                                      >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'COMPILING APP PROGRAMS . . .'"                                                                           >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENU)    SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENUG)   SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENUGD)  SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWD)     SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWDT)    SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFSQLS)    SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFSQLSD)   SRCFILE($HLIB/QRPGLESRC)  TGTLIB($HLIB)'"                                      >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'COMPILING APP COMMAND PROCESSORS . . .'"                                                                 >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENU0)   SRCFILE($HLIB/QCLLESRC)   TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFMENUG0)  SRCFILE($HLIB/QCLLESRC)   TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWD0)    SRCFILE($HLIB/QCLLESRC)   TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFNWDT0)   SRCFILE($HLIB/QCLLESRC)   TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CO SRCMBR(CAFSQLS0)   SRCFILE($HLIB/QCLLESRC)   TGTLIB($HLIB)'"                                      >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "call ex 'RMVLIBLE LIB($HLIB)', 'q'"                                                                           >> $BUILDMBR

echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'READY.'"                                                                                                 >> $BUILDMBR
echo "say ' '"                                                                                                      >> $BUILDMBR

echo "exit 0"                                                                                                       >> $BUILDMBR

echo "bsp:"                                                                                                         >> $BUILDMBR
echo "parse arg sp"                                                                                                 >> $BUILDMBR
echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'BUILDING 'sp' . . .'"                                                                                    >> $BUILDMBR
echo "call ex 'CO SRCMBR('||sp||'B0) SRCFILE($HLIB/'||sp||'S)  TGTLIB($HLIB)'"                                      >> $BUILDMBR
echo "call ex 'CALL PGM($HLIB/'||sp||'B0) PARM($HLIB)'"                                                             >> $BUILDMBR
echo "return"                                                                                                       >> $BUILDMBR
echo "ex:"                                                                                                          >> $BUILDMBR
echo "parse arg c,q"                                                                                                >> $BUILDMBR
echo "say c"                                                                                                        >> $BUILDMBR
echo "if q \= 'q' then"                                                                                             >> $BUILDMBR
echo "  signal on error"                                                                                            >> $BUILDMBR
echo "c"                                                                                                            >> $BUILDMBR
echo "signal off error"                                                                                             >> $BUILDMBR
echo "return"                                                                                                       >> $BUILDMBR
echo "error:"                                                                                                       >> $BUILDMBR
echo "say ' '"                                                                                                      >> $BUILDMBR
echo "say 'ERROR 'rc' : SEE JOBLOG'"                                                                                >> $BUILDMBR
echo "exit 99"                                                                                                      >> $BUILDMBR
