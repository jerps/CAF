
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CSYSBASEP0

       // Service Program: Common System Services / Base
       // Program        : Load Initial Data


      /include QINCSRC,PGM_HEAD1


     fCSYSBASEF0if a e           k disk
     fCSYSBASEF1if a e           k disk
     fCSYSBASEF2if a e           k disk


      /include CSYSBASES,INCL_DT


     d Main            pr                  extpgm('CSYSBASEP0')
     d   inif0                        1    const
     d   inif1                        1    const
     d   inif2                        1    const


     d Main            pi
     d   inif0                        1    const
     d   inif1                        1    const
     d   inif2                        1    const

      /free

       *inlR = *on;

       if inif0 = '1';
       endif;

       if inif1 = '1';
         clear *all NWDTREC;
         NWDTCODE = 'W';
         NWDTNAME = 'Week-end';
         write NWDTREC;
         NWDTCODE = 'F';
         NWDTNAME = 'Feast';
         write NWDTREC;
         NWDTCODE = 'H';
         NWDTNAME = 'Holiday';
         write NWDTREC;
         NWDTCODE = CNwdtWrkdayCode;
         NWDTNAME = CNwdtWrkdayName;
         write NWDTREC;
       endif;

       if inif2 = '1';
         clear *all NWDREC;
         NWDTYPE = 'W';
         NWDDNUM = 6;
         write NWDREC;
         NWDDNUM = 7;
         write NWDREC;
         clear *all NWDREC;
         NWDTYPE = 'H';
         NWDMONTH = 1;
         NWDDAY = 1;
         write NWDREC;
         clear *all NWDREC;
         NWDTYPE = 'F';
         NWDMONTH = 12;
         NWDDAY = 25;
         write NWDREC;
       endif;

       return;

      /end-free

