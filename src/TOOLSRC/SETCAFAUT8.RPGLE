
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /include QINCSRC,PGM_HEAD2


     d names           s             20    dim(9999)
     d flag1           s               n
     d flag2           s               n


     d Main            pr                  extpgm('SETCAFAUT8')
     d   objnm                       20    const
     d   num1                         4  0
     d   num2                         5  0
     d   num1a                        4
     d   num2a                        5
     d   num3                         5  0
     d   num3a                        5


     d Main            pi
     d   objnm                       20    const
     d   num1                         4  0
     d   num2                         5  0
     d   num1a                        4
     d   num2a                        5
     d   num3                         5  0
     d   num3a                        5

     d i               s             10i 0

      /free

       if %parms > 3;
         *inLR = *on;
         if flag1;
           num1a = *all'+';
         else;
           num1a = %char(num1);
         endif;
         if flag2;
           num2a = *all'+';
         else;
           num2a = %char(num2);
         endif;
         num3a = %char(num3);
       else;
         if num1 = 0;
           clear names;
           num1 = 1;
           num2 = 0;
           names(1) = objnm;
         elseif num1 < 9999;
           i = %lookup(objnm:names:1:num1);
           if i = 0;
             num1 = num1 + 1;
             names(num1) = objnm;
           endif;
         else;
           flag1 = *on;
         endif;
         if num2 < 99999;
           num2 = num2 + 1;
         else;
           flag2 = *on;
         endif;
       endif;

       return;

      /end-free

