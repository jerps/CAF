
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module MS for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Message Support


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASEMS

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL_MS

      /include CAPPBASES,INCL__MS

      /include CAPPBASES,INCL__MODD


       // ----- Global Defs

     d DspMsg          s            130            export('DspMsg')
     d DspMsgList      s            130    dim(99) export('DspMsgList')
     d DspMsgData      s            100
     d DspMsgListData  s            100    dim(99)


       // ----- Implementation


     p IsAMsgFatal     b                   export
     d IsAMsgFatal     pi              n
     d   msg                          3    options(*varsize)

      /free

       return %subst(msg:3:1) = CAmsFatal;

      /end-free
     p                 e


     p IsAMsgWarning   b                   export
     d IsAMsgWarning   pi              n
     d   msg                          3    options(*varsize)

      /free

       return %subst(msg:3:1) = CAmsWarning;

      /end-free
     p                 e


     p IsAMsgInfo      b                   export
     d IsAMsgInfo      pi              n
     d   msg                          3    options(*varsize)

      /free

       return %subst(msg:3:1) = CAmsInfo;

      /end-free
     p                 e


     p SetAMsgFatal    b                   export
     d SetAMsgFatal    pi
     d   msg                          3    options(*varsize)

      /free

       %subst(msg:3:1) = CAmsFatal;

      /end-free
     p                 e


     p SetAMsgWarning  b                   export
     d SetAMsgWarning  pi
     d   msg                          3    options(*varsize)

      /free

       %subst(msg:3:1) = CAmsWarning;

      /end-free
     p                 e


     p SetAMsgInfo     b                   export
     d SetAMsgInfo     pi
     d   msg                          3    options(*varsize)

      /free

       %subst(msg:3:1) = CAmsInfo;

      /end-free
     p                 e


     p ClrDspMsgs      b                   export
     d ClrDspMsgs      pi

      /free

       DspMsg = '';
       DspMsgList(*) = '';
       DspMsgData = '';
       DspMsgListData(*) = '';

      /end-free
     p                 e


     p AddToDspMsgList...
     p                 b                   export
     d AddToDspMsgList...
     d                 pi             5i 0
     d   msg                        130    const
     d   data                       100    const options(*nopass)

     d i               s              5i 0

      /free

       if msg = '';
         return GetDspMsgListCount();
       endif;

       for i = 1 to %elem(DspMsgList);
         if DspMsgList(i) = '';
           DspMsgList(i) = msg;
           if %parms > 1;
             DspMsgListData(i) = data;
           else;
             DspMsgListData(i) = '';
           endif;
           return i;
         endif;
       endfor;

       return 0;

      /end-free
     p                 e


     p DropDspMsgs     b                   export
     d DropDspMsgs     pi

     d i               s              5i 0
     d j               s              5i 0

      /free

       if DspMsg <> '';
         return;
       endif;

       i = 1;
       dow     i <= %elem(DspMsgList)
           and DspMsgList(i) = '';
         i = i + 1;
       enddo;

       if i > %elem(DspMsgList);
         return;
       endif;

       DspMsg            = DspMsgList(i);
       DspMsgData        = DspMsgListData(i);
       DspMsgList(i)     = '';
       DspMsgListData(i) = '';

       for j = i + 1 to %elem(DspMsgList);
         DspMsgList(j - i)     = DspMsgList(j);
         DspMsgListData(j - i) = DspMsgListData(j);
         DspMsgList(j)         = '';
         DspMsgListData(j)     = '';
       endfor;

       return;

      /end-free
     p                 e


     p PopDspMsgs      b                   export
     d PopDspMsgs      pi

     d i               s              5i 0

      /free

       DspMsg     = DspMsgList(1);
       DspMsgData = DspMsgListData(1);

       for i = 2 to %elem(DspMsgList);
         DspMsgList(i-1)     = DspMsgList(i);
         DspMsgListData(i-1) = DspMsgListData(i);
         if DspMsgList(i) = '';
           return;
         endif;
       endfor;

       DspMsgList(%elem(DspMsgList))     = '';
       DspMsgListData(%elem(DspMsgList)) = '';

       return;

      /end-free
     p                 e


     p PushDspMsgs     b                   export
     d PushDspMsgs     pi
     d   msg                        130    const options(*nopass)

     d m               s                   like(msg)
     d n               s              5i 0
     d i               s              5i 0

      /free

       if %parms > 0;
         m = msg;
       else;
         m = '';
       endif;

       if DspMsg = '';
         DspMsg = m;
         return;
       endif;

       n = %lookup(' ':DspMsgList);
       if n = 0;
         n = %elem(DspMsgList);
       endif;

       for i = n downto 2;
         DspMsgList(i)     = DspMsgList(i-1);
         DspMsgListData(i) = DspMsgListData(i-1);
       endfor;

       DspMsgList(1)     = DspMsg;
       DspMsgListData(1) = DspMsgData;

       DspMsg     = m;
       DspMsgData = '';

       return;

      /end-free
     p                 e


     p AssocDspMsgData...
     p                 b                   export
     d AssocDspMsgData...
     d                 pi
     d   msgno                        5i 0 const
     d   data                       100    const

      /free

       if    msgno < 0
          or msgno > %elem(DspMsgList);
         return;
       endif;

       if msgno = 0;
         DspMsgData = data;
         return;
       endif;

       DspMsgListData(msgno) = data;

       return;

      /end-free
     p                 e


     p GetAssocDspMsgData...
     p                 b                   export
     d GetAssocDspMsgData...
     d                 pi           100
     d   msgno                        5i 0 const

      /free

       if    msgno < 0
          or msgno > %elem(DspMsgList);
         return ' ';
       endif;

       if msgno = 0;
         return DspMsgData;
       endif;

       return DspMsgListData(msgno);

      /end-free
     p                 e


     p GetDspMsgListCount...
     p                 b                   export
     d GetDspMsgListCount...
     d                 pi             5i 0

     d i               s              5i 0

      /free

       i = %lookup(' ':DspMsgList);
       if i = 0;
         return %elem(DspMsgList);
       endif;

       return i - 1;

      /end-free
     p                 e


     p AddDCVMsg       b                   export
     d AddDCVMsg       pi             5i 0
     d   msg                        130    const
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

     d flds            s             12    dim(7)
     d f               s             10i 0

      /free

       flds(*) = '';
       f = 0;

       if     %parms > 1
          and fld1 <> '';
         f = f + 1;
         flds(f) = fld1;
       endif;
       if     %parms > 2
          and fld2 <> '';
         f = f + 1;
         flds(f) = fld2;
       endif;
       if     %parms > 3
          and fld3 <> '';
         f = f + 1;
         flds(f) = fld3;
       endif;
       if     %parms > 4
          and fld4 <> '';
         f = f + 1;
         flds(f) = fld4;
       endif;
       if     %parms > 5
          and fld5 <> '';
         f = f + 1;
         flds(f) = fld5;
       endif;
       if     %parms > 6
          and fld6 <> '';
         f = f + 1;
         flds(f) = fld6;
       endif;
       if     %parms > 7
          and fld7 <> '';
         f = f + 1;
         flds(f) = fld7;
       endif;

       return AddDCVMsg2(msg:flds);

      /end-free
     p                 e


     p AddDCVMsg2      b                   export
     d AddDCVMsg2      pi             5i 0
     d   msg                        130    const
     d   flds                        12    const dim(7) options(*nopass)

     d data            s            100
     d i               s             10i 0

      /free

       data = '';

       for i = 1 to %elem(flds);
         if flds(i) <> '';
           %subst(data:17+(i-1)*12:12) = flds(i);
         endif;
       endfor;

       return AddToDspMsgList(msg:data);

      /end-free
     p                 e


     p AddDCVMsgQdsDs  b                   export
     d AddDCVMsgQdsDs  pi             5i 0
     d   qds                      30000          options(*varsize)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

     d fld             s             12
     d flds            s                   like(fld) dim(7)
     d f               s             10i 0
     d p               s             10i 0

      /free

       flds(*) = '';
       f = 0;
       for p = 0 to 8;
         fld = %subst(qds:203+12*p:12);
         if fld <> '';
           f = f + 1;
           flds(f) = fld;
         endif;
       endfor;
       if     %parms > 1
          and fld1 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld1;
       endif;
       if     %parms > 2
          and fld2 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld2;
       endif;
       if     %parms > 3
          and fld3 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld3;
       endif;
       if     %parms > 4
          and fld4 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld4;
       endif;
       if     %parms > 5
          and fld5 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld5;
       endif;
       if     %parms > 6
          and fld6 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld6;
       endif;
       if     %parms > 7
          and fld7 <> ''
          and f < %elem(flds);
         f = f + 1;
         flds(f) = fld7;
       endif;

       return AddDCVMsg2(%subst(qds:3:200):flds);

      /end-free
     p                 e


     p GetDCVFlds      b                   export
     d GetDCVFlds      pi             5i 0
     d   msgno                        5i 0 const
     d   flds                        12          dim(7)

     d data            s                   like(GetAssocDspMsgData)
     d f               s             12
     d n               s             10i 0
     d i               s             10i 0

      /free

       flds(*) = '';

       if msgno < 1;
         return 0;
       endif;

       data = GetAssocDspMsgData(msgno);
       n = 0;
       for i = 0 to 6;
         f = %subst(data:17 + i * %len(f):%len(f));
         if f <> '';
           n = n + 1;
           flds(n) = f;
         endif;
       endfor;

       return n;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModMS       b                   export
     dI_RlsModMS       pi

      /free

       return;

      /end-free
     p                 e

