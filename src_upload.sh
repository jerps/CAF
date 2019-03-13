#!/bin/bash


#  1. Generate REXX BUILD script.
#  2. Upload sources to host lib.
#  3. Set descriptions and types.

#  Parameters:
#    1 : Host
#    2 : User
#    3 : Host Lib
#    4 : P = Use passive mode instead of extended passive mode


#  Current script directory.
SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


source $SDIR/incl_vars.sh


echo " "
echo " "
echo "  This script performs the following steps."
echo " "
echo "  1. Generate REXX BUILD script:"
echo "     $BUILDMBR"
echo " "
echo "  2. UPLOAD sources from $SDIR/src"
echo "     to host lib $HLIB."
echo " "
echo "  3. Set descriptions and source member types."
echo " "


if [ -z "$HOST" -o -z "$USER" ]; then
  echo " "
  echo "  Par 1 : Host"
  echo " "
  echo "      2 : User"
  echo " "
  echo "      3 : Host Lib (blank or x is $DFTHLIB)"
  echo " "
  echo "      4 : P = use passive mode instead of default extended passive mode"
  echo " "
  exit 0
fi


echo "  Host : $HOST"
echo "  User : $USER"
echo "  Lib  : $HLIB"
echo " "
case "$MODE" in
  P ) echo "  Mode : Passive mode instead of extended passive mode";;
  * ) echo "  Mode : Extended passive mode (default)";;
esac
echo " "


echo "  ***** You may delete lib $HLIB first *****"
echo " "
read -p "  ..... Continue (Y/.)?" choice
case "$choice" in
  Y ) echo "  OK...";;
  * ) exit 0;;
esac


source $SDIR/incl_genbuild.sh


if [ -f $FTPS ]; then
  rm $FTPS
fi

echo "quote site namefmt 1" > $FTPS
echo "prompt" >> $FTPS
echo "ascii" >> $FTPS

case "$MODE" in
  P ) echo "epsv" >> $FTPS;;
  * ) ;;
esac

echo "quote rcmd CRTLIB $HLIB" >> $FTPS

for sl in "${SRC0[@]}"
do
  echo "quote rcmd CRTSRCPF FILE($HLIB/$sl) RCDLEN(120)" >> $FTPS
done
for sl in "${SRC1[@]}"
do
  x=S
  echo "quote rcmd CRTSRCPF FILE($HLIB/$sl$x) RCDLEN(120)" >> $FTPS
done

for sl in "${SRC0[@]}"
do
  echo "cd /QSYS.LIB/$HLIB.LIB/$sl.FILE" >> $FTPS
  echo "lcd $SDIR/src/$sl" >> $FTPS
  echo "mput *.MBR" >> $FTPS
done
for sl in "${SRC1[@]}"
do
  x=S
  echo "cd /QSYS.LIB/$HLIB.LIB/$sl$x.FILE" >> $FTPS
  echo "lcd $SDIR/src/$sl$x" >> $FTPS
  echo "mput *.MBR" >> $FTPS
done

echo "quote rcmd CHGLIB LIB($HLIB) TEXT('$DFTHLIBD')" >> $FTPS

function csf {
  echo "quote rcmd CHGSRCPF FILE($HLIB/$1) TEXT('$2')" >> $FTPS
}
csf   TOOLSRC     "Tools Source"
csf   QINCSRC     "Include Source"
csf   QDDSSRC     "DDS Source"
csf   QRPGLESRC   "RPGLE Source"
csf   QCLLESRC    "CLLE Source"
csf   QCMDSRC     "DDS Source"
csf   CSYSBASES   "Common System: Base - Source"
csf   CSYSSQLSS   "Common System: SQL Support - Source"
csf   CAPPBASES   "Common Application: Base - Source"
csf   CAPPSSAMS   "Common Application: SubSystem AppMenu - Source"
csf   CAPPDISPS   "Common Application: Display - Source"

