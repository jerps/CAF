
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module DT for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : Date/Time functions


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASEDT

      /include CSYSBASES,INCL__MODH


     fCSYSBASEF1if   e           k disk    usropn
     fCSYSBASEF2if   e           k disk    usropn


      /include CSYSBASES,INCL_DT
      /include CSYSBASES,INCL_TU

      /include CSYSBASES,INCL__DT

      /include CSYSBASES,INCL__MODD


       // ----- Implementation


     p IsoWkdayNum     b                   export
     d IsoWkdayNum     pi            10i 0
     d   date                          d   const

     d d               s             10i 0

      /free

       d = %diff(date:d'1970-01-04':*d);

       if d < -6;
         return 7 - %rem(%abs(d) - 7 : 7);
       elseif d < 0;
         return 7 + d;
       endif;

       d = %rem(d : 7);

       if d = 0;
         return 7;
       endif;

       return d;

      /end-free
     p                 e


     p IsoWkdayName    b                   export
     d IsoWkdayName    pi            30    varying
     d   daynum                      10i 0 const
     d   option                      10    const options(*nopass)

     d r               s                   like(IsoWkdayName)

      /free

       r = '';

       if     %parms > 1
          and (   option = '*SHORT'
               or option = '*SHORTC');
         select;
         when daynum = 1;
           r = 'mon';
         when daynum = 2;
           r = 'tue';
         when daynum = 3;
           r = 'wed';
         when daynum = 4;
           r = 'thu';
         when daynum = 5;
           r = 'fri';
         when daynum = 6;
           r = 'sat';
         when daynum = 7;
           r = 'sun';
         endsl;
       else;
         select;
         when daynum = 1;
           r = 'monday';
         when daynum = 2;
           r = 'tuesday';
         when daynum = 3;
           r = 'wednesday';
         when daynum = 4;
           r = 'thursday';
         when daynum = 5;
           r = 'friday';
         when daynum = 6;
           r = 'saturday';
         when daynum = 7;
           r = 'sunday';
         endsl;
       endif;

       if r = '';
         return '';
       endif;

       if     %parms > 1
          and (   option = '*CAPITAL'
               or option = '*SHORTC');
         r = ToUppercase(%subst(r:1:1)) + %subst(r:2);
       endif;

       return r;

      /end-free
     p                 e


     p IsoWeekNum      b                   export
     d IsoWeekNum      pi            10i 0
     d   date                          d   const

     d y               s             10i 0
     d m               s             10i 0
     d d               s             10i 0
     d w1              s             10i 0
     d w2              s             10i 0
     d wd1             s             10i 0
     d wd2             s             10i 0
     d wd3             s             10i 0
     d wd4             s             10i 0
     d wd5             s             10i 0

      /free

       // http://nl.wikipedia.org/wiki/Weeknummer  --------------------

       y = %subdt(date:*y);

       if    y < 2
          or y > 9998;
         return 0;
       endif;

       m = %subdt(date:*m);
       d = %subdt(date:*d);

       w1 = %div(%diff(date:%date(y*10000+104:*iso):*d):7);     // UK02

       wd1 = IsoWkdayNum(date);                                 // UK03
       wd2 = IsoWkdayNum(%date((y-1)*10000+104:*iso));          // UK04

       w2 = %div(%diff(%date((y-1)*10000+1231:*iso)             // UK06
                      :%date((y-1)*10000+104:*iso):*d)
                :7);

       wd3 = IsoWkdayNum(%date((y-1)*10000+1231:*iso));         // UK07
       wd4 = IsoWkdayNum(%date(y*10000+104:*iso));              // UK08
       wd5 = IsoWkdayNum(%date((y+1)*10000+104:*iso));          // UK09

       if     m = 1                                             // UK11
          and d >= 1
          and d <= 3;
         if wd1 < wd4;
           return 1;
         else;
           if wd3 < wd4;                                        // UK10
             return 1;
           elseif wd3 < wd2;
             return w2 + 2;
           endif;
           return w2 + 1;
         endif;
       elseif     m = 12
              and d >= 29
              and d <= 31
              and wd1 < wd5;
         return 1;
       elseif wd1 < wd4;
         return w1 + 2;
       endif;

       return w1 + 1;

      /end-free
     p                 e


     p IsoLastWeekNum  b                   export
     d IsoLastWeekNum  pi            10i 0
     d   yyyy                        10i 0 const

     d d               s             10i 0

      /free

       if    yyyy < 2
          or yyyy > 9998;
         return 0;
       endif;

       return IsoWeekNum(%date(yyyy*10000+1228:*iso));

      /end-free
     p                 e


     p MonthName       b                   export
     d MonthName       pi            30    varying
     d   month                       10i 0 const
     d   option                      10    const options(*nopass)

     d r               s                   like(MonthName)

      /free

       r = '';

       if     %parms > 1
          and (   option = '*SHORT'
               or option = '*SHORTC');
         select;
         when month = 1;
           r = 'jan';
         when month = 2;
           r = 'feb';
         when month = 3;
           r = 'mar';
         when month = 4;
           r = 'apr';
         when month = 5;
           r = 'may';
         when month = 6;
           r = 'jun';
         when month = 7;
           r = 'jul';
         when month = 8;
           r = 'aug';
         when month = 9;
           r = 'sep';
         when month = 10;
           r = 'oct';
         when month = 11;
           r = 'nov';
         when month = 12;
           r = 'dec';
         endsl;
       else;
         select;
         when month = 1;
           r = 'january';
         when month = 2;
           r = 'february';
         when month = 3;
           r = 'march';
         when month = 4;
           r = 'april';
         when month = 5;
           r = 'may';
         when month = 6;
           r = 'june';
         when month = 7;
           r = 'july';
         when month = 8;
           r = 'august';
         when month = 9;
           r = 'september';
         when month = 10;
           r = 'october';
         when month = 11;
           r = 'november';
         when month = 12;
           r = 'december';
         endsl;
       endif;

       if r = '';
         return '';
       endif;

       if     %parms > 1
          and (   option = '*CAPITAL'
               or option = '*SHORTC');
         r = ToUppercase(%subst(r:1:1)) + %subst(r:2);
       endif;

       return r;

      /end-free
     p                 e


     p Gdt2Wdt         b                   export
     d Gdt2Wdt         pi             7  0
     d   gdate                         d   const

     d                 ds
     d wd                             7  0
     d   wdy                          4  0 overlay(wd)
     d   wdw                          2  0 overlay(wd:*next)
     d   wdd                          1  0 overlay(wd:*next)

      /free

       wdy = %subdt(gdate:*y);

       if    wdy < 2
          or wdy > 9998;
         return 0;
       endif;

       wdw = IsoWeekNum(gdate);
       wdd = IsoWkdayNum(gdate);

       if     %subdt(gdate:*m) = 1
          and wdw > 51;
         wdy = wdy - 1;
       elseif     %subdt(gdate:*m) = 12
              and %subdt(gdate:*d) > 28;
         wdy = wdy + 1;
       endif;

       return wd;

      /end-free
     p                 e


     p Gdt2IsoNum      b                   export
     d Gdt2IsoNum      pi             8  0
     d   gdate                         d   const

      /free

       return   %subdt(gdate:*y) * 10000
              + %subdt(gdate:*m) * 100
              + %subdt(gdate:*d);

      /end-free
     p                 e


     p Wdt2Gdt         b                   export
     d Wdt2Gdt         pi              d
     d   wdate                        7  0 const

     d                 ds
     d wd                             7  0
     d   wdy                          4  0 overlay(wd)
     d   wdw                          2  0 overlay(wd:*next)
     d   wdd                          1  0 overlay(wd:*next)
     d gd              s               d
     d w               s             10i 0
     d d               s             10i 0

      /free

       wd = wdate;

       if    wdy < 1
          or wdy > 9999
          or wdw < 1
          or wdw > IsoLastWeekNum(wdy)
          or wdd < 1
          or wdd > 7;
         return *loval;
       endif;

       gd = %date(wdy*10000+104:*iso);

       return gd + %days(
           wdd - IsoWkdayNum(gd) + (wdw - 1) * 7);

      /end-free
     p                 e


     p IsValidGdt      b                   export
     d IsValidGdt      pi              n
     d   yyyy                        10i 0 const
     d   mm                          10i 0 const
     d   dd                          10i 0 const

     d dt              s              8  0

      /free

       if    yyyy < 1
          or yyyy > 9999
          or mm < 1
          or mm > 12
          or dd < 1
          or dd > 31;
         return *off;
       endif;

       return IsValidGdt1(yyyy*10000 + mm*100 + dd);

      /end-free
     p                 e


     p IsValidGdt1     b                   export
     d IsValidGdt1     pi              n
     d   yyyymmdd                    10i 0 const

     d dt              s              8  0

      /free

       if    yyyymmdd < 00010101
          or yyyymmdd > 99991231;
         return *off;
       endif;

       dt = yyyymmdd;
       test(de) *iso dt;

       return not %error;

      /end-free
     p                 e


     p IsValidGdt2     b                   export
     d IsValidGdt2     pi              n
     d   yymmdd                      10i 0 const

     d dt              s              6  0

      /free

       if    yymmdd < 010101
          or yymmdd > 991231;
         return *off;
       endif;

       dt = yymmdd;
       test(de) *ymd dt;

       return not %error;

      /end-free
     p                 e


     p IsValidWdt      b                   export
     d IsValidWdt      pi              n
     d   yyyy                        10i 0 const
     d   ww                          10i 0 const
     d   d                           10i 0 const

      /free

       return     yyyy >= 1
              and yyyy <= 9999
              and ww >= 1
              and ww <= IsoLastWeekNum(yyyy)
              and d >= 1
              and d <= 7;

      /end-free
     p                 e


     p IsValidWdt1     b                   export
     d IsValidWdt1     pi              n
     d   wdate                        7  0 const

     d                 ds
     d wdt                            7  0
     d   yyyy                         4  0 overlay(wdt)
     d   ww                           2  0 overlay(wdt:*next)
     d   d                            1  0 overlay(wdt:*next)

      /free

       wdt = wdate;

       return IsValidWdt(yyyy:ww:d);

      /end-free
     p                 e


     p MakeGdt         b                   export
     d MakeGdt         pi              d
     d   yyyy                        10i 0 const
     d   mm                          10i 0 const
     d   dd                          10i 0 const

     d dt              s              8  0

      /free

       if    yyyy < 1
          or yyyy > 9999
          or mm < 1
          or mm > 12
          or dd < 1
          or dd > 31;
         return *loval;
       endif;

       dt = yyyy * 10000 + mm * 100 + dd;

       test(de) *iso dt;
       if %error;
         return *loval;
       endif;

       return %date(dt:*iso);

      /end-free
     p                 e


     p MakeGdt1        b                   export
     d MakeGdt1        pi              d
     d   yyyymmdd                    20i 0 const

     d dt              s              8  0

      /free

       if    yyyymmdd < 10101
          or yyyymmdd > 99991231;
         return *loval;
       endif;

       dt = yyyymmdd;

       test(de) *iso dt;
       if %error;
         return *loval;
       endif;

       return %date(yyyymmdd:*iso);

      /end-free
     p                 e


     p SplitGdt        b                   export
     d SplitGdt        pi
     d   gdt                           d   const
     d   yyyy                        10i 0       options(*nopass:*omit)
     d   mm                          10i 0       options(*nopass:*omit)
     d   dd                          10i 0       options(*nopass:*omit)

      /free

       if     %parms > 1
          and %addr(yyyy) <> *null;
         yyyy = %subdt(gdt:*y);
       endif;
       if     %parms > 2
          and %addr(mm) <> *null;
         mm = %subdt(gdt:*m);
       endif;
       if     %parms > 3
          and %addr(dd) <> *null;
         dd = %subdt(gdt:*d);
       endif;

      /end-free
     p                 e


     p MakeWdt         b                   export
     d MakeWdt         pi             7  0
     d   yyyy                        10i 0 const
     d   ww                          10i 0 const
     d   d                           10i 0 const

      /free

       if    yyyy < 1
          or yyyy > 9999
          or ww < 1
          or ww > 53
          or d < 1
          or d > 7;
         return 0;
       endif;

       return yyyy * 1000 + ww * 10 + d;

      /end-free
     p                 e


     p MakeWdt1        b                   export
     d MakeWdt1        pi             7  0
     d   cc                          10i 0 const
     d   yyww                        10i 0 const
     d   d                           10i 0 const

      /free

       if    cc < 0
          or cc > 99
          or yyww < 0
          or yyww > 9953
          or d < 1
          or d > 7;
         return 0;
       endif;

       return cc * 100000 + yyww * 10 + d;

      /end-free
     p                 e


     p MakeWdt2        b                   export
     d MakeWdt2        pi             7  0
     d   cc                          10i 0 const
     d   yy                          10i 0 const
     d   ww                          10i 0 const
     d   d                           10i 0 const

      /free

       if    cc < 0
          or cc > 99
          or yy < 0
          or yy > 99
          or ww < 1
          or ww > 53
          or d < 1
          or d > 7;
         return 0;
       endif;

       return cc * 100000 + yy * 1000 + ww * 10 + d;

      /end-free
     p                 e


     p MakeWdt3        b                   export
     d MakeWdt3        pi             7  0
     d   yyww                        10i 0 const
     d   d                           10i 0 const

      /free

       if    yyww < 0
          or yyww > 9953
          or d < 1
          or d > 7;
         return 0;
       endif;

       return MakeWdt(YY2YYYY(%div(yyww:100)):%rem(yyww:100):d);

      /end-free
     p                 e


     p SplitWdt        b                   export
     d SplitWdt        pi
     d   wdt                          7  0 const
     d   yyyy                        10i 0       options(*nopass:*omit)
     d   ww                          10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

     d                 ds
     d wdt_                           7  0
     d   wdt_yyyy                     4  0 overlay(wdt_)
     d   wdt_ww                       2  0 overlay(wdt_:*next)
     d   wdt_d                        1  0 overlay(wdt_:*next)

      /free

       wdt_ = wdt;

       if     %parms > 1
          and %addr(yyyy) <> *null;
         yyyy = wdt_yyyy;
       endif;
       if     %parms > 2
          and %addr(ww) <> *null;
         ww = wdt_ww;
       endif;
       if     %parms > 3
          and %addr(d) <> *null;
         d = wdt_d;
       endif;

      /end-free
     p                 e


     p SplitWdt1       b                   export
     d SplitWdt1       pi
     d   wdt                          7  0 const
     d   cc                          10i 0       options(*nopass:*omit)
     d   yyww                        10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

     d                 ds
     d wdt_                           7  0
     d   wdt_cc                       2  0 overlay(wdt_)
     d   wdt_yyww                     4  0 overlay(wdt_:*next)
     d   wdt_d                        1  0 overlay(wdt_:*next)

      /free

       wdt_ = wdt;

       if     %parms > 1
          and %addr(cc) <> *null;
         cc = wdt_cc;
       endif;
       if     %parms > 2
          and %addr(yyww) <> *null;
         yyww = wdt_yyww;
       endif;
       if     %parms > 3
          and %addr(d) <> *null;
         d = wdt_d;
       endif;

      /end-free
     p                 e


     p SplitWdt2       b                   export
     d SplitWdt2       pi
     d   wdt                          7  0 const
     d   cc                          10i 0       options(*nopass:*omit)
     d   yy                          10i 0       options(*nopass:*omit)
     d   ww                          10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

     d                 ds
     d wdt_                           7  0
     d   wdt_cc                       2  0 overlay(wdt_)
     d   wdt_yy                       2  0 overlay(wdt_:*next)
     d   wdt_ww                       2  0 overlay(wdt_:*next)
     d   wdt_d                        1  0 overlay(wdt_:*next)

      /free

       wdt_ = wdt;

       if     %parms > 1
          and %addr(cc) <> *null;
         cc = wdt_cc;
       endif;
       if     %parms > 2
          and %addr(yy) <> *null;
         yy = wdt_yy;
       endif;
       if     %parms > 3
          and %addr(ww) <> *null;
         ww = wdt_ww;
       endif;
       if     %parms > 4
          and %addr(d) <> *null;
         d = wdt_d;
       endif;

      /end-free
     p                 e


     p SplitWdt3       b                   export
     d SplitWdt3       pi
     d   wdt                          7  0 const
     d   yyww                        10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

     d                 ds
     d wdt_                           7  0
     d   wdt_cc                       2  0 overlay(wdt_)
     d   wdt_yyww                     4  0 overlay(wdt_:*next)
     d   wdt_d                        1  0 overlay(wdt_:*next)

      /free

       wdt_ = wdt;

       if     %parms > 1
          and %addr(yyww) <> *null;
         yyww = wdt_yyww;
       endif;
       if     %parms > 2
          and %addr(d) <> *null;
         d = wdt_d;
       endif;

      /end-free
     p                 e


     p IsLeapYear      b                   export
     d IsLeapYear      pi              n
     d   yyyy                        10i 0 const

      /free

       if     yyyy < 1
          and yyyy > 9999;
         return *off;
       endif;

       if %rem(yyyy:100) = 0;
         return *off;
       endif;

       if %rem(yyyy:4) > 0;
         return *off;
       endif;

       if %rem(yyyy:400) = 0;
         return *on;
       endif;

       return *on;

      /end-free
     p                 e


     p YY2YYYY         b                   export
     d YY2YYYY         pi             4  0
     d   yy                           2  0 const

      /free

       if yy <= %rem(CCutoffYear:100);
         return %div(CCutoffYear:100) * 100 + yy;
       endif;

       return (%div(CCutoffYear:100) - 1) * 100 + yy;

      /end-free
     p                 e


     p CrtTimestamp9   b                   export
     d CrtTimestamp9   pi             9  0

     d ts              s               z

      /free

       ts = %timestamp;

       return   %subdt(ts:*h) * 10000000
              + %subdt(ts:*m) * 100000
              + %subdt(ts:*s) * 1000
              + %div(%subdt(ts:*ms):1000);

      /end-free
     p                 e


     p IsWorkday       b                   export
     d IsWorkday       pi              n
     d   date                          d   const options(*nopass:*omit)
     d   wkdate                       7  0 const options(*nopass:*omit)

     d t               s                   like(RtvNwdType)

      /free

       if    %parms < 1
          or     %addr(date) = *null
             and (   %parms < 2
                  or %addr(wkdate) = *null);
         return *off;
       endif;

       if    %parms < 2
          or %addr(wkdate) = *null;
         t = RtvNwdType(date);
       elseif %addr(date) = *null;
         t = RtvNwdType(*omit:wkdate);
       else;
         t = RtvNwdType(date:wkdate);
       endif;

       return    t = ''
              or t = CNwdtWrkdayCode;

      /end-free
     p                 e


     p AddWorkdays     b                   export
     d AddWorkdays     pi              d
     d   date                          d   const
     d   days                        10i 0 const
     d   s1                          10i 0 const options(*nopass)
     d   s2                          10i 0 const options(*nopass)
     d   s3                          10i 0 const options(*nopass)
     d   s4                          10i 0 const options(*nopass)
     d   s5                          10i 0 const options(*nopass)
     d   s6                          10i 0 const options(*nopass)

     d snwd            s               n
     d addd            s               n
     d dg              s               d
     d                 ds
     d dw                             7  0
     d   dwy                          4  0 overlay(dw)
     d   dww                          2  0 overlay(dw:*next)
     d   dwd                          1  0 overlay(dw:*next)
     d lw              s             10i 0
     d n               s             10i 0

      /free

       if    days = 0
          or %subdt(date:*y) < 2
          or %subdt(date:*y) > 9998;
         return date;
       endif;

       // Skip non-workdays?
       snwd = %parms < 3;

       // Add (or subtract) days?
       addd = days > 0;

       dg = date;
       dw = Gdt2Wdt(date);

       if addd;
         lw = IsoLastWeekNum(dwy);
       endif;

       n = %abs(days);
       dow     n > 0
           and (       addd and dg < *hival
                or not addd and dg > *loval);

         if addd;
           dg = dg + %days(1);
           if dwd < 7;
             dwd = dwd + 1;
           elseif dww < lw;
             dww = dww + 1;
             dwd = 1;
           elseif dwy < 9998;
             dwy = dwy + 1;
             dww = 1;
             dwd = 1;
             lw = IsoLastWeekNum(dwy);
           else;
             return dg;
           endif;
         else;
           dg = dg - %days(1);
           if dwd > 1;
             dwd = dwd - 1;
           elseif dww > 1;
             dww = dww - 1;
             dwd = 7;
           elseif dwy > 2;
             dwy = dwy - 1;
             dww = IsoLastWeekNum(dwy);
             dwd = 7;
           else;
             return dg;
           endif;
         endif;

         if     (   not snwd
                 or IsWorkday(dg:dw))
            and (   %parms < 3
                 or dwd <> s1)
            and (   %parms < 4
                 or dwd <> s2)
            and (   %parms < 5
                 or dwd <> s3)
            and (   %parms < 6
                 or dwd <> s4)
            and (   %parms < 7
                 or dwd <> s5)
            and (   %parms < 8
                 or dwd <> s6);
           n = n - 1;
         endif;

       enddo;

       return dg;

      /end-free
     p                 e


     p GetNwdtName     b                   export
     d GetNwdtName     pi            50
     d   nwdt                         1    const

      /free

       if nwdt = '';
         return '';
       endif;

       if nwdt = CNwdtWrkdayCode;
         return CNwdtWrkdayName;
       endif;

       if not %open(CSYSBASEF1);
         open CSYSBASEF1;
       endif;

       NWDTCODE = nwdt;
       chain (NWDTCODE) CSYSBASEF1;
       if %found;
         return NWDTNAME;
       endif;

       return '';

      /end-free
     p                 e


     p RtvNwdType      b                   export
     d RtvNwdType      pi             1
     d   date                          d   const options(*nopass:*omit)
     d   wkdate                       7  0 const options(*nopass:*omit)

       // Storage initialized?
     d si              s               n   static inz(*off)

       // The nwd types of the records in CSYSBASEF2 are accessed through
       // array "yy". Each element points to an instance of data structure
       // "yt" which contains the nwd types of one year. Array "yy" has 101
       // elements. The nwd types in the records where NWDYEAR is 0000 are
       // stored in an instance of "yt" pointed to by element 1 of "yy". The
       // nwd types for NWDYEAR '00 (any century) are accessed via element 2,
       // NWDYEAR '01 is accessed via element 3, etc. Thus, a maximum of 100
       // years ('00 - '99, not counting year 0000) can be stored in memory
       // at once. The records for a year are only loaded when needed.
       // The index into "yy" is equal to the last two digits of the (4-digit)
       // year of which the referenced instance of "yt" contains the nwd types,
       // plus 2. Thus, the nwd types of year 2010 are contained in the "yt"
       // instance pointed to by element 12 and the nwd types of year 2011 are
       // accessed via element 13. If the next year to be accessed is the year
       // 1911, the instance of "yt" to which element 13 points (containing the
       // nwd types of year 2011) will be replaced with a new instance which
       // contains the nwd types of year 1911. The nwd types for year 0000
       // (accessed via element 1 of "yy") are read only once.
       // Subfield "y" in "yt" contains the 4-digit year.
     d yy              s               *   static dim(101)
     d yt              ds                  qualified based(yt@)
         // The 4-digit year.
     d   y                           10i 0
         // Arrays "w" and "g" both contain the nwd types of the records in
         // CSYSBASEF2 for year "y". Each element represents one specific day
         // in a full year and is either blank (the day is a workday) or it
         // contains the nwd type for that day. Array "w" contains the nwd
         // types of all records that specify a week date (ww-d, NWDDNUM > 0).
         // It has 378 (54*7) elements for 54 weeks (0-53) and 7 days. Array
         // "g" contains the nwd types of all records that specify a gregorian
         // date (mm-dd, NWDDAY > 0). It has 403 (13*31) elements for 13 months
         // (0-12) and 31 days.
     d   w                                 like(NWDTYPE) dim(378)
     d   g                                 like(NWDTYPE) dim(403)

       // Parameter: week date "pdatew".
     d                 ds
     d pdatew                         7  0
     d   pdatewy                      4  0 overlay(pdatew)
     d   pdateww                      2  0 overlay(pdatew:*next)
     d   pdatewd                      1  0 overlay(pdatew:*next)

       // Parameter: gregorian date ("pdateg").
     d pdateg          s               d
     d pdategy         s             10i 0
     d pdategm         s             10i 0
     d pdategd         s             10i 0

     d t               s                   like(NWDTYPE)
     d y               s             10i 0
     d i               s             10i 0

      /free

       // Read parameters.
       pdatew = 0;
       pdateg = *loval;
       if     %parms > 0
          and %addr(date) <> *null;
         pdateg = date;
       endif;
       if     %parms > 1
          and %addr(wkdate) <> *null;
         pdatew = wkdate;
       endif;

       if     pdatew < 1
          and pdateg = *loval;
         // Release (initialize) storage and return immediately.
         exsr inits;
         return '';
       endif;

       // Calculate gregorian or week date if not provided.
       if pdatew < 1;
         pdatew = Gdt2Wdt(pdateg);
         if pdatew = 0;
           return '';
         endif;
       elseif pdateg = *loval;
         pdateg = Wdt2Gdt(pdatew);
       endif;

       pdategy = %subdt(pdateg:*y);
       pdategm = %subdt(pdateg:*m);
       pdategd = %subdt(pdateg:*d);

       if not si;
         // Initialize storage.
         si = *on;
         exsr inits;
       endif;

       // Determine the nwd type ("t") for "pdatew".
       t = '';
       // Load year "pdatewy".
       y = pdatewy;
       exsr load_yt;
       // Get the nwd type for this specific year and week.
       t = yt.w(pdateww*7+pdatewd);
       if t = '';
         // No nwd type found; determine the nwd type for "pdateg".
         // Load year "pdategy".
         y = pdategy;
         exsr load_yt;
         // Get the nwd type for this specific year and month.
         t = yt.g(pdategm*31+pdategd);
       endif;
       if t = '';
         // No nwd type found yet; try week 0 in this specific year.
         y = pdatewy;
         exsr load_yt;
         t = yt.w(pdatewd);
       endif;
       if t = '';
         // No nwd type found yet; try month 0 in this specific year.
         y = pdategy;
         exsr load_yt;
         t = yt.g(pdategd);
       endif;
       if t = '';
         // No nwd type found yet; try this specific week in year 0.
         y = 0;
         exsr load_yt;
         t = yt.w(pdateww*7+pdatewd);
       endif;
       if t = '';
         // No nwd type found yet; try this specific month in year 0.
         t = yt.g(pdategm*31+pdategd);
       endif;
       if t = '';
         // No nwd type found yet; try week 0 in year 0.
         t = yt.w(pdatewd);
       endif;
       if t = '';
         // No nwd type found yet; try month 0 in year 0.
         t = yt.g(pdategd);
       endif;

       return t;

       // Initialize/release existing storage.
       begsr inits;
         for i = 1 to %elem(yy);
           if yy(i) <> *null;
             dealloc(e) yy(i);
             yy(i) = *null;
           endif;
         endfor;
       endsr;

       // Ensure that "yt@" points to the instance of "yt" containing the
       // nwd types of year "y". First, check if year "y" is already loaded.
       // If not, create a new instance of "yt", load the nwd types of year
       // "y" into it (by reading all records in CSYSBASEF2 where NWDYEAR is
       // equal to "y"), and set the corresponding element of "yy" to point
       // to this new instance. If the element of "yy" already points to an
       // instance of "yt" and "yt.y" is not equal to "y" then release this
       // instance first. Do nothing if "yt.y" is equal to "y" (i.e. year
       // "y" is already loaded).
       begsr load_yt;
         if y = 0;
           i = 1;
         else;
           i = %rem(y:100) + 2;
         endif;
         yt@ = yy(i);
         if yt@ <> *null;
           if yt.y = y;
             // Year "y" is already loaded.
             leavesr;
           endif;
           dealloc(e) yt@;
         endif;
         if not %open(CSYSBASEF2);
           open CSYSBASEF2;
         endif;
         yt@ = %alloc(%size(yt));
         clear yt;
         yt.y = y;
         yt.w(*) = '';
         yt.g(*) = '';
         NWDYEAR = y;
         setll (NWDYEAR) CSYSBASEF2;
         reade (NWDYEAR) CSYSBASEF2;
         dow not %eof;
           if NWDDNUM > 0;
             yt.w(NWDWEEK*7+NWDDNUM) = NWDTYPE;
           elseif NWDDAY > 0;
             yt.g(NWDMONTH*31+NWDDAY) = NWDTYPE;
           endif;
           reade (NWDYEAR) CSYSBASEF2;
         enddo;
         yy(i) = yt@;
         if %open(CSYSBASEF2);
           close CSYSBASEF2;
         endif;
       endsr;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModDT       b                   export
     dI_RlsModDT       pi

      /free

       RtvNwdType();

       close(e) *ALL;

       return;

      /end-free
     p                 e

