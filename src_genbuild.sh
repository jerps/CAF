#!/bin/bash


#  Generate REXX BUILD script to build CAF library on host.


#  Current script directory.
SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


source $SDIR/incl_vars.sh


echo " "
echo " "
echo "  This script generates REXX BUILD script:"
echo "  $BUILDMBR"
echo " "


if [ -z "$HOST" ]; then
  echo " "
  echo "  Par 1 = Host"
  echo " "
  exit 0
fi


echo "  Host = $HOST"
echo " "


read -p "  Continue (Y/.)?" choice
case "$choice" in
  Y ) echo "  OK...";;
  * ) exit 0;;
esac


source $SDIR/incl_genbuild.sh


echo " "
echo "READY."

exit 0
