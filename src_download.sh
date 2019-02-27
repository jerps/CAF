#!/bin/bash


#  1. Download sources from host lib.
#  2. Generate REXX BUILD script.

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
echo "  1. DOWNLOAD sources from host lib $HLIB"
echo "     to $SDIR/src."
echo "     src WILL BE COMPLETELY REPLACED!"
echo " "
echo "  2. Generate REXX BUILD script:"
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


read -p "  Continue (Y/.)?" choice
case "$choice" in
  Y ) echo "  OK...";;
  * ) exit 0;;
esac


rm -rf $SDIR/src

for sl in "${SRC0[@]}"
do
  mkdir -p $SDIR/src/$sl
done
for sl in "${SRC1[@]}"
do
  x=S
  mkdir -p $SDIR/src/$sl$x
done

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

for sl in "${SRC0[@]}"
do
  echo "cd /QSYS.LIB/$HLIB.LIB/$sl.FILE" >> $FTPS
  echo "lcd $SDIR/src/$sl" >> $FTPS
  echo "mget *.MBR" >> $FTPS
done
for sl in "${SRC1[@]}"
do
  x=S
  echo "cd /QSYS.LIB/$HLIB.LIB/$sl$x.FILE" >> $FTPS
  echo "lcd $SDIR/src/$sl$x" >> $FTPS
  echo "mget *.MBR" >> $FTPS
done

echo "quit" >> $FTPS

ftp $USER@$HOST < $FTPS

rm $FTPS


source $SDIR/incl_genbuild.sh


echo " "
echo "READY."

exit 0
