
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module CV for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : Conversions


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASECV

      /include CSYSBASES,INCL__MODH


      /include CSYSBASES,INCL_CV
      /include CSYSBASES,INCL_XX

      /include CSYSBASES,INCL__CV

      /include CSYSBASES,INCL__MODD


       // ----- Global Defs

       // For conversions between CCSID's - i.e. procedure "CvtCCSID" - a
       // "handle" is used, which is a data structure that is intialized only
       // once using "QtqIconvOpen" for a specific combination of a source and
       // target CCSID.
       // If initialized, fields "IconvHandleS" and "IconvHandleT" are set to
       // the source/target CCSIDs.
     d IconvHandle     ds                  qualified inz
     d   rtnval                      10i 0
     d   cd                          10i 0 dim(12)
     d IconvHandleS    s             10i 0 inz(0)
     d IconvHandleT    s             10i 0 inz(0)


       // ----- Implementation


     p CvtTxtToInt     b                   export
     d CvtTxtToInt     pi            20i 0
     d   text                        30    const
     d   option                      10    const options(*nopass)

     d r               s                   like(CvtTxtToInt)
     d p               s             10i 0
     d c               s              1
     d f               s               n
     d n               s               n

      /free

       r = 0;
       f = %parms > 1 and option = '*NONEG';
       n = *off;
       for p = 1 to %len(text);
         c = %subst(text:p:1);
         select;
         when    c = '-'
             and not f;
           n = *on;
         when c = '0';
           r = r * 10;
         when c = '1';
           r = r * 10 + 1;
         when c = '2';
           r = r * 10 + 2;
         when c = '3';
           r = r * 10 + 3;
         when c = '4';
           r = r * 10 + 4;
         when c = '5';
           r = r * 10 + 5;
         when c = '6';
           r = r * 10 + 6;
         when c = '7';
           r = r * 10 + 7;
         when c = '8';
           r = r * 10 + 8;
         when c = '9';
           r = r * 10 + 9;
         endsl;
         if c <> ' ';
           f = *on;
         endif;
       endfor;

       if n;
         return 0 - r;
       endif;

       return r;

      /end-free
     p                 e


     p CvtIntToTxt     b                   export
     d CvtIntToTxt     pi            30
     d   int                         20i 0 const

     d r               s                   like(CvtintToTxt)
     d i               s             10i 0
     d p               s             10i 0
     d d               s              1  0

      /free

       if int = 0;
         return '0';
       endif;

       if int < 0;
         i = 0 - int;
       else;
         i = int;
       endif;

       r = '';
       p = %len(r);
       dow i > 0;
         d = %rem(i:10);
         %subst(r:p:1) = %editc(d:'X');
         p = p - 1;
         i = %div(i:10);
       enddo;

       if int < 0;
         return '-' + %trim(r);
       endif;

       return %trim(r);

      /end-free
     p                 e


     p CvtCCSID        b                   export
     d CvtCCSID        pi            10i 0
     d   source                   32766    const varying
     d   target                   32766          varying
     d   tccsid                      10i 0 value
     d   sccsid                      10i 0 value options(*nopass)

     d QtqIconvCCSID   ds                  qualified inz
     d   ccsid                       10i 0 inz(0)
     d   cvtalt                      10i 0 inz(0)
     d   subalt                      10i 0 inz(0)
     d   shiftstate                  10i 0 inz(0)
     d   inlenopt                    10i 0 inz(0)
     d   mixdtaerropt                10i 0 inz(0)
     d   reserved                     8    inz(*allx'00')

     d QtqIconvOpen    pr                  extproc('QtqIconvOpen')
     d                                     likeds(IconvHandle)
     d   toccsid                       *   value
     d   fromccsid                     *   value

     d Iconv           pr            10u 0 extproc('iconv')
     d   handle                            value likeds(IconvHandle)
     d   inbuff                        *   value
     d   inlen                         *   value
     d   outbuff                       *   value
     d   outlen                        *   value

     d IconvClose      pr            10i 0 extproc('iconv_close')
     d   handle                            value likeds(IconvHandle)

     d toparm          ds                  likeds(QtqIconvCCSID)
     d                                     inz(*likeds)
     d fromparm        ds                  likeds(QtqIconvCCSID)
     d                                     inz(*likeds)
     d inbuffer        s          32766    static
     d inbuffer@       s               *
     d outbuffer       s          32766    static
     d outbuffer@      s               *
     d inbytesleft     s             10u 0
     d outbytesleft    s             10u 0
     d errno           s             10i 0

      /free

       target = '';
       toparm.ccsid = tccsid;
       fromparm.ccsid = 0;
       if %parms > 3;
         fromparm.ccsid = sccsid;
       endif;
       if    IconvHandleS = 0
          or IconvHandleS <> sccsid
          or IconvHandleT <> tccsid;
         IconvHandleS = 0;
         IconvHandleT = 0;
         if IconvHandleS <> 0;
           IconvClose(IconvHandle);
         endif;
         IconvHandle = *allx'00';
         IconvHandle = QtqIconvOpen(%addr(toparm):%addr(fromparm));
         if IconvHandle.rtnval = -1;
           return CErrNoInt();
         endif;
         IconvHandleS = sccsid;
         IconvHandleT = tccsid;
       endif;
       inbuffer = source;
       inbuffer@ = %addr(inbuffer);
       outbuffer@ = %addr(outbuffer);
       inbytesleft = %len(source);
       outbytesleft = %size(outbuffer);
       Iconv(Iconvhandle:
         %addr(inbuffer@):%addr(inbytesleft):
         %addr(outbuffer@):%addr(outbytesleft));
       if inbytesleft > 0;
         return CErrNoInt();
       endif;
       target = %subst(outbuffer:1:%size(outbuffer)-outbytesleft);
       return 0;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModCV       b                   export
     dI_RlsModCV       pi

     d IconvClose      pr            10i 0 extproc('iconv_close')
     d   handle                            value likeds(IconvHandle)

      /free

       if IconvHandleS <> 0;
         IconvClose(IconvHandle);
       endif;

       return;

      /end-free
     p                 e

