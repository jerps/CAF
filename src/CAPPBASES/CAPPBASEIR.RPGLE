
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module IR for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Interpret Raw input


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASEIR

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL_IR
      /include CAPPBASES,INCL_XX
      /include CSYSBASES,INCL_API

      /include CAPPBASES,INCL__IR

      /include CAPPBASES,INCL__MODD


       // ----- Implementation


     p IrNumber        b                   export
     d IrNumber        pi              n
     d   data                        30    const
     d   value                       30  9
     d   digits                       1  0 const options(*nopass)
     d   dec                          1  0 const options(*nopass)
     d   inpopt                      10    const options(*nopass)

     d v               s             30  0
     d noneg           s               n
     d nogs            s               n
     d l               s             10i 0
     d p               s             10i 0
     d c               s              1
     d neg             s               n
     d fd              s               n
     d fnzd            s               n
     d gs              s               n
     d gd              s             10i 0
     d dc              s             10i 0
     d ddc             s             10i 0
     d md              s             10i 0
     d vd              s               n
     d mdd             s             10i 0
     d vdd             s               n
     d zc              s             10i 0

      /free

       value = 0;

       if data = '';
         return *on;
       endif;

       if %check('- 0123456789'+NumSepDec()+NumSepGrp():data) > 0;
         return *off;
       endif;

       noneg = *off; // no minus allowed
       nogs  = *off; // no group separators allowed
       if     %parms > 4
          and %scan('+':inpopt) > 0;
         noneg = *on;
       endif;
       if     %parms > 4
          and %scan('g':inpopt) > 0;
         nogs = *on;
       endif;

       v    = 0;     // the value
       neg  = *off;  // minus sign
       fd   = *off;  // first digit
       gs   = *off;  // group separator
       gd   = 3;     // group digits
       dc   = 0;     // digit count (without leading non-significant zeros)
       ddc  = -1;    // decimal digit count
       zc   = 0;     // zero's count
       if %parms > 2;
         if digits < 0;
           md = 0 - digits;  // max digits
           vd = *off;        // variable number of digits not allowed
         else;
           md = digits;      // max digits
           vd = *on;         // variable number of digits allowed
         endif;
       else;
         md = 99;            // max digits
         vd = *on;           // variable number of digits allowed
       endif;
       if %parms > 3;
         if dec < 0;
           mdd = 0 - dec;    // max decimal digits
           vdd = *on;        // variable number of decimal digits allowed
         else;
           mdd = dec;        // max decimal digits
           vdd = *off;       // variable number of decimal digits not allowed
         endif;
       else;
         mdd = 9;            // max decimal digits
         vdd = *on;          // variable number of decimal digits allowed
       endif;
       l = %len(%trimr(data));
       for p = 1 to l;
         c = %subst(data:p:1);
         if c = '0';
           zc = zc + 1;
         else;
           zc = 0;
         endif;
         if c = '-';
           if noneg;
             // no negative number allowed.
             return *off;
           endif;
           if neg;
             // minus sign allowed only once
             return *off;
           endif;
           if     p < l
              and (fd or ddc > -1);
             // minus sign must be the last character
             return *off;
           endif;
           neg = *on;
         elseif c = ' ';
           if fd or ddc > -1;
             // space not allowed after first digit or decimal point
             return *off;
           endif;
         elseif c = NumSepGrp();
           if nogs;
             // no group separators allowed.
             return *off;
           endif;
           if not fd or ddc > -1;
             // group sep. not allowed before first digit or decimal sep.
             return *off;
           endif;
           if gs and gd <> 0;
             // wrong number of digits after group sep.
             return *off;
           endif;
           if not gs and gd < 0;
             // too many digits before first group sep.
             return *off;
           endif;
           gs = *on;
           gd = 3; // number of digits after group sep.
         elseif c = NumSepDec();
           if ddc > -1;
             // decimal sep. allowed only once
             return *off;
           endif;
           if mdd = 0;
             // no decimal digits allowed
             return *off;
           endif;
           if gs and gd <> 0;
             // wrong number of digits after group sep.
             return *off;
           endif;
           ddc = 0;
           gd = 0;
         else;
           // c is a digit
           fd = *on;
           if gs and gd <= 0 and ddc = -1;
             // too many digits after group sep. but before decimal sep.
             return *off;
           endif;
           if v > 99999999999999999999999999999;
             // overflow
             return *off;
           endif;
           if ddc > -1;
             ddc = ddc + 1;
           endif;
           if    c <> '0'
              or v <> 0
              or ddc > -1;
             dc = dc + 1;
           endif;
           gd = gd - 1;
           v = v * 10;
           select;
           when c = '1';
             v = v + 1;
           when c = '2';
             v = v + 2;
           when c = '3';
             v = v + 3;
           when c = '4';
             v = v + 4;
           when c = '5';
             v = v + 5;
           when c = '6';
             v = v + 6;
           when c = '7';
             v = v + 7;
           when c = '8';
             v = v + 8;
           when c = '9';
             v = v + 9;
           endsl;
         endif;
       endfor;
       // Adjust "dc" and "ddc" to the number of significant (decimal) digits.
       if ddc >= 0;
         dc  = dc - zc;
         ddc = ddc - zc;
       endif;
       if    dc > md
          or ddc > mdd
          or not vd and dc <> md
          or not vdd and ddc >= 0 and ddc <> mdd;
         // wrong number of significant (decimal) digits
         return *off;
       endif;
       if gs and gd <> 0;
         // wrong number of digits after group sep.
         return *off;
       endif;

       if ddc < 0;
         ddc = 0;
       else;
         ddc = ddc + zc; // actual number of decimal digits needed again
       endif;
       if neg;
         value = 0 - v / 10 ** ddc;
       else;
         value = v / 10 ** ddc;
       endif;

       return *on;

      /end-free
     p                 e


     p IrWkDate        b                   export
     d IrWkDate        pi              n
     d   data                        10    const
     d   value                         d

     d n               s             10i 0

      /free

       value = *loval;

       n = CvtTxtToInt(data:'*NOGEN');
       n = YY2YYYY(%div(n:1000)) * 1000 + %rem(n:1000);

       if     n > 0
          and n < 9999999;
         value = Wdt2Gdt(n);
       endif;

       if value = *loval;
         return *off;
       endif;

       return *on;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModIR       b                   export
     dI_RlsModIR       pi

      /free

       return;

      /end-free
     p                 e

