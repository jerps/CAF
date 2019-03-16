#!/bin/bash


#  (c) 2019 John Erps
#  This software is licensed under the MIT license (see LICENSE)


#  Generate REXX BUILD script to build CAF library on host.


#  Current script directory.
SCRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

SRCDIR=${SCRDIR%/*}/src


source $SCRDIR/incl_vars.sh

HLIB=$1


echo " "
echo " "
echo "  This script generates REXX BUILD script:"
echo "  $BUILDMBR"
echo " "


if [ -z "$HLIB" ]; then
  echo " "
  echo "  Par 1 = Host Lib (x is $DFTHLIB)"
  echo " "
  exit 0
fi


case "$HLIB" in
  x ) HLIB=$DFTHLIB;;
  * ) ;;
esac


echo "  Lib : $HLIB"
echo " "


read -p "  Continue (Y/.)?" choice
case "$choice" in
  Y ) echo "  OK...";;
  * ) exit 0;;
esac


source $SCRDIR/incl_genbuild.sh


echo " "
echo "READY."

exit 0
