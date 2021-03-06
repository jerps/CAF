#!/bin/bash


#  (c) 2019 John Erps
#  This software is licensed under the MIT license (see LICENSE)


#  1. Delete/(re)create src dir and subdirs.
#  2. Download sources from host lib to src dir.
#  3. Generate REXX BUILD script.

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
echo "  1. DELETE/(RE)CREATE $SRCDIR"
echo "     and subdirs."
echo " "
echo "  2. DOWNLOAD sources from host lib $HLIB"
echo "     into $SRCDIR."
echo " "
echo "  3. Generate REXX BUILD script:"
echo "     $BUILDMBR"
echo " "


if [ -z "$HOST" -o -z "$USER" -o -z "$HLIB" ]; then
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


read -p "  Continue (Y/.)?" choice
case "$choice" in
  Y ) echo "  OK...";;
  * ) exit 9;;
esac


rm -rf $SRCDIR

mkdir $SRCDIR

for sl in "${SRC0[@]}"
do
  mkdir $SRCDIR/$sl
done
for sl in "${SRC1[@]}"
do
  x=S
  mkdir $SRCDIR/$sl$x
done

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

function mbr {
  echo "get /QSYS.LIB/$HLIB.LIB/$1.FILE/$2.MBR $SRCDIR/$1/$2.$3" >> $FTPS
}
source $SCRDIR/incl_mbrs.sh

echo "quit" >> $FTPS

ftp $HOST --verbose < $FTPS


source $SCRDIR/incl_genbuild.sh


echo " "
echo "READY."

exit 0
