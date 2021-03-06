
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module PT for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Presentation Texts


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASEPT

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL_PT
      /include CAPPBASES,INCL_AM
      /include CAPPBASES,INCL_XX

      /include CAPPBASES,INCL__PT

      /include CAPPBASES,INCL__MODD


       // ---- Implementation


     p PtNumber        b                   export
     d PtNumber        pi            30    varying
     d   number                      30  9 const
     d   dec                          1  0 const options(*nopass)
     d   fmtopt                      10    const options(*nopass)
     d   wnd                          2  0 const options(*nopass)

     d r               s                   like(PtNumber)
     d nogrpsep        s               n
     d nozero          s               n
     d minright        s               n
     d neg             s               n
     d num             s             30  0
     d rem             s             30  0
     d dc              s             10i 0
     d nc              s             10i 0
     d gc              s             10i 0
     d df              s               n
     d nf              s               n

      /free

       if     %parms > 3
          and dec = 0
          and wnd = 0;
         return '';
       endif;

       if number < 0;
         neg = *on;
         num = 0 - number * 10 ** 9;
       else;
         neg = *off;
         num = number * 10 ** 9;
       endif;

       if %parms > 1;
         if dec < 0;
           dc  = 0 - dec;
           df = *off;
         else;
           dc = dec;
           df = *on;
         endif;
       else;
         dc = 0;
         df = *on;
       endif;

       nogrpsep = *off;
       nozero   = *off;
       minright = *off;
       if %parms > 2;
         nogrpsep = %scan('g':fmtopt) > 0;
         nozero   = %scan('z':fmtopt) > 0;
         minright = %scan('R':fmtopt) > 0;
       endif;

       if     nozero
          and number = 0;
         return '';
       endif;

       if %parms > 3;
         if wnd < 0;
           nc  = 0 - wnd;
           nf = *off;
         else;
           nc = wnd;
           nf = *on;
         endif;
       else;
         nc = 99;
         nf = *off;
       endif;

       r = '';
       rem = 10 ** (9 - dc);
       num = %div(num:rem);
       gc = 3;
       dow        num > 0
              and nc > 0
           or     nf
              and nc > 0
           or dc > 0;
         if     gc = 0
            and not nogrpsep;
           r = NumSepGrp() + r;
           gc = 3;
         endif;
         rem = %rem(num:10);
         num = %div(num:10);
         if    rem > 0
            or df;
           df = *on;
           r = %char(rem) + r;
         endif;
         if dc > 0;
           dc = dc - 1;
           if dc = 0;
             if df;
               r = NumSepDec() + r;
             endif;
             df = *on;
           endif;
         else;
           nc = nc - 1;
           gc = gc - 1;
         endif;
       enddo;

       if     nc > 0
          and (   %len(r) = 0
               or %subst(r:1:1) = NumSepDec());
         r = '0' + r;
       endif;

       if neg;
         if minright;
           r = r + '-';
         else;
           r = '-' + r;
         endif;
       elseif minright;
         r = r + ' ';
       endif;

       return r;

      /end-free
     p                 e


     p PtWeekdate      b                   export
     d PtWeekdate      pi             8
     d   wdate                        7  0 const
     d   option                      10    const options(*nopass)

     d                 ds
     d ccyywwd                 1      7  0
     d   cc                    1      2  0
     d   yy                    3      4  0
     d   ww                    5      6  0
     d   d                     7      7  0

      /free

       ccyywwd = wdate;

       if     %parms > 1
          and option = '*YYWW';
         return %editc(yy:'X') +
                %editc(ww:'X') + '-' +
                %char(d);
       endif;

       return %editc(cc:'X') +
              %editc(yy:'X') +
              %editc(ww:'X') + '-' +
              %char(d);

      /end-free
     p                 e


     p PtWeekdate2     b                   export
     d PtWeekdate2     pi             8
     d   week                         5  0 const
     d   day                          1  0 const
     d   option                      10    const options(*nopass)

     d                 ds
     d cyyww                   1      5  0
     d   c                     1      1  0
     d   yy                    2      3  0
     d   ww                    4      5  0
     d cc              s             10i 0

      /free

       cyyww = week;

       cc = 19 + c;

       if     %parms > 2
          and option = '*YYWW';
         return %editc(yy:'X') +
                %editc(ww:'X') + '-' +
                %char(day);
       endif;

       return %editc(cc:'X') +
              %editc(yy:'X') +
              %editc(ww:'X') + '-' +
              %char(day);

      /end-free
     p                 e


     p PtDate          b                   export
     d PtDate          pi             8
     d   date                          d   const

     d yy              s              2  0
     d mm              s              2  0
     d dd              s              2  0

      /free

       yy = %rem(%subdt(date:*y):100);
       mm = %subdt(date:*m);
       dd = %subdt(date:*d);

       return %editc(yy:'X') + '-' +
              %editc(mm:'X') + '-' +
              %editc(dd:'X') + '-';

      /end-free
     p                 e


     p PtDateNI        b                   export
     d PtDateNI        pi             8
     d   date                         8  0 const

      /free

       test(de) *iso date;
       if %error;
         return '?';
       endif;
       return PtDate(%date(date:*iso));

      /end-free
     p                 e


     p PtTime          b                   export
     d PtTime          pi             8
     d   time                          t   const
     d   option                      10    const options(*nopass)

     d r               s              8    varying
     d hh              s              2  0
     d mm              s              2  0
     d ss              s              2  0

      /free

       r = '';

       hh = %subdt(time:*h);
       mm = %subdt(time:*mn);

       if hh > 9;
         r = %char(hh);
       else;
         r = ' ' + %char(hh);
       endif;

       r = r + ':' + %editc(mm:'X');

       if    %parms < 2
          or option <> '*HM';
         ss = %subdt(time:*s);
         r = r + ':' + %editc(ss:'X');
       endif;

       return r;

      /end-free
     p                 e


     p PtPgmRtncd      b                   export
     d PtPgmRtncd      pi           100
     d   rtncd                        2  0 const

      /free

       return %subst(RtvAMsgAB(2500 + rtncd):10);

      /end-free
     p                 e


     p PtPgmResult     b                   export
     d PtPgmResult     pi           200
     d   rtncd                        2  0 const
     d   rtnmsg1                    100    const
     d   rtnmsg2                    100    const
     d   rcmsg                      100    const options(*nopass)

     d rm              s            110

      /free

       if %parms > 3;
         rm = rcmsg;
       else;
         rm = %trim(PtPgmRtncd(rtncd));
         if rm = '';
           rm = 'Unknown return code.';
         endif;
         rm = %editc(rtncd:'X') + ': ' + rm;
       endif;

       return %trim(rm) + ' ' + %trim(rtnmsg1) + ' ' + %trim(rtnmsg2);

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModPT       b                   export
     dI_RlsModPT       pi

      /free

       return;

      /end-free
     p                 e

