
#  Include: Setup Vars.


DFTHLIBD="CAF v0.92.0 (c) 2019 John Erps"

DFTHLIB=CAF0920


HOST=$1
USER=$2
HLIB=$3
MODE=$4


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


BUILDMBR=$SDIR/src/TOOLSRC/CAFBUILD.MBR

FTPS=$SDIR/ftp.txt
