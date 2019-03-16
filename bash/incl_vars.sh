
#  (c) 2019 John Erps
#  This software is licensed under the MIT license (see LICENSE)


#  Include: Setup Vars.



CAFVERN="0930"
CAFVERT="v0.93.0"


DFTHLIBD="CAF $CAFVERT (c) 2019 John Erps"

DFTHLIB="CAF$CAFVERN"


HOST=$1
USER=$2
HLIB=$3
MODE=$4
SKIPS=$5

declare -a SRC0=( TOOLSRC
                  QINCSRC
                  QDDSSRC
                  QRPGLESRC
                  QCLLESRC
                  QCMDSRC
                )


declare -a SRC1=( CSYSBASE
                  CSYSSQLS
                  CAPPBASE
                  CAPPSSAM
                  CAPPDISP
                )


if [ -z "$HLIB" ]; then
  HLIB=$DFTHLIB
fi

case "$HLIB" in
  x ) HLIB=$DFTHLIB;;
  * ) ;;
esac


BUILDMBR=$SRCDIR/TOOLSRC/CAFBUILD.MBR

FTPS=$SCRDIR/ftp.txt
