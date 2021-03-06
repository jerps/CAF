
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module SU for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : Text Utilities


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASETU

      /include CSYSBASES,INCL__MODH


      /include CSYSBASES,INCL_TU

      /include CSYSBASES,INCL__TU

      /include CSYSBASES,INCL__MODD


       // ----- OS/400 API Defs

       // Request Control Block for API QlgConvertCase
     d OS4QlgCcRcb     ds                  qualified inz
     d   req_type                    10i 0
     d   ccsid_input                 10i 0
     d   case_req                    10i 0
     d   reserved                    10

       // API QlgConvertCase
     d QlgConvertCase  pr                  extproc('QlgConvertCase')
     d   rcb                               const like(OS4QlgCcRcb)
     d   in                       30000    const options(*varsize)
     d   out                      30000          options(*varsize)
     d   inlen                       10i 0 const
     d   apierr                                  like(OS4Error)


       // ----- Implementation


     p ToUppercase     b                   export
     d ToUppercase     pi          1000    varying
     d   text                      1000    const varying

     d r               s           1000

      /free

       clear OS4QlgCcRcb;
       OS4QlgCcRcb.req_type = 1;
       OS4QlgCcRcb.case_req = 0;
       OS4QlgCcRcb.reserved = *allx'00';
       r = '';
       reset OS4Error;
       QlgConvertCase(OS4QlgCcRcb:text:r:%len(text):OS4Error);
       return %trimr(r);

      /end-free
     p                 e


     p ToLowercase     b                   export
     d ToLowercase     pi          1000    varying
     d   text                      1000    const varying

     d r               s           1000

      /free

       clear OS4QlgCcRcb;
       OS4QlgCcRcb.req_type = 1;
       OS4QlgCcRcb.case_req = 1;
       OS4QlgCcRcb.reserved = *allx'00';
       r = '';
       reset OS4Error;
       QlgConvertCase(OS4QlgCcRcb:text:r:%len(text):OS4Error);
       return %trimr(r);

      /end-free
     p                 e


     p CharIsLetter    b                   export
     d CharIsLetter    pi              n
     d   char                         1    const
     d   option                      10    const options(*nopass)

      /free

       if    %parms < 2
          or     option <> '*UCASE'
             and option <> '*LCASE';
         return %check(CCharLettersUC+CCharLettersLC:char) = 0;
       endif;

       if option = '*UCASE';
         return %check(CCharLettersUC:char) = 0;
       endif;

       return %check(CCharLettersLC:char) = 0;

      /end-free
     p                 e


     p CharIsDigit     b                   export
     d CharIsDigit     pi              n
     d   char                         1    const

      /free

       return %check(CCharDigits:char) = 0;

      /end-free
     p                 e


     p ContainsDigitsOnly...
     p                 b                   export
     d ContainsDigitsOnly...
     d                 pi              n
     d   text                      1000    const varying
     d   option                      10    const options(*nopass)

      /free

       if    %parms > 1
          and option = '*ANDSPACES';
         return %check(CCharDigits+' ':text) = 0;
       endif;

       return %check(CCharDigits:text) = 0;

      /end-free
     p                 e


     p FmtInt          b                   export
     d FmtInt          pi           100    varying
     d   int                         20i 0 const
     d   fmt                        100    const varying
     d   option                      10    const options(*nopass)

     d rs              s               n
     d rz              s               n
     d r               s                   like(FmtInt)
     d                 ds
     d intn                          20  0
     d inta                          20    overlay(intn)
     d neg             s               n
     d msd             s             10i 0
     d c               s              1
     d p1              s             10i 0
     d p2              s             10i 0
     d p3              s             10i 0

      /free

       rs = *on;
       rz = *on;
       if %parms > 2;
         if option = '*RSPACES';
           rz = *off;
         elseif option = '*RZEROS';
           rs = *off;
         endif;
       endif;

       if int < 0;
         intn = 0 - int;
         neg = *on;
       else;
         intn = int;
         neg = *off;
       endif;

       r = fmt;

       p3 = 0;

       msd = %check('0':inta);
       if msd > 0;
         p1 = %len(fmt);
         for p2 = %len(inta) downto msd;
           c = %subst(inta:p2:1);
           dow     p1 > 0
               and (not rs or %subst(fmt:p1:1) <> ' ')
               and (not rz or %subst(fmt:p1:1) <> '0');
             p1 = p1 - 1;
           enddo;
           if p1 < 1;
             leave;
           endif;
           %subst(r:p1:1) = c;
           p3 = p1;
           p1 = p1 - 1;
         endfor;
       endif;

       for p1 = %len(r) downto 1;
         if %subst(r:p1:1) = '~';
           if neg;
             %subst(r:p1:1) = '-';
             if p1 < p3 - 1;
               p2 = p1 + 1;
               dow     p2 < p3
                   and %subst(r:p2:1) = ' ';
                 p2 = p2 + 1;
               enddo;
               if p2 = p3;
                 r = %subst(r:1:p1) + %subst(r:p2);
               endif;
             endif;
           else;
             %subst(r:p1:1) = ' ';
           endif;
           leave;
         endif;
       endfor;

       return r;

      /end-free
     p                 e


     p SubstText       b                   export
     d SubstText       pi          3000    varying
     d   text                      2000    const varying
     d   subst1                     200    const varying options(*omit:*nopass)
     d   subst2                     200    const varying options(*omit:*nopass)
     d   subst3                     200    const varying options(*omit:*nopass)
     d   subst4                     200    const varying options(*omit:*nopass)
     d   subst5                     200    const varying options(*omit:*nopass)
     d   subst6                     200    const varying options(*omit:*nopass)
     d   subst7                     200    const varying options(*omit:*nopass)
     d   subst8                     200    const varying options(*omit:*nopass)
     d   subst9                     200    const varying options(*omit:*nopass)

     d r               s                   like(SubstText)
     d p               s             10i 0
     d q               s             10i 0
     d f               s               n
     d c               s              1
     d subst           s                   like(subst1)

      /free

       r = '';

       p = 1;
       q = 0;
       f = *off;
       dow p <= %len(text);
         c = %subst(text:p:1);
         if f;
           select;
           when     c = '1'
                and %parms > 1
                and %addr(subst1) <> *null;
             subst = subst1;
             exsr substitute;
           when     c = '2'
                and %parms > 2
                and %addr(subst2) <> *null;
             subst = subst2;
             exsr substitute;
           when     c = '3'
                and %parms > 3
                and %addr(subst3) <> *null;
             subst = subst3;
             exsr substitute;
           when     c = '4'
                and %parms > 4
                and %addr(subst4) <> *null;
             subst = subst4;
             exsr substitute;
           when     c = '5'
                and %parms > 5
                and %addr(subst5) <> *null;
             subst = subst5;
             exsr substitute;
           when     c = '6'
                and %parms > 6
                and %addr(subst6) <> *null;
             subst = subst6;
             exsr substitute;
           when     c = '7'
                and %parms > 7
                and %addr(subst7) <> *null;
             subst = subst7;
             exsr substitute;
           when     c = '8'
                and %parms > 8
                and %addr(subst8) <> *null;
             subst = subst8;
             exsr substitute;
           when     c = '9'
                and %parms > 9
                and %addr(subst9) <> *null;
             subst = subst9;
             exsr substitute;
           endsl;
         endif;
         f = *off;
         if c = '%';
           f = *on;
         endif;
         p = p + 1;
       enddo;
       exsr append;

       return r;

       begsr append;
         if    p < 2
            or q >= %len(text);
           leavesr;
         endif;
         r = r + %subst(text:q+1:p-q-1);
       endsr;

       begsr substitute;
         p = p - 1;
         exsr append;
         r = r + subst;
         p = p + 1;
         q = p;
       endsr;

      /end-free
     p                 e


     p EnumValues      b                   export
     d EnumValues      pi          2000    varying
     d   values                        *   const
     d   enum                        10i 0 const
     d   elen                        10i 0 const
     d   sep                          1    const
     d   option                      10    const options(*nopass)

     d r               s                   like(EnumValues)
     d elem            s           2000    based(elem@)
     d n               s             10i 0
     d p               s             10i 0
     d i               s             10i 0
     d c               s              1

      /free

       r = '';

       if    enum < 1
          or elen < 1;
         return r;
       endif;

       n = 0;
       elem@ = values;
       dow     n < enum
           and %len(r) < 2000;
         if     %parms > 4
            and option = '*NOTRIMR';
           r = r + %subst(elem:1:elen);
         else;
           r = r + %trimr(%subst(elem:1:elen));
         endif;
         n = n + 1;
         if n < enum;
           r = r + sep + ' ';
         endif;
         elem@ = elem@ + elen;
       enddo;

       return r;

      /end-free
     p                 e


     p CharInText      b                   export
     d CharInText      pi              n
     d   chars                       50    const varying
     d   text                      1000    const varying
     d   option                      10    const         options(*nopass)

     d all             s               n
     d p               s             10i 0

      /free

       if    %len(chars) = 0
          or %len(text) = 0;
         return *off;
       endif;

       all = %parms > 2 and option = '*ALL';

       for p = 1 to %len(chars);
         if %scan(%subst(chars:p:1):text) > 0;
           if not all;
             return *on;
           endif;
         elseif all;
           return *off;
         endif;
       endfor;

       return all;

      /end-free
     p                 e


     p ConcatText      b                   export
     d ConcatText      pi          2000    varying
     d   text1                     1000    const varying
     d   text2                     1000    const varying
     d   sep                       1000    const varying options(*nopass)

      /free

       if    %len(text1) = 0
          or %parms <= 2
          or %len(sep) = 0;
         return text1 + text2;
       endif;

       return text1 + sep + text2;

      /end-free
     p                 e


     p RepeatText      b                   export
     d RepeatText      pi          2000    varying
     d   text                        50    const varying
     d   num                         10i 0 const

     d r               s                   like(RepeatText)
     d i               s             10i 0

      /free

       if    num <= 0
          or %len(text) <= 0;
         return '';
       endif;

       for i = 1 to num;
         r = r + text;
         if %len(r) >= 2000;
           leave;
         endif;
       endfor;

       return r;

      /end-free
     p                 e


     p RepeatCharsInText...
     p                 b                   export
     d RepeatCharsInText...
     d                 pi          2000    varying
     d   text                      1000    const varying
     d   chars                       50    const varying
     d   num                         10i 0 const

     d r               s                   like(RepeatCharsInText)
     d n               s             10i 0
     d p               s             10i 0
     d i               s             10i 0
     d c               s              1

      /free

       r = '';

       if num < 0;
         n = 0;
       else;
         n = num;
       endif;

       p = 1;
       dow p <= %len(text);
         c = %subst(text:p:1);
         if %scan(c:chars) > 0;
           for i = 1 to n;
             r = r + c;
           endfor;
         else;
           r = r + c;
         endif;
         p = p + 1;
       enddo;

       return r;

      /end-free
     p                 e


     p OrdinalNumText  b                   export
     d OrdinalNumText  pi            15    varying
     d   onum                        10i 0 const

     d r               s                   like(OrdinalNumText)
     d n               s             10i 0

      /free

       if onum < 1;
         return '';
       endif;

       r = %char(onum);

       select;
       when onum = 1;
         r = r + 'st';
       when onum = 2;
         r = r + 'nd';
       when onum = 3;
         r = r + 'rd';
       other;
         r = r + 'th';
       endsl;

       return r;

      /end-free
     p                 e


     p PluralNoun      b                   export
     d PluralNoun      pi           100    varying
     d   noun                       100    const varying
     d   num                         10i 0 const

      /free

       if num = 1;
         return noun;
       endif;

       return noun + 's';

      /end-free
     p                 e


     p XMLCharData     b                   export
     d XMLCharData     pi
     d   text                     16383c         varying ccsid(13488)
     d   xmltext                  16383c         varying ccsid(13488)

     d i               s             10i 0
     d c               s              1c   ccsid(13488)

      /free

       xmltext = %ucs2('':13488);

       for i = 1 to %len(text);
         c = %subst(text:i:1);
         select;
         when c = %ucs2('"':13488);
           xmltext = xmltext + %ucs2('&quot;':13488);
         when c = %ucs2('''':13488);
           xmltext = xmltext + %ucs2('&apos;':13488);
         when c = %ucs2('<':13488);
           xmltext = xmltext + %ucs2('&lt;':13488);
         when c = %ucs2('>':13488);
           xmltext = xmltext + %ucs2('&gt;':13488);
         when c = %ucs2('&':13488);
           xmltext = xmltext + %ucs2('&amp;':13488);
         other;
           xmltext = xmltext + c;
         endsl;
       endfor;

       return;

      /end-free
     p                 e


     p XMLCharData_S   b                   export
     d XMLCharData_S   pi
     d   text                     32767          varying
     d   xmltext                  32767          varying

     d i               s             10i 0
     d c               s              1

      /free

       xmltext = '';

       for i = 1 to %len(text);
         c = %subst(text:i:1);
         select;
         when c = '"';
           xmltext = xmltext + '&quot;';
         when c = '''';
           xmltext = xmltext + '&apos;';
         when c = '<';
           xmltext = xmltext + '&lt;';
         when c = '>';
           xmltext = xmltext + '&gt;';
         when c = '&';
           xmltext = xmltext + '&amp;';
         other;
           xmltext = xmltext + c;
         endsl;
       endfor;

       return;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModTU       b                   export
     dI_RlsModTU       pi

      /free

       return;

      /end-free
     p                 e

