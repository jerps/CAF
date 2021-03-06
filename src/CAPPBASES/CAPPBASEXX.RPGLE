
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module XX for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Miscellaneous


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASEXX

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL_XX
      /include CSYSBASES,INCL_API

      /include CAPPBASES,INCL__XX

      /include CAPPBASES,INCL__MODD


       // ----- Implementation


     p NumSepDec       b                   export
     d NumSepDec       pi             1
     d   sep                          1    const options(*nopass)

     d s               s              1    static
     d f               s             20

      /free

       if %parms > 0;
         s = sep;
       endif;
       if s = '';
         f = %trim(%editc(1123.12:'J'));
         s = %subst(f:6:1);
       endif;

       return s;

      /end-free
     p                 e


     p NumSepGrp       b                   export
     d NumSepGrp       pi             1
     d   sep                          1    const options(*nopass)

     d s               s              1    static
     d f               s             20

      /free

       if %parms > 0;
         s = sep;
       endif;
       if s = '';
         f = %trim(%editc(1123.12:'J'));
         s = %subst(f:2:1);
       endif;

       return s;

      /end-free
     p                 e


     p SetQdsDs        b                   export
     d SetQdsDs        pi
     d   qds                      30000          options(*varsize)
     d   rc                           2  0 const options(*nopass)
     d   msg                        200    const options(*nopass)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

     d r               ds                  qualified inz
     d   c                            2
     d   d                            2s 0 overlay(c)

      /free

       r.d = 0;
       if %parms > 1;
         r.d = rc;
       endif;
       %subst(qds:1:2) = r.c;

       %subst(qds:3:200) = '';
       if %parms > 2;
         %subst(qds:3:200) = msg;
       endif;

       %subst(qds:203:84) = '';
       if %parms > 3;
         %subst(qds:203:12) = fld1;
       endif;
       if %parms > 4;
         %subst(qds:215:12) = fld2;
       endif;
       if %parms > 5;
         %subst(qds:227:12) = fld3;
       endif;
       if %parms > 6;
         %subst(qds:239:12) = fld4;
       endif;
       if %parms > 7;
         %subst(qds:251:12) = fld5;
       endif;
       if %parms > 8;
         %subst(qds:263:12) = fld6;
       endif;
       if %parms > 9;
         %subst(qds:275:12) = fld7;
       endif;

       return;

      /end-free
     p                 e


     p SetQdsDsMsg     b                   export
     d SetQdsDsMsg     pi
     d   qds                      30000          options(*varsize)
     d   msg                        200    const options(*nopass)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

      /free

       %subst(qds:3:200) = '';
       if %parms > 1;
         %subst(qds:3:200) = msg;
       endif;

       %subst(qds:203:84) = '';
       if %parms > 2;
         %subst(qds:203:12) = fld1;
       endif;
       if %parms > 3;
         %subst(qds:215:12) = fld2;
       endif;
       if %parms > 4;
         %subst(qds:227:12) = fld3;
       endif;
       if %parms > 5;
         %subst(qds:239:12) = fld4;
       endif;
       if %parms > 6;
         %subst(qds:251:12) = fld5;
       endif;
       if %parms > 7;
         %subst(qds:263:12) = fld6;
       endif;
       if %parms > 8;
         %subst(qds:275:12) = fld7;
       endif;

       return;

      /end-free
     p                 e


     p AddToAppOpts    b                   export
     d AddToAppOpts    pi            10i 0
     d   option                      21    const
     d   options                   1056
     d   wide                          n   const options(*nopass:*omit)
     d   lastoption                  21    const options(*nopass)

     d maxp            c                   4
     d d               s             10i 0
     d w               s             10i 0
     d l               s             10i 0
     d n               s             10i 0

      /free

       d = 20;
       w = 160;
       if        %parms > 2
             and %addr(wide) <> *null
             and wide
          or     (   %parms <= 2
                  or %addr(wide) = *null)
             and IsDspModeWide();
         d = 22;
         w = 264;
       endif;

       l = %len(%trimr(options));
       n = %div(l:d);
       if %rem(l:d) = 0;
         n = n*d + 1;
       else;
         n = (n+1)*d + 1;
       endif;

       if n > w * maxp;
         return 0;
       endif;

       if     %rem(n + d:w) = 1
          and %div(n:w) + 1 < maxp
          and %parms > 3
          and lastoption <> '';
         %subst(options:n:d-1) = %trim(lastoption);
         n = n + d;
       endif;

       %subst(options:n:d-1) = %trim(option);

       return %div(n:w) + 1;

      /end-free
     p                 e


     p GetAppOptsArray...
     p                 b                   export
     d GetAppOptsArray...
     d                 pi            21    dim(48)
     d   options                   1056    const
     d   wide                          n   const options(*nopass)

     d maxp            c                   4
     d opts            s                   like(GetAppOptsArray) dim(48)
     d d               s             10i 0
     d n               s             10i 0
     d i               s             10i 0

      /free

       d = 20;
       n = 32;
       if        %parms > 2
             and wide
          or     %parms <= 2
             and IsDspModeWide();
         d = 22;
         n = 48;
       endif;

       opts(*) = '';

       for i = 1 to n;
         opts(i) = %subst(options:(i-1)*d+1:d);
       endfor;

       return opts;

      /end-free
     p                 e


     p GetAppOptsPart  b                   export
     d GetAppOptsPart  pi           264
     d   part                        10i 0 const
     d   options                   1056    const
     d   wide                          n   const options(*nopass)

     d maxp            c                   4
     d w               s             10i 0

      /free

       if    part < 1
          or part > maxp;
         return '';
       endif;

       w = 160;
       if        %parms > 2
             and wide
          or     %parms <= 2
             and IsDspModeWide();
         w = 264;
       endif;

       return %subst(options:(part-1)*w+1:w);

      /end-free
     p                 e


     p CalleeSpcBhvr   b                   export
     d CalleeSpcBhvr   pi            10
     d   sbc                         10    const
     d   sbcpass                     10    const options(*nopass:*omit)
     d   sbcadd                      10    const options(*nopass:*omit)
     d   sbcsub                      10    const options(*nopass)

     d cpass           s                   like(sbcpass)
     d cadd            s                   like(sbcadd)
     d csub            s                   like(sbcsub)
     d passall         s               n
     d r               s            100    varying
     d c               s              1
     d p               s             10i 0

      /free

       if    %parms < 2
          or %addr(sbcpass) = *null
          or sbcpass = '';
         cpass = CSbcPassToCallee;
       else;
         cpass = sbcpass;
       endif;
       if     %parms > 2
          and %addr(sbcadd) <> *null;
         cadd = sbcadd;
       else;
         cadd = '';
       endif;
       if %parms > 3;
         csub = sbcsub;
       else;
         csub = '';
       endif;

       passall = %scan('*':cpass) > 0;

       r = '';

       // Add codes from "sbc".
       for p = 1 to %len(sbc);
         c = %subst(sbc:p:1);
         if     c <> ''
            and     passall
                 or %scan(c:cpass) > 0;
           exsr add_c_to_r;
         endif;
       endfor;

       // Add codes from "cadd" ("sbcadd").
       for p = 1 to %len(cadd);
         c = %subst(cadd:p:1);
         if c <> '';
           exsr add_c_to_r;
         endif;
       endfor;

       return r;

       begsr add_c_to_r;
         if     %scan(c:r) = 0
            and %scan(c:csub) = 0;
           r = r + c;
         endif;
       endsr;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModXX       b                   export
     dI_RlsModXX       pi

      /free

       return;

      /end-free
     p                 e

