
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module XX for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : Miscellaneous


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASEXX

      /include CSYSBASES,INCL__MODH


     fCSYSBASEF0if   e           k disk    usropn


      /include CSYSBASES,INCL_XX
      /include CSYSBASES,INCL_CV
      /include CSYSBASES,INCL_TU
      /include CSYSBASES,INCL_DT

      /include QINCSRC,IFSPROTO
      /include QINCSRC,IFSCONST

      /include CSYSBASES,INCL__XX

      /include CSYSBASES,INCL__MODD


       // ----- Global Defs.

       // Exclusively used by procedure "SortBytes".
     d SortBytesBs     s             10i 0
     d SortBytesDyn@   s               *   procptr

       // Pointer to 10 "data blocks" of arbitrary size.
     d DataBlock@      s               *   dim(10) inz(*null)
       // The actual size of each "data block".
     d DataBlockSz     s             20i 0 dim(10) inz(0)

       // Used by procedures "CStrBldInit" and "CStrBldAppend".
     d CStrBldSPtr     s               *   inz(*null)
     d CStrBldSLen     s             10i 0 inz(0)
     d CStrBldAllocSz  s             10i 0 inz(0)
     d CStrBldChunkSz  s             10i 0 inz(200)


       // ----- OS/400 API Defs

       // Format OBJD0200 for API QUSROBJD
     d OS4OBJD0200     ds                  qualified inz
     d   bytesrtn                    10i 0
     d   bytesavl                    10i 0
     d   objname                     10
     d   objlib                      10
     d   objtype                     10
     d   rtnlib                      10
     d   objaspno                    10i 0
     d   objowner                    10
     d   objdomain                    2
     d   crtdatetime                 13
     d   chgdatetime                 13
     d   extobjattr                  10
     d   objtextdescr                50
     d   srcfname                    10
     d   srcflib                     10
     d   srcfmbr                     10

       // Format FILD0100 for API QDBRTVFD
       // NOTE: The API likes to have a receiver variable at least 700 bytes.
     d OS4FILD0100     ds                  qualified inz
     d   bytesrtn                    10i 0
     d   bytesavl                    10i 0
     d   attr1                        1
     d   attr2                        1
     d   data                       700

       // Format USRI0200 for API QSYRUSRI
     d OS4USRI0200     ds                  qualified inz
     d   bytesrtn                    10i 0
     d   bytesavl                    10i 0
     d   data1                       35
     d   grpprf                      10
     d   data2                       47
     d   numsuppgrps                 10i 0
     d   suppgrps                    10    dim(15)

       // Format RTVM0100 for API QMHRTVM
     d OS4RTVM0100     ds                  qualified inz
     d   bytesrtn                    10i 0
     d   bytesavl                    10i 0
     d   msglrtn                     10i 0
     d   msglavl                     10i 0
     d   msghlrtn                    10i 0
     d   msghlavl                    10i 0
     d   data                       500

       // Format CPOP0100 for API QCAPCMD
     d OS4CPOP0100     ds                  qualified inz
     d   cmdproctype                 10i 0
     d   dbcshandling                 1
     d   prompteract                  1
     d   cmdstrsyntax                 1
     d   msgrtvkey                    4
     d   reserved01                   9

      * Receiver variable for API QWCRNETA with only one attribute.
     d OS4QWCRNETA_RV  ds                  qualified inz
     d   attrs                       10i 0
     d   offset                      10i 0
     d   data                         1    dim(1000)

      * Network attribute structure for API QWCRNETA
     d OS4QWCRNETA_NA  ds                  qualified based(OS4QWCRNETA_NA@)
     d   attr                        10
     d   type                         1
     d   status                       1
     d   length                      10i 0
     d   data                      1000

      * C structure "passwd" for getpwuid()
     d OS4Passwd       ds                  qualified based(OS4Passwd@)
     d   name                          *
     d   uid                         10i 0
     d   gid                         10i 0
     d   dir                           *
     d   shell                         *

       // API QUSROBJD
     d CallQUSROBJD    pr                  extpgm('QUSROBJD')
     d   objinf                                  like(OS4OBJD0200)
     d   objinflen                   10i 0 const
     d   fmtname                      8    const
     d   qobjname                    20    const
     d   objtype                     10    const
     d   apierr                                  like(OS4Error)

       // API QDBRTVFD
       // NOTE: When receiver variable is small then only the first 8 bytes
       //       are returned with the number of available bytes. The API
       //       can be called again with a receiver variable for which
       //       this number of bytes has been allocated.
     d CallQDBRTVFD    pr                  extpgm('QDBRTVFD')
     d   fileinf                                 like(OS4FILD0100)
     d   fileinflen                  10i 0 const
     d   qrtnfilenm                  20
     d   fmtname                      8    const
     d   qfilenm                     20    const
     d   recfmtnm                    10    const
     d   procoverride                 1    const
     d   system                      10    const
     d   fmttype                     10    const
     d   apierr                                  like(OS4Error)

       // API QSYRUSRI
     d CallQSYRUSRI    pr                  extpgm('QSYRUSRI')
     d   userinf                                 like(OS4USRI0200)
     d   userinflen                  10i 0 const
     d   fmtname                      8    const
     d   usrprfnm                    10    const
     d   apierr                                  like(OS4Error)

       // API QCMDEXC
     d CallQCMDEXC     pr                  extpgm('QCMDEXC')
     d   cmd                       5000    const
     d   cmdlen                      15  5 const

       // API QCAPCMD
     d CallQCAPCMD     pr                  extpgm('QCAPCMD')
     d   cmd                       5000    const
     d   cmdlen                      10i 0 const
     d   optctlblock                       const like(OS4CPOP0100)
     d   optctlblockl                10i 0 const
     d   optctlblockf                 8    const
     d   chgcmd                   30000
     d   chgcmdlenavl                10i 0 const
     d   chgcmdlenrtn                10i 0
     d   apierr                                  like(OS4Error)

       // API QMHRTVM
     d CallQMHRTVM     pr                  extpgm('QMHRTVM')
     d   msginf                                  like(OS4RTVM0100)
     d   msginflen                   10i 0 const
     d   fmtname                      8    const
     d   msgid                        7    const
     d   qmsgf                       20    const
     d   repldata                   500    const options(*varsize)
     d   repldatalen                 10i 0 const
     d   replsubstvar                10    const
     d   rtnfmtctlchr                10    const
     d   apierr                                  like(OS4Error)

       // API QMHSNDPM
     d CallQMHSNDPM    pr                  extpgm('QMHSNDPM')
     d   msgid                        7    const
     d   qmsgf                       20    const
     d   repldata                   500    const options(*varsize)
     d   repldatalen                 10i 0 const
     d   msgtype                     10    const
     d   csentry                     10    const options(*varsize)
     d   cscounter                   10i 0 const
     d   msgkey                       4
     d   apierr                                  like(OS4Error)

       // API QWCRNETA
     d CallQWCRNETA    pr                  extpgm('QWCRNETA')
     d   rcvvar                   32766          options(*varsize)
     d   rcvvarlen                   10i 0 const
     d   nbrnetattr                  10i 0 const
     d   attrnames                   10    const
     d   apierr                                  like(OS4Error)

       // C API atoll()
     d Catoll          pr            20i 0 extproc('atoll')
     d   str                           *   value options(*string)

       // C API qsort()
     d Cqsort          pr                  extproc('qsort')
     d   data                          *   value
     d   enum                        10u 0 value
     d   esize                       10u 0 value
     d   comp                          *   value procptr

       // C API __errno()
     d CErrNoPtr       pr              *   extproc('__errno')

       // C API strerror()
     d CErrNoCvtToStr  pr              *   extproc('strerror')
     d   errno                       10i 0 value

       // C API getuid()
     d Cgetuid         pr            20i 0 extproc('getuid')

       // C API getpwuid()
     d Cgetpwuid       pr              *   extproc('getpwuid')
     d   uid                         20i 0 value


       // ----- Local Prototypes

       // Default comparator for "SortBytes".
       // This procedure uses global variable "SortBytesBs".
     dL_SortBytesDft   pr            10i 0
     d   bytes1                        *   value
     d   bytes2                        *   value

       // Special comparator for "SortBytes", used with option "*INVERSE".
     dL_SortBytesInv   pr            10i 0
     d   bytes1                        *   value
     d   bytes2                        *   Value

       // Prototype for the dynamic call of a comparator for "SortBytes".
     dL_SortBytesDyn   pr            10i 0 extproc(SortBytesDyn@)
     d   bytes1                        *   value
     d   bytes2                        *   value


       // ----- Implementation


     p RtvSysName      b                   export
     d RtvSysName      pi             8

      /free

       reset OS4Error;

       CallQWCRNETA(OS4QWCRNETA_RV:%size(OS4QWCRNETA_RV):1:'SYSNAME':OS4Error);
       if    OS4Error.bavl > 0
          or OS4QWCRNETA_RV.attrs <> 1
          or OS4QWCRNETA_RV.offset < 8
          or OS4QWCRNETA_RV.offset > 1000;
         return '';
       endif;

       OS4QWCRNETA_NA@ = %addr(OS4QWCRNETA_RV.data(OS4QWCRNETA_RV.offset-7));

       if    OS4QWCRNETA_NA.attr <> 'SYSNAME'
          or OS4QWCRNETA_NA.length < 1
          or OS4QWCRNETA_NA.length > 8
          or OS4QWCRNETA_NA.status = 'L';
         return '';
       endif;

       return %subst(OS4QWCRNETA_NA.data:1:OS4QWCRNETA_NA.length);

      /end-free
     p                 e


     p GetSysBaseValue...
     p                 b                   export
     d GetSysBaseValue...
     d                 pi           100
     d   key                         10    const

      /free

       if not %open(CSYSBASEF0);
         open CSYSBASEF0;
       endif;

       chain (key) CSYSBASEF0;

       if not %found;
         return '';
       endif;

       return SBVVALUE;

      /end-free
     p                 e


     p RtvInitWorkDir  b                   export
     d RtvInitWorkDir  pi           200

     d uid             s             20i 0

      /free

       uid = Cgetuid();
       if uid < 0;
         return '';
       endif;

       OS4Passwd@ = Cgetpwuid(uid);
       if    OS4Passwd@ = *null
          or OS4Passwd.dir = *null;
         return '';
       endif;

       return %str(OS4Passwd.dir);

      /end-free
     p                 e


     p MaxInt          b                   export
     d MaxInt          pi            20i 0
     d   int01                       20i 0 const
     d   int02                       20i 0 const
     d   int03                       20i 0 const options(*nopass)
     d   int04                       20i 0 const options(*nopass)
     d   int05                       20i 0 const options(*nopass)
     d   int06                       20i 0 const options(*nopass)
     d   int07                       20i 0 const options(*nopass)
     d   int08                       20i 0 const options(*nopass)
     d   int09                       20i 0 const options(*nopass)
     d   int10                       20i 0 const options(*nopass)
     d   int11                       20i 0 const options(*nopass)
     d   int12                       20i 0 const options(*nopass)
     d   int13                       20i 0 const options(*nopass)
     d   int14                       20i 0 const options(*nopass)
     d   int15                       20i 0 const options(*nopass)
     d   int16                       20i 0 const options(*nopass)
     d   int17                       20i 0 const options(*nopass)
     d   int18                       20i 0 const options(*nopass)
     d   int19                       20i 0 const options(*nopass)
     d   int20                       20i 0 const options(*nopass)

     d r               s                   like(MaxInt)
     d ia              s             20i 0 dim(20)
     d i               s             10i 0

      /free

       ia(*)  = *loval;
       ia(01) = int01;
       ia(02) = int02;
       if %parms > 2;
         ia(03) = int03;
       endif;
       if %parms >  3;
         ia(04) = int04;
       endif;
       if %parms >  4;
         ia(05) = int05;
       endif;
       if %parms >  5;
         ia(06) = int06;
       endif;
       if %parms >  6;
         ia(07) = int07;
       endif;
       if %parms >  7;
         ia(08) = int08;
       endif;
       if %parms >  8;
         ia(09) = int09;
       endif;
       if %parms >  9;
         ia(10) = int10;
       endif;
       if %parms > 10;
         ia(11) = int11;
       endif;
       if %parms > 11;
         ia(12) = int12;
       endif;
       if %parms > 12;
         ia(13) = int13;
       endif;
       if %parms > 13;
         ia(14) = int14;
       endif;
       if %parms > 14;
         ia(15) = int15;
       endif;
       if %parms > 15;
         ia(16) = int16;
       endif;
       if %parms > 16;
         ia(17) = int17;
       endif;
       if %parms > 17;
         ia(18) = int18;
       endif;
       if %parms > 18;
         ia(19) = int19;
       endif;
       if %parms > 19;
         ia(20) = int20;
       endif;

       r = *loval;

       for i = 1 to %elem(ia);
         if ia(i) > r;
           r = ia(i);
         endif;
       endfor;

       return r;

      /end-free
     p                 e


     p MinInt          b                   export
     d MinInt          pi            20i 0
     d   int01                       20i 0 const
     d   int02                       20i 0 const
     d   int03                       20i 0 const options(*nopass)
     d   int04                       20i 0 const options(*nopass)
     d   int05                       20i 0 const options(*nopass)
     d   int06                       20i 0 const options(*nopass)
     d   int07                       20i 0 const options(*nopass)
     d   int08                       20i 0 const options(*nopass)
     d   int09                       20i 0 const options(*nopass)
     d   int10                       20i 0 const options(*nopass)
     d   int11                       20i 0 const options(*nopass)
     d   int12                       20i 0 const options(*nopass)
     d   int13                       20i 0 const options(*nopass)
     d   int14                       20i 0 const options(*nopass)
     d   int15                       20i 0 const options(*nopass)
     d   int16                       20i 0 const options(*nopass)
     d   int17                       20i 0 const options(*nopass)
     d   int18                       20i 0 const options(*nopass)
     d   int19                       20i 0 const options(*nopass)
     d   int20                       20i 0 const options(*nopass)

     d r               s                   like(MinInt)
     d ia              s             20i 0 dim(20)
     d i               s             10i 0

      /free

       ia(*)  = *hival;
       ia(01) = int01;
       ia(02) = int02;
       if %parms > 2;
         ia(03) = int03;
       endif;
       if %parms >  3;
         ia(04) = int04;
       endif;
       if %parms >  4;
         ia(05) = int05;
       endif;
       if %parms >  5;
         ia(06) = int06;
       endif;
       if %parms >  6;
         ia(07) = int07;
       endif;
       if %parms >  7;
         ia(08) = int08;
       endif;
       if %parms >  8;
         ia(09) = int09;
       endif;
       if %parms >  9;
         ia(10) = int10;
       endif;
       if %parms > 10;
         ia(11) = int11;
       endif;
       if %parms > 11;
         ia(12) = int12;
       endif;
       if %parms > 12;
         ia(13) = int13;
       endif;
       if %parms > 13;
         ia(14) = int14;
       endif;
       if %parms > 14;
         ia(15) = int15;
       endif;
       if %parms > 15;
         ia(16) = int16;
       endif;
       if %parms > 16;
         ia(17) = int17;
       endif;
       if %parms > 17;
         ia(18) = int18;
       endif;
       if %parms > 18;
         ia(19) = int19;
       endif;
       if %parms > 19;
         ia(20) = int20;
       endif;

       r = *hival;

       for i = 1 to %elem(ia);
         if ia(i) < r;
           r = ia(i);
         endif;
       endfor;

       return r;

      /end-free
     p                 e


     p CondValChar     b                   export
     d CondValChar     pi          1000    varying
     d   cond                          n   const
     d   val1                      1000    const varying
     d   val2                      1000    const varying

      /free

       if cond;
         return val1;
       endif;

       return val2;

      /end-free
     p                 e


     p CondValInt      b                   export
     d CondValInt      pi            20i 0
     d   cond                          n   const
     d   int1                        20i 0 const
     d   int2                        20i 0 const

      /free

       if cond;
         return int1;
       endif;

       return int2;

      /end-free
     p                 e


     p CondValDec      b                   export
     d CondValDec      pi            30  9
     d   cond                          n   const
     d   val1                        30  9 const
     d   val2                        30  9 const

      /free

       if cond;
         return val1;
       endif;

       return val2;

      /end-free
     p                 e


     p SortBytes       b                   export
     d SortBytes       pi
     d   first                         *   const
     d   num                         10i 0 const
     d   bsize                       10i 0 const
     d   comp                          *   const options(*omit:*nopass) procptr
     d   option                      10    const options(*nopass)

     d cp              s               *   procptr

      /free

       if     %parms > 3
          and %addr(comp) <> *null;
         cp = comp;
       else;
         SortBytesBs = bsize;
         cp = %paddr(L_SortBytesDft);
       endif;

       if     %parms > 4
          and option = '*INVERSE';
          SortBytesDyn@ = cp;
          cp = %paddr(L_SortBytesInv);
       endif;

       Cqsort(first:num:bsize:cp);

      /end-free
     p                 e


     p RtvObjText      b                   export
     d RtvObjText      pi            50
     d   name                        10    const
     d   type                        10    const
     d   lib                         10    const options(*nopass)

     d qn              s             20

      /free

       if %parms > 2;
         qn = name + lib;
       else;
         qn = name + '*LIBL';
       endif;

       reset OS4Error;
       clear OS4OBJD0200;

       CallQUSROBJD(
           OS4OBJD0200:%size(OS4OBJD0200):'OBJD0200':
           qn:type:
           OS4Error);

        if    OS4Error.bavl > 0
           or OS4OBJD0200.bytesrtn <= 0;
          return '';
        endif;

        return OS4OBJD0200.objtextdescr;

      /end-free
     p                 e


     p RtvUsrPrfGrps   b                   export
     d RtvUsrPrfGrps   pi            10    dim(16)
     d   user                        10    const
     d   num                         10i 0

     d grps            s             10    dim(16)
     d i               s             10i 0
     d j               s             10i 0

      /free

       num = 0;

       reset OS4Error;
       clear OS4USRI0200;

       CallQSYRUSRI(
           OS4USRI0200:%size(OS4USRI0200):'USRI0200':
           user:
           OS4Error);

        if    OS4Error.bavl > 0
           or OS4USRI0200.bytesrtn <= 0;
          return '';
        endif;

        clear grps;

        i = 0;
        if     OS4USRI0200.grpprf <> ''
           and OS4USRI0200.grpprf <> '*NONE';
          i = i + 1;
          grps(i) = OS4USRI0200.grpprf;
        endif;
        for j = 1 to OS4USRI0200.numsuppgrps;
          if     i < %elem(grps)
             and OS4USRI0200.suppgrps(j) <> '';
            i = i + 1;
            grps(i) = %triml(OS4USRI0200.suppgrps(j));
          endif;
        endfor;

        num = i;

        return grps;

      /end-free
     p                 e


     p IsSrcPF         b                   export
     d IsSrcPF         pi              n
     d   name                        10    const
     d   lib                         10    const options(*nopass)

     d qn              s             20
     d qrn             s             20

      /free

       if %parms > 1;
         qn = name + lib;
       else;
         qn = name + '*LIBL';
       endif;

       reset OS4Error;
       clear OS4FILD0100;

       CallQDBRTVFD(
           OS4FILD0100:%size(OS4FILD0100):qrn:'FILD0100':
           qn:'*FIRST':'1':'*FILETYPE':'*EXT':
           OS4Error);

        if    OS4Error.bavl > 0
           or OS4FILD0100.bytesrtn <= 0;
          return *off;
        endif;

        return %bitand(x'08':OS4FILD0100.attr1) = x'08';

      /end-free
     p                 e


     p ExecCmd         b                   export
     d ExecCmd         pi
     d   cmd                       5000    const

      /free

       CallQCMDEXC(%trim(cmd):%len(%trim(cmd)));

      /end-free
     p                 e


     p ExecCmdCE       b                   export
     d ExecCmdCE       pi              n
     d   errmsg                     200
     d   cmd                       5000    const

     d chgcmd          s          30000    static
     d chgcmdlen       s             10i 0
     d mf              s             10
     d mi              s              3
     d ei              s                   like(OS4Error.ei)
     d ed              s                   like(OS4Error.ed)

      /free

       errmsg = '';

       reset OS4Error;
       clear OS4CPOP0100;

       OS4CPOP0100.cmdproctype  = 0;
       OS4CPOP0100.dbcshandling = '0';
       OS4CPOP0100.prompteract  = '0';
       OS4CPOP0100.cmdstrsyntax = '0';
       OS4CPOP0100.reserved01   = *allx'00';

       CallQCAPCMD(
           %trim(cmd):%len(%trim(cmd)):
           OS4CPOP0100:%size(OS4CPOP0100):'CPOP0100':
           chgcmd:%size(chgcmd):chgcmdlen:
           OS4Error);

        if OS4Error.bavl > 0;
          mf = CDftMsgf;
          mi = %subst(OS4Error.ei:1:3);
          select;
          when mi = 'RNX';
            mf = 'QRNXMSG';
          endsl;
          ei = OS4Error.ei;
          ed = OS4Error.ed;
          errmsg = RtvMsgfText(ei:ed:mf);
          return *off;
        endif;

        return *on;

      /end-free
     p                 e


     p PromptCmd       b                   export
     d PromptCmd       pi              n
     d   errmsg                     200
     d   cmd                       5000    const
     d   chgcmd                   30000

     d chgcmdlen       s             10i 0
     d mf              s             10
     d mi              s              3
     d ei              s                   like(OS4Error.ei)
     d ed              s                   like(OS4Error.ed)

      /free

       errmsg = '';
       chgcmd = cmd;

       reset OS4Error;
       clear OS4CPOP0100;

       OS4CPOP0100.cmdproctype  = 9;
       OS4CPOP0100.dbcshandling = '0';
       OS4CPOP0100.prompteract  = '1';
       OS4CPOP0100.cmdstrsyntax = '0';
       OS4CPOP0100.reserved01   = *allx'00';

       CallQCAPCMD(
           %trim(cmd):%len(%trim(cmd)):
           OS4CPOP0100:%size(OS4CPOP0100):'CPOP0100':
           chgcmd:%size(chgcmd):chgcmdlen:
           OS4Error);

        if OS4Error.bavl > 0;
          mf = CDftMsgf;
          mi = %subst(OS4Error.ei:1:3);
          select;
          when mi = 'RNX';
            mf = 'QRNXMSG';
          endsl;
          ei = OS4Error.ei;
          ed = OS4Error.ed;
          errmsg = RtvMsgfText(ei:ed:mf);
          return *off;
        endif;

        chgcmd = %subst(chgcmd:1:chgcmdlen);

        return *on;

      /end-free
     p                 e


     p RtvMsgfText     b                   export
     d RtvMsgfText     pi           500    varying
     d   msgid                        7    const
     d   repldata                   500    const options(*nopass)
     d   msgfile                     10    const options(*nopass)

     d rd              s            500
     d qmf             s             20
     d mk              s              4

      /free

       if %parms > 1;
         rd = %trim(repldata);
       else;
         rd = '';
       endif;
       if %parms > 2;
         qmf = msgfile;
       else;
         qmf = CDftMsgf;
       endif;
       %subst(qmf:11) = '*LIBL';

       reset OS4Error;
       clear OS4RTVM0100;

       CallQMHRTVM(
           OS4RTVM0100:%size(OS4RTVM0100):'RTVM0100':
           msgid:qmf:rd:%len(%trimr(rd)):
           '*YES':'*YES':
           OS4Error);

        if    OS4Error.bavl > 0
           or OS4RTVM0100.bytesrtn <= 0
           or OS4RTVM0100.msglrtn <= 0;
          return '';
        endif;

        return
            %trim(%subst(OS4RTVM0100.data:1:OS4RTVM0100.msglrtn));

      /end-free
     p                 e


     p DspStatMsg      b                   export
     d DspStatMsg      pi
     d   msg                        150    const

     d msgkey          s              4

      /free

       reset OS4Error;
       CallQMHSNDPM(
           'CPF9897' : 'QCPFMSG   *LIBL'
         : %trimr(msg) : %len(%trimr(msg))
         : '*STATUS'
         : '*EXT' : 0 : msgkey
         : OS4Error);

       return;

      /end-free
     p                 e


     p SndPgmMsg       b                   export
     d SndPgmMsg       pi
     d   msgid                        7    const
     d   filename                    10    const
     d   msgtype                     10    const options(*nopass:*omit)
     d   msgdata                    500    const options(*nopass:*omit)
     d   libname                     10    const options(*nopass:*omit)
     d   csentry                     10    const options(*nopass:*omit)
     d   cscounter                   10i 0 const options(*nopass:*omit)

     d qfn             s             20
     d mt              s                   like(msgtype)
     d md              s                   like(msgdata)
     d mdl             s             10i 0
     d cse             s                   like(csentry)
     d csc             s             10i 0
     d msgkey          s              4

      /free

       qfn = filename;
       if     %parms > 4
          and %addr(libname) <> *null;
         %subst(qfn:11) = libname;
       else;
         %subst(qfn:11) = '*LIBL';
       endif;
       if     %parms > 2
          and %addr(msgtype) <> *null;
         mt = msgtype;
       else;
         mt = '*INFO';
       endif;
       md = '';
       if    %parms > 3
          and %addr(msgdata) <> *null;
         md = msgdata;
       endif;
       if     %parms > 5
          and %addr(csentry) <> *null;
         cse = csentry;
       else;
         cse = '*CTLBDY';
       endif;
       if     %parms > 6
          and %addr(cscounter) <> *null;
         csc = cscounter;
       else;
         csc = 1;
       endif;

       reset OS4Error;
       CallQMHSNDPM(
          msgid : qfn
         : %trimr(md) : %len(%trimr(md))
         : mt : cse : csc : msgkey
         : OS4Error);

       return;

      /end-free
     p                 e


     p DataBlockAppend...
     p                 b                   export
     d DataBlockAppend...
     d                 pi
     d   id                           1  0 const
     d   data                          *   const
     d   size                        10i 0 const

     d os              s             10i 0
     d s               s             10i 0
     d l               s             10i 0
     d field1          s          30000    based(field1@)
     d field2          s          30000    based(field2@)

      /free

       if    id < 0
          or size < 1;
         return;
       endif;

       os = DataBlockSz(id+1);
       if os = 0;
         DataBlock@(id+1) = %alloc(size);
       else;
         DataBlock@(id+1) = %realloc(DataBlock@(id+1):os+size);
       endif;
       DataBlockSz(id+1) = os + size;

       field1@ = data;
       field2@ = DataBlock@(id+1) + os;
       s = size;
       dow s > 0;
         if s > 30000;
           l = 30000;
         else;
           l = s;
         endif;
         %subst(field2:1:l) = %subst(field1:1:l);
         field1@ = field1@ + l;
         field2@ = field2@ + l;
         s = s - l;
       enddo;

       return;

      /end-free
     p                 e


     p DataBlockClear  b                   export
     d DataBlockClear  pi
     d   id                           1  0 const options(*nopass)

     d i               s             10i 0

      /free

       if     %parms > 0
          and id < 0;
         return;
       endif;

       if %parms > 0;
         i = id + 1;
         exsr clear_datablock;
       else;
         for i = 1 to 10;
           exsr clear_datablock;
         endfor;
       endif;

       return;

       begsr clear_datablock;

         if DataBlockSz(i) > 0;
           dealloc(e) DataBlock@(i);
           DataBlock@(i) = *null;
           DataBlockSz(i) = 0;
         endif;

       endsr;

      /end-free
     p                 e


     p DataBlockComp   b                   export
     d DataBlockComp   pi            10i 0
     d   id1                          1  0 const
     d   id2                          1  0 const

     d field1          s          30000    based(field1@)
     d field2          s          30000    based(field2@)
     d s1              s             20i 0
     d s2              s             20i 0
     d l               s             20i 0

      /free

       if     id1 < 0
          or  id2 < 0;
         return 0;
       endif;

       s1 = DataBlockSz(id1+1);
       s2 = DataBlockSz(id2+1);

       if     s1 > 0
          and s2 > 0;
         field1@ = DataBlock@(id1+1);
         field2@ = DataBlock@(id2+1);
       endif;
       dow     s1 > 0
           and s2 > 0;
         if s1 > s2;
           l = s2;
         else;
           l = s1;
         endif;
         if l > 30000;
           l = 30000;
         endif;
         if %subst(field1:1:l) < %subst(field2:1:l);
           return -1;
         elseif %subst(field1:1:l) > %subst(field2:1:l);
           return 1;
         endif;
         field1@ = field1@ + l;
         field2@ = field2@ + l;
         s1 = s1 - l;
         s2 = s2 - l;
       enddo;

       if     s1 = 0
          and s2 = 0;
         return 0;
       elseif s1 > 0;
         return 1;
       else;
         return -1;
       endif;

      /end-free
     p                 e


     p GetBuffldId     b                   export
     d GetBuffldId     pi           999
     d   buf                           *   const
     d   id                          20    const varying

     d fld             s            999    based(fld@)
     d l               s             10i 0
     d n               s             10i 0
     d p1              s             10i 0
     d p2              s             10i 0
     d p               s             10i 0

      /free

       fld@ = buf;
       l = CvtTxtToInt(%subst(fld:1:3));
       if l < 1;
         return '';
       endif;
       n = CvtTxtToInt(%subst(fld:4:4));
       if n < 1;
         return '';
       endif;

       p1 = l;
       p2 = p1 + (n-1) * l;
       for p = p1 to p2 by l;
         fld@ = buf + p;
         if %subst(fld:1:%len(id)) = id;
           return %subst(fld:1:l);
         endif;
       endfor;

       return '';

      /end-free
     p                 e


     p CErrNoInt       b                   export
     d CErrNoInt       pi            10i 0

     d errno           s             10i 0 based(errno@)

      /free

       errno@ = CErrNoPtr();
       return errno;

      /end-free
     p                 e


     p CErrNoText      b                   export
     d CErrNoText      pi           200

     d str             s               *

      /free

       str = CErrNoCvtToStr(CErrNoInt());
       if str = *null;
         return '';
       endif;
       return %str(str);

      /end-free
     p                 e


     p CStrCrt         b                   export
     d CStrCrt         pi              *
     d   string                        *   const options(*string)

     d l               s             10i 0
     d ptr             s               *

      /free

       l = %len(%str(string));

       ptr = %alloc(l+1);

       %str(ptr:l+1) = %str(string);

       return ptr;

      /end-free
     p                 e


     p CStrBldInit     b                   export
     d CStrBldInit     pi              *
     d   chsize                      10i 0 const options(*nopass)

      /free

       CStrBldSPtr = *null;
       CStrBldSLen = 0;
       if     %parms > 0
          and chsize >= 10;
         CStrBldChunkSz = chsize;
       else;
         CStrBldChunkSz = 200;
       endif;
       CStrBldAllocSz = CStrBldChunkSz;

       CStrBldSPtr = %alloc(CStrBldAllocSz);

       %str(CStrBldSPtr:CStrBldAllocSz) = '';

       return CStrBldSPtr;

      /end-free
     p                 e


     p CStrBldAppend   b                   export
     d CStrBldAppend   pi              *
     d   string                        *   const options(*string)
     d   slen                        10i 0       options(*nopass)

     d l               s             10i 0

      /free

       if CStrBldSLen >= CMaxCStringLen;
         if %parms > 1;
           slen = CStrBldSLen;
         endif;
         return CStrBldSPtr;
       endif;

       l = CStrBldSLen + %len(%str(string));
       if l > CMaxCStringLen;
         if %parms > 1;
           slen = CStrBldSLen;
         endif;
         return CStrBldSPtr;
       endif;

       if l >= CStrBldAllocSz;
         if %rem(l+1:CStrBldChunkSz) = 0;
            CStrBldAllocSz = l + 1;
         else;
           CStrBldAllocSz = (%div(l+1:CStrBldChunkSz) + 1) * CStrBldChunkSz;
         endif;
         CStrBldSPtr = %realloc(CStrBldSPtr:CStrBldAllocSz);
       endif;

       %str(CStrBldSPtr:CStrBldAllocSz) = %str(CStrBldSPtr) + %str(string);

       CStrBldSLen = l;

       if %parms > 1;
         slen = CStrBldSLen;
       endif;

       return CStrBldSPtr;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModXX       b                   export
     dI_RlsModXX       pi

      /free

       DataBlockClear();

       close *all;

       return;

      /end-free
     p                 e


       // ----- Implementation - Local


     pL_SortBytesDft   b
     dL_SortBytesDft   pi            10i 0
     d  bytes1                         *   value
     d  bytes2                         *   value

     d fld1            s          32767    based(fld1@)
     d fld2            s          32767    based(fld2@)

      /free

       fld1@ = bytes1;
       fld2@ = bytes2;

       select;
       when %subst(fld1:1:SortBytesBs) < %subst(fld2:1:SortBytesBs);
         return -1;
       when %subst(fld1:1:SortBytesBs) > %subst(fld2:1:SortBytesBs);
         return 1;
       endsl;

       return 0;

      /end-free
     p                 e


     pL_SortBytesInv   b
     dL_SortBytesInv   pi            10i 0
     d  bytes1                         *   value
     d  bytes2                         *   value

      /free

       return L_SortBytesDyn(bytes1:bytes2) * -1;

      /end-free
     p                 e

