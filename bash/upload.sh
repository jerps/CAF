#!/bin/bash


#  (c) 2019 John Erps
#  This software is licensed under the MIT license (see LICENSE)


#  1. Generate REXX BUILD script.
#  2. (Re)create host lib and add source files.
#  3. Add members to source files in host lib and upload sources from src dir.

#  Parameters:
#    1 : Host
#    2 : User
#    3 : Host Lib
#    4 : P = Use passive mode instead of extended passive mode


#  Current script directory.
SCRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

SRCDIR=${SCRDIR%/*}/src


source $SCRDIR/incl_vars.sh


echo " "
echo " "
echo "  This script performs the following steps."
echo " "
echo "  1. Generate REXX BUILD script:"
echo "     $BUILDMBR"
echo " "
echo "  2. (RE)CREATE host lib $HLIB and add source files."
echo " "
echo "  3. UPLOAD sources from $SRCDIR"
echo "     and change member types and texts in source files in $HLIB."
echo " "


if [ -z "$HOST" -o -z "$USER" ]; then
  echo " "
  echo "  Par 1 : Host"
  echo " "
  echo "      2 : User"
  echo " "
  echo "      3 : Host Lib (blank or x is $DFTHLIB)"
  echo " "
  echo "      4 : P = Use passive mode instead of extended passive mode"
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


echo "  ***** You may delete or rename lib $HLIB first if it exists *****"
echo " "
read -p "  ..... Continue (Y/.)?" choice
case "$choice" in
  Y ) echo "  OK...";;
  * ) exit 0;;
esac


source $SCRDIR/incl_genbuild.sh


if [ -f $FTPS ]; then
  rm $FTPS
fi

echo "$USER" > $FTPS
echo "prompt" >> $FTPS
echo "quote site namefmt 1" >> $FTPS

case "$MODE" in
  P ) echo "epsv" >> $FTPS;;
  * ) ;;
esac

echo "quote rcmd CRTLIB $HLIB" >> $FTPS

echo "quote rcmd CHGLIB LIB($HLIB) TEXT('$DFTHLIBD')" >> $FTPS

echo "quote rcmd CRTDTAARA DTAARA($HLIB/CAFVERSION) TYPE(*CHAR) LEN(4) VALUE('$CAFVERN') TEXT('CAF Version')" >> $FTPS

echo "put $SRCDIR/../LICENSE /QSYS.LIB/$HLIB.LIB/LICENSE.FILE" >> $FTPS

for sl in "${SRC0[@]}"
do
  echo "quote rcmd CRTSRCPF FILE($HLIB/$sl) RCDLEN(120)" >> $FTPS
done
for sl in "${SRC1[@]}"
do
  x=S
  echo "quote rcmd CRTSRCPF FILE($HLIB/$sl$x) RCDLEN(120)" >> $FTPS
done

function csf {
  echo "quote rcmd CHGSRCPF FILE($HLIB/$1) TEXT('$2')" >> $FTPS
}
csf   TOOLSRC     "Tool Source"
csf   QINCSRC     "Include Source"
csf   QDDSSRC     "DDS Source"
csf   QRPGLESRC   "RPGLE Source"
csf   QCLLESRC    "CLLE Source"
csf   QCMDSRC     "CMD Source"
csf   CSYSBASES   "Common System: Base - Source"
csf   CSYSSQLSS   "Common System: SQL Support - Source"
csf   CAPPBASES   "Common Application: Base - Source"
csf   CAPPSSAMS   "Common Application: SubSystem AppMenu - Source"
csf   CAPPDISPS   "Common Application: Display - Source"

function mbr {
  echo "put $SRCDIR/$1/$2.$3 /QSYS.LIB/$HLIB.LIB/$1.FILE/$2.MBR" >> $FTPS
  echo "quote rcmd CHGPFM FILE($HLIB/$1) MBR($2) SRCTYPE($3) TEXT('$4')" >> $FTPS
}
source $SCRDIR/incl_mbrs.sh

echo "quit" >> $FTPS

ftp $HOST --verbose < $FTPS


echo " "
echo "EXECUTE \"STRREXPRC SRCMBR(CAFBUILD) SRCFILE($HLIB/TOOLSRC)\" TO BUILD CAF ($HLIB)."

echo " "
echo "READY."

exit 0