function cm {
  echo "quote rcmd CHGPFM FILE($HLIB/$1) MBR($2) SRCTYPE($3) TEXT('$4')" >> $FTPS
}
cm    TOOLSRC     CAFBUILD     REXX    "Compile All Objects In Library $HLIB"
cm    TOOLSRC     CAFBUILD0    CLLE    "Compile Tool Objects"
cm    TOOLSRC     CO           CMD     "Compile Object"
cm    TOOLSRC     CO0          CLLE    "Compile Object - Cmd Processor"
cm    TOOLSRC     COCLMOD      CLLE    "CO: CLLE (*MODULE) . . . . . . . . . . . .CRTCLMOD"
cm    TOOLSRC     COCLPGM      CLLE    "CO: CLP/CLLE (*PGM)  . . . . . . CRTBNDCL/CRTCLPGM"
cm    TOOLSRC     COCMD        CLLE    "CO: CMD (*CMD) . . . . . . . . . . . . . . .CRTCMD"
cm    TOOLSRC     CODSPF       CLLE    "CO: DSPF (*FILE) . . . . . . . . . . . . . CRTDSPF"
cm    TOOLSRC     COPFLF       CLLE    "CO: PF/LF (*FILE)  . . . . CRTPF/CHGPF/CRTLF/CHGLF"
cm    TOOLSRC     COPSCC       RPGLE   "CO: Process Source Compile Commands"
cm    TOOLSRC     CORPGMOD     CLLE    "CO: RPGLE (*MODULE)  . . . . . . . . . . CRTRPGMOD"
cm    TOOLSRC     CORPGPGM     CLLE    "CO: RPG/RPGLE (*PGM) . . . . . CRTBNDRPG/CRTRPGPGM"
cm    TOOLSRC     CPYCAFDTA    CMD     "Copy CAF Data"
cm    TOOLSRC     CPYCAFDTA0   CLLE    "Copy CAF Data - CP 0"
cm    TOOLSRC     RDICO        CMD     "RDi: Compile Object"
cm    TOOLSRC     RDICO0       CLLE    "RDi: Compile Object - Cmd Processor"
cm    TOOLSRC     SETCAFAUT    CMD     "Set CAF Authorities"
cm    TOOLSRC     SETCAFAUT0   CLLE    "Set CAF Authorities - CP 0"
cm    TOOLSRC     SETCAFAUT1   CLLE    "Set CAF Authorities - CP 1"
cm    TOOLSRC     SETCAFAUT2   CLLE    "Set CAF Authorities - CP 2"
cm    TOOLSRC     SETCAFAUT3   CLLE    "Set CAF Authorities - CP 3"
cm    TOOLSRC     SETCAFAUT4   CLLE    "Set CAF Authorities - CP 4"
cm    TOOLSRC     SETCAFAUT8   RPGLE   "Set CAF Authorities - CP 8"
cm    TOOLSRC     SETCAFAUT9   RPGLE   "Set CAF Authorities - CP 9"
cm    QINCSRC     PGM_HEAD1    RPGLE   "Program Header specs (ACTGRP *NEW)"
cm    QINCSRC     PGM_HEAD2    RPGLE   "Program Header specs (ACTGRP *CALLER)"
cm    QINCSRC     C_ERRNO      RPGLE   "C errno values"
cm    QINCSRC     CAPPDC_ROE   RPGLE   "Common App SubSys Data Cmd DC: sub return_on_error"
cm    QINCSRC     CAFMENU      RPGLE   "Prototype for program CAFMENU"
cm    QINCSRC     CAFMENUG     RPGLE   "Prototype for program CAFMENUG"
cm    QINCSRC     CAFMENUGD    RPGLE   "Prototype for program CAFMENUGD"
cm    QINCSRC     CAFNWD       RPGLE   "Prototype for program CAFNWD"
cm    QINCSRC     CAFNWDT      RPGLE   "Prototype for program CAFNWDT"
cm    QINCSRC     CAFSQLS      RPGLE   "Prototype for program CAFSQLS"
cm    QINCSRC     CAFSQLSD     RPGLE   "Prototype for program CAFSQLSD"
cm    QINCSRC     DPGM_HEAD    RPGLE   "Display Program Header specs"
cm    QINCSRC     DPGM_LPI     RPGLE   "Display Program Local Procedure Implementations"
cm    QINCSRC     DPGM_LPP     RPGLE   "Display Program Local Procedure Prototypes"
cm    QINCSRC     DPGM_SUBR    RPGLE   "Display Program Subroutines"
cm    QINCSRC     DS_PSI       RPGLE   "Datastructure: Program Status Information"
cm    QINCSRC     IFSCONST     RPGLE   "IFS API Constants"
cm    QINCSRC     IFSPROTO     RPGLE   "IFS API Prototypes"
cm    QDDSSRC     CAFMENU      DSPF    "CAF - Menu"
cm    QDDSSRC     CAFMENUG     DSPF    "CAF - Menu Groups: Work with"
cm    QDDSSRC     CAFMENUGD    DSPF    "CAF - Menu Groups: Detail"
cm    QDDSSRC     CAFNWD       DSPF    "CAF - Non-Workdays"
cm    QDDSSRC     CAFNWDT      DSPF    "CAF - Non-Workday Types"
cm    QDDSSRC     CAFSQLS      DSPF    "CAF - SQL Statements: Work with"
cm    QDDSSRC     CAFSQLSD     DSPF    "CAF - SQL Statements: Detail"
cm    QRPGLESRC   CAFMENU      RPGLE   "CAF - Menu"
cm    QRPGLESRC   CAFMENUG     RPGLE   "CAF - Menu Groups: Work with"
cm    QRPGLESRC   CAFMENUGD    RPGLE   "CAF - Menu Groups: Detail"
cm    QRPGLESRC   CAFNWD       RPGLE   "CAF - Non-Workdays"
cm    QRPGLESRC   CAFNWDT      RPGLE   "CAF - Non-Workday Types"
cm    QRPGLESRC   CAFSQLS      RPGLE   "CAF - SQL Statements: Work with"
cm    QRPGLESRC   CAFSQLSD     RPGLE   "CAF - SQL Statements: Detail"
cm    QCLLESRC    CAFMENUG0    CLLE    "CAFMENUG Cmd Processor"
cm    QCLLESRC    CAFMENU0     CLLE    "CAFMENU Cmd Processor"
cm    QCLLESRC    CAFNWD0      CLLE    "CAFNWD Cmd Processor"
cm    QCLLESRC    CAFNWDT0     CLLE    "CAFNWDT Cmd Processor"
cm    QCLLESRC    CAFSQLS0     CLLE    "CAFSQLS Cmd Processor"
cm    QCMDSRC     CAFMENU      CMD     "CAF - Menu"
cm    QCMDSRC     CAFMENUG     CMD     "CAF - Menu Groups: Work with"
cm    QCMDSRC     CAFNWD       CMD     "CAF - Non-Workdays"
cm    QCMDSRC     CAFNWDT      CMD     "CAF - Non-Workday Types"
cm    QCMDSRC     CAFSQLS      CMD     "CAF - SQL Statements: Work with"
cm    CSYSBASES   CSYS_BASE    BND     "Common System: Base"
cm    CSYSBASES   CSYSBASEB0   CLLE    "CSYSBASE/Build 0: All"
cm    CSYSBASES   CSYSBASEB1   CLLE    "CSYSBASE/Build 1: Prereqs"
cm    CSYSBASES   CSYSBASEB2   CLLE    "CSYSBASE/Build 2: Modules"
cm    CSYSBASES   CSYSBASEB3   CLLE    "CSYSBASE/Build 3: Serviceprogram"
cm    CSYSBASES   CSYSBASEB4   CLLE    "CSYSBASE/Build 4: Binding Directory"
cm    CSYSBASES   CSYSBASEB8   CLLE    "CSYSBASE/Build 8: Other"
cm    CSYSBASES   CSYSBASEB9   CLLE    "CSYSBASE/Build 9: Clean Up"
cm    CSYSBASES   CSYSBASECV   RPGLE   "CSYSBASE/Module CV: Conversions"
cm    CSYSBASES   CSYSBASEDF   RPGLE   "CSYSBASE/Module DF: DisplayFile"
cm    CSYSBASES   CSYSBASEDT   RPGLE   "CSYSBASE/Module DT: Date/Time functions"
cm    CSYSBASES   CSYSBASEF0   PF      "CSYSBASE/File 0: SysBase Values"
cm    CSYSBASES   CSYSBASEF1   PF      "CSYSBASE/File 1: Non-Work Day Types"
cm    CSYSBASES   CSYSBASEF2   PF      "CSYSBASE/File 2: Non-Work Days"
cm    CSYSBASES   CSYSBASEP0   RPGLE   "CSYSBASE/Program 0: Initial Data Load"
cm    CSYSBASES   CSYSBASERM   RPGLE   "CSYSBASE/Module RM: Resource Management"
cm    CSYSBASES   CSYSBASETU   RPGLE   "CSYSBASE/Module TU: Text Utilities"
cm    CSYSBASES   CSYSBASEWM   RPGLE   "CSYSBASE/Module WM: Work Management"
cm    CSYSBASES   CSYSBASEXD   RPGLE   "CSYSBASE/Module XD: XML Document"
cm    CSYSBASES   CSYSBASEXX   RPGLE   "CSYSBASE/Module XX: Miscellaneous"
cm    CSYSBASES   INCL__CV     RPGLE   "CSYSBASE/Include: Module CV (Internal)"
cm    CSYSBASES   INCL__DF     RPGLE   "CSYSBASE/Include: Module DF (Internal)"
cm    CSYSBASES   INCL__DT     RPGLE   "CSYSBASE/Include: Module DT (Internal)"
cm    CSYSBASES   INCL__MODD   RPGLE   "CSYSBASE/Include: Module Definitions"
cm    CSYSBASES   INCL__MODH   RPGLE   "CSYSBASE/Include: Module Header Specs"
cm    CSYSBASES   INCL__TU     RPGLE   "CSYSBASE/Include: Module TU (Internal)"
cm    CSYSBASES   INCL__WM     RPGLE   "CSYSBASE/Include: Module WM (Internal)"
cm    CSYSBASES   INCL__XD     RPGLE   "CSYSBASE/Include: Module XD (Internal)"
cm    CSYSBASES   INCL__XX     RPGLE   "CSYSBASE/Include: Module XX (Internal)"
cm    CSYSBASES   INCL_API     RPGLE   "CSYSBASE/Include: API"
cm    CSYSBASES   INCL_CV      RPGLE   "CSYSBASE/Include: Conversions"
cm    CSYSBASES   INCL_DEFS    RPGLE   "CSYSBASE/Include: Definitions"
cm    CSYSBASES   INCL_DF      RPGLE   "CSYSBASE/Include: DisplayFile"
cm    CSYSBASES   INCL_DT      RPGLE   "CSYSBASE/Include: Date/Time functions"
cm    CSYSBASES   INCL_RM      RPGLE   "CSYSBASE/Include: Resource Management"
cm    CSYSBASES   INCL_TU      RPGLE   "CSYSBASE/Include: Text Utilities"
cm    CSYSBASES   INCL_WM      RPGLE   "CSYSBASE/Include: Work Management"
cm    CSYSBASES   INCL_XD      RPGLE   "CSYSBASE/Include: XML Document"
cm    CSYSBASES   INCL_XX      RPGLE   "CSYSBASE/Include: Miscellaneous"
cm    CSYSSQLSS   CSYS_SQLS    BND     "Common System: SQL Support"
cm    CSYSSQLSS   CSYSSQLSB0   CLLE    "CSYSSQLS/Build 0: All"
cm    CSYSSQLSS   CSYSSQLSB1   CLLE    "CSYSSQLS/Build 1: Prereqs"
cm    CSYSSQLSS   CSYSSQLSB2   CLLE    "CSYSSQLS/Build 2: Modules"
cm    CSYSSQLSS   CSYSSQLSB3   CLLE    "CSYSSQLS/Build 3: Serviceprogram"
cm    CSYSSQLSS   CSYSSQLSB4   CLLE    "CSYSSQLS/Build 4: Binding Directory"
cm    CSYSSQLSS   CSYSSQLSB8   CLLE    "CSYSSQLS/Build 8: Other"
cm    CSYSSQLSS   CSYSSQLSB9   CLLE    "CSYSSQLS/Build 9: Clean Up"
cm    CSYSSQLSS   CSYSSQLSCI   RPGLE   "CSYSSQLS/Module CI: Call Interface"
cm    CSYSSQLSS   CSYSSQLSC1   CMD     "CSYSSQLS/Command 1: Edit SQL Statement"
cm    CSYSSQLSS   CSYSSQLSFR   PF      "CSYSSQLS/Field Reference File"
cm    CSYSSQLSS   CSYSSQLSF1   PF      "CSYSSQLS/File 1: SQL Statements"
cm    CSYSSQLSS   CSYSSQLSP0   RPGLE   "CSYSSQLS/Program 0: Initial Data Load"
cm    CSYSSQLSS   CSYSSQLSP1   RPGLE   "CSYSSQLS/Program 1: Edit SQL Statement"
cm    CSYSSQLSS   CSYSSQLSP8   CLLE    "CSYSSQLS/Program 8: Release SP/RCLACTGRP CSYSSQLS"
cm    CSYSSQLSS   CSYSSQLSP9   RPGLE   "CSYSSQLS/Program 9: Release SP CSYSSQLS"
cm    CSYSSQLSS   CSYSSQLSRM   RPGLE   "CSYSSQLS/Module RM: Resource Management"
cm    CSYSSQLSS   CSYSSQLSSS   RPGLE   "CSYSSQLS/Module SS: Statement Storage"
cm    CSYSSQLSS   INCL__CI     RPGLE   "CSYSSQLS/Include: Module CI (Internal)"
cm    CSYSSQLSS   INCL__MODD   RPGLE   "CSYSSQLS/Include: Module Definitions"
cm    CSYSSQLSS   INCL__MODH   RPGLE   "CSYSSQLS/Include: Module Header Specs"
cm    CSYSSQLSS   INCL__SS     RPGLE   "CSYSSQLS/Include: Module SS (Internal)"
cm    CSYSSQLSS   INCL_API     RPGLE   "CSYSSQLS/Include: API"
cm    CSYSSQLSS   INCL_CI      RPGLE   "CSYSSQLS/Include: Call Interface"
cm    CSYSSQLSS   INCL_DEFS    RPGLE   "CSYSSQLS/Include: Definitions"
cm    CSYSSQLSS   INCL_RM      RPGLE   "CSYSSQLS/Include: Resource Management"
cm    CSYSSQLSS   INCL_SS      RPGLE   "CSYSSQLS/Include: Statement Storage"
cm    CAPPBASES   CAPP_BASE    BND     "Common Application: Base"
cm    CAPPBASES   CAPPBASEAM   RPGLE   "CAPPBASE/Module AM: Application Messages"
cm    CAPPBASES   CAPPBASEB0   CLLE    "CAPPBASE/Build 0: All"
cm    CAPPBASES   CAPPBASEB1   CLLE    "CAPPBASE/Build 1: Prereqs"
cm    CAPPBASES   CAPPBASEB2   CLLE    "CAPPBASE/Build 2: Modules"
cm    CAPPBASES   CAPPBASEB3   CLLE    "CAPPBASE/Build 3: Serviceprogram"
cm    CAPPBASES   CAPPBASEB4   CLLE    "CAPPBASE/Build 4: Binding Directory"
cm    CAPPBASES   CAPPBASEB8   CLLE    "CAPPBASE/Build 8: Other"
cm    CAPPBASES   CAPPBASEB9   CLLE    "CAPPBASE/Build 9: Clean Up"
cm    CAPPBASES   CAPPBASEIR   RPGLE   "CAPPBASE/Module IR: Interpret Raw input"
cm    CAPPBASES   CAPPBASEMS   RPGLE   "CAPPBASE/Module MS: Message Support"
cm    CAPPBASES   CAPPBASEPT   RPGLE   "CAPPBASE/Module PT: Presentation Texts"
cm    CAPPBASES   CAPPBASERM   RPGLE   "CAPPBASE/Module RM: Resource Management"
cm    CAPPBASES   CAPPBASEVA   RPGLE   "CAPPBASE/Module VA: Value Arrays"
cm    CAPPBASES   CAPPBASEXX   RPGLE   "CAPPBASE/Module XX: Miscellaneous"
cm    CAPPBASES   INCL__AM     RPGLE   "CAPPBASE/Include: Module AM (Internal)"
cm    CAPPBASES   INCL__IR     RPGLE   "CAPPBASE/Include: Module IR (Internal)"
cm    CAPPBASES   INCL__MODD   RPGLE   "CAPPBASE/Include: Module Definitions"
cm    CAPPBASES   INCL__MODH   RPGLE   "CAPPBASE/Include: Module Header Specs"
cm    CAPPBASES   INCL__MS     RPGLE   "CAPPBASE/Include: Module MS (Internal)"
cm    CAPPBASES   INCL__PT     RPGLE   "CAPPBASE/Include: Module PT (Internal)"
cm    CAPPBASES   INCL__VA     RPGLE   "CAPPBASE/Include: Module VA (Internal)"
cm    CAPPBASES   INCL__XX     RPGLE   "CAPPBASE/Include: Module XX (Internal)"
cm    CAPPBASES   INCL_API     RPGLE   "CAPPBASE/Include: API"
cm    CAPPBASES   INCL_AM      RPGLE   "CAPPBASE/Include: Application Messages"
cm    CAPPBASES   INCL_DEFS    RPGLE   "CAPPBASE/Include: Definitions"
cm    CAPPBASES   INCL_IR      RPGLE   "CAPPBASE/Include: Interpret Raw input"
cm    CAPPBASES   INCL_MS      RPGLE   "CAPPBASE/Include: Message Support"
cm    CAPPBASES   INCL_PT      RPGLE   "CAPPBASE/Include: Presentation Texts"
cm    CAPPBASES   INCL_RM      RPGLE   "CAPPBASE/Include: Resource Management"
cm    CAPPBASES   INCL_VA      RPGLE   "CAPPBASE/Include: Value Arrays"
cm    CAPPBASES   INCL_XX      RPGLE   "CAPPBASE/Include: Miscellaneous"
cm    CAPPSSAMS   CAPP_SSAM    BND     "Common Application: SubSystem AppMenu"
cm    CAPPSSAMS   CAPPSSAMAM   RPGLE   "CAPPSSAM/Module AM: Application Messages"
cm    CAPPSSAMS   CAPPSSAMB0   CLLE    "CAPPSSAM/Build 0: All"
cm    CAPPSSAMS   CAPPSSAMB1   CLLE    "CAPPSSAM/Build 1: Prereqs"
cm    CAPPSSAMS   CAPPSSAMB2   CLLE    "CAPPSSAM/Build 2: Modules"
cm    CAPPSSAMS   CAPPSSAMB3   CLLE    "CAPPSSAM/Build 3: Serviceprogram"
cm    CAPPSSAMS   CAPPSSAMB4   CLLE    "CAPPSSAM/Build 4: Binding Directory"
cm    CAPPSSAMS   CAPPSSAMB8   CLLE    "CAPPSSAM/Build 8: Other"
cm    CAPPSSAMS   CAPPSSAMB9   CLLE    "CAPPSSAM/Build 9: Clean Up"
cm    CAPPSSAMS   CAPPSSAMCH   CLLE    "CAPPSSAM/Command Handler Program"
cm    CAPPSSAMS   CAPPSSAMDC   RPGLE   "CAPPSSAM/Module DC: Database Commands"
cm    CAPPSSAMS   CAPPSSAMDQ   RPGLE   "CAPPSSAM/Module DQ: Database Queries"
cm    CAPPSSAMS   CAPPSSAMFR   PF      "CAPPSSAM/Field Reference File"
cm    CAPPSSAMS   CAPPSSAMF1   PF      "CAPPSSAM/File 1: Slots"
cm    CAPPSSAMS   CAPPSSAMF2   PF      "CAPPSSAM/File 2: Slot/Groups"
cm    CAPPSSAMS   CAPPSSAMF3   PF      "CAPPSSAM/File 3: Groups"
cm    CAPPSSAMS   CAPPSSAMF4   PF      "CAPPSSAM/File 4: Members/Groups (Group Members)"
cm    CAPPSSAMS   CAPPSSAMF5   LF      "CAPPSSAM/File 5: Index on CAPPSSAMF2"
cm    CAPPSSAMS   CAPPSSAMF6   LF      "CAPPSSAM/File 6: Index on CAPPSSAMF4"
cm    CAPPSSAMS   CAPPSSAMMO   RPGLE   "CAPPSSAM/Module MO: Menu Operations"
cm    CAPPSSAMS   CAPPSSAMP0   RPGLE   "CAPPSSAM/Program 0: Initial Data Load"
cm    CAPPSSAMS   CAPPSSAMP1   RPGLE   "CAPPSSAM/Program 1: Add user to group"
cm    CAPPSSAMS   CAPPSSAMRM   RPGLE   "CAPPSSAM/Module RM: Resource Management"
cm    CAPPSSAMS   CAPPSSAMVA   RPGLE   "CAPPSSAM/Module VA: Value Arrays"
cm    CAPPSSAMS   CAPPSSAMXX   RPGLE   "CAPPSSAM/Module XX: Miscellaneous"
cm    CAPPSSAMS   INCL__AM     RPGLE   "CAPPSSAM/Include: Module AM (Internal)"
cm    CAPPSSAMS   INCL__DC     RPGLE   "CAPPSSAM/Include: Module DC (Internal)"
cm    CAPPSSAMS   INCL__DQ     RPGLE   "CAPPSSAM/Include: Module DQ (Internal)"
cm    CAPPSSAMS   INCL__MO     RPGLE   "CAPPSSAM/Include: Module MO (Internal)"
cm    CAPPSSAMS   INCL__MODD   RPGLE   "CAPPSSAM/Include: Module Definitions"
cm    CAPPSSAMS   INCL__MODH   RPGLE   "CAPPSSAM/Include: Module Header Specs"
cm    CAPPSSAMS   INCL__VA     RPGLE   "CAPPSSAM/Include: Module VA (Internal)"
cm    CAPPSSAMS   INCL__XX     RPGLE   "CAPPSSAM/Include: Module XX (Internal)"
cm    CAPPSSAMS   INCL_AM      RPGLE   "CAPPSSAM/Include: Application Messages"
cm    CAPPSSAMS   INCL_API     RPGLE   "CAPPSSAM/Include: API"
cm    CAPPSSAMS   INCL_DC      RPGLE   "CAPPSSAM/Include: Database Commands"
cm    CAPPSSAMS   INCL_DEFS    RPGLE   "CAPPSSAM/Include: Definitions"
cm    CAPPSSAMS   INCL_DQ      RPGLE   "CAPPSSAM/Include: Database Queries"
cm    CAPPSSAMS   INCL_MO      RPGLE   "CAPPSSAM/Include: Menu Operations"
cm    CAPPSSAMS   INCL_RM      RPGLE   "CAPPSSAM/Include: Resource Management"
cm    CAPPSSAMS   INCL_VA      RPGLE   "CAPPSSAM/Include: Value Arrays"
cm    CAPPSSAMS   INCL_XX      RPGLE   "CAPPSSAM/Include: Miscellaneous"
cm    CAPPDISPS   CAPP_DISP    BND     "Common Application: Display"
cm    CAPPDISPS   CAPPDISPB0   CLLE    "CAPPDISP/Build 0: All"
cm    CAPPDISPS   CAPPDISPB1   CLLE    "CAPPDISP/Build 1: Prereqs"
cm    CAPPDISPS   CAPPDISPB2   CLLE    "CAPPDISP/Build 2: Modules"
cm    CAPPDISPS   CAPPDISPB3   CLLE    "CAPPDISP/Build 3: Serviceprogram"
cm    CAPPDISPS   CAPPDISPB4   CLLE    "CAPPDISP/Build 4: Binding Directory"
cm    CAPPDISPS   CAPPDISPB8   CLLE    "CAPPDISP/Build 8: Other"
cm    CAPPDISPS   CAPPDISPB9   CLLE    "CAPPDISP/Build 9: Clean Up"
cm    CAPPDISPS   CAPPDISPD1   DSPF    "CAPPDISP/DisplayFile 1: Display Help"
cm    CAPPDISPS   CAPPDISPD2   DSPF    "CAPPDISP/DisplayFile 2: Select Item"
cm    CAPPDISPS   CAPPDISPD3   DSPF    "CAPPDISP/DisplayFile 3: Display Messages (*NORMAL)"
cm    CAPPDISPS   CAPPDISPD4   DSPF    "CAPPDISP/DisplayFile 4: Display Messages (*WIDE)"
cm    CAPPDISPS   CAPPDISPD9   DSPF    "CAPPDISP/DisplayFile 9: Miscellaneous"
cm    CAPPDISPS   CAPPDISPF1   PF      "CAPPDISP/File 1: Help Texts"
cm    CAPPDISPS   CAPPDISPHD   RPGLE   "CAPPDISP/Module HD: Handle Display"
cm    CAPPDISPS   CAPPDISPP0   RPGLE   "CAPPDISP/Program 0: Initial Data Load"
cm    CAPPDISPS   CAPPDISPRM   RPGLE   "CAPPDISP/Module RM: Resource Management"
cm    CAPPDISPS   CAPPDISPSI   RPGLE   "CAPPDISP/Module SI: Select Item"
cm    CAPPDISPS   CAPPDISPXX   RPGLE   "CAPPDISP/Module XX: Miscellaneous"
cm    CAPPDISPS   INCL__HD     RPGLE   "CAPPDISP/Include: Module HD (Internal)"
cm    CAPPDISPS   INCL__MODD   RPGLE   "CAPPDISP/Include: Module Definitions"
cm    CAPPDISPS   INCL__MODH   RPGLE   "CAPPDISP/Include: Module Header specs"
cm    CAPPDISPS   INCL__SI     RPGLE   "CAPPDISP/Include: Module SI (Internal)"
cm    CAPPDISPS   INCL__XX     RPGLE   "CAPPDISP/Include: Module XX (Internal)"
cm    CAPPDISPS   INCL_API     RPGLE   "CAPPDISP/Include: API"
cm    CAPPDISPS   INCL_DEFS    RPGLE   "CAPPDISP/Include: Definitions"
cm    CAPPDISPS   INCL_RM      RPGLE   "CAPPDISP/Include: Resource Management"
cm    CAPPDISPS   INCL_SI      RPGLE   "CAPPDISP/Include: Select Item"
cm    CAPPDISPS   INCL_XX      RPGLE   "CAPPDISP/Include: Miscellaneous"

echo "quit" >> $FTPS

ftp $USER@$HOST < $FTPS

rm $FTPS


echo " "
echo "\"STRREXPRC SRCMBR(CAFBUILD) SRCFILE($HLIB/TOOLSRC)\" TO BUILD CAF ($HLIB)."

echo " "
echo "READY."

exit 0
