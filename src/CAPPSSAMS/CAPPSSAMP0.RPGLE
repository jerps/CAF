
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CAPPSSAMP0


       // Service Program: Common App Services / SubSystem AppMenu
       // Program        : Load Initial Data


      /include QINCSRC,PGM_HEAD1


     fCAPPSSAMF3if a e           k disk
     fCAPPSSAMF4if a e           k disk


      /include CAPPSSAMS,INCL_DEFS


     d Main            pr                  extpgm('CAPPSSAMP0')
     d   inid0                        1    const
     d   inif3                        1    const
     d   inif4                        1    const


     d CAPPSSAMA0      ds            50    qualified dtaara
     d   vcounter              1      8
     d   vreload               9     16
     d   bin                  19     19
     d   suser                21     30

     d PSI            sds                  qualified
     d   curuser             358    367


     d Main            pi
     d   inid0                        1    const
     d   inif3                        1    const
     d   inif4                        1    const

      /free

       *inlR = *on;

       if inid0 = '1';
         in *LOCK CAPPSSAMA0;
         clear CAPPSSAMA0;
         CAPPSSAMA0.vcounter = *all'0';
         CAPPSSAMA0.vreload  = *all'0';
         CAPPSSAMA0.bin      = '0';
         CAPPSSAMA0.suser    = PSI.curuser;
         out CAPPSSAMA0;
       endif;

       if inif3 = '1';
         clear *all MENUGREC;
         MENUGROUP = CSgAdmin;
         MENUGTEXT = 'Menu Administration';
         MENUGACT  = 'Y';
         write MENUGREC;
       endif;

       if inif4 = '1';
         clear *all MENUMGREC;
         MENUMGMBRT = 1;
         MENUMGMBRN = 'QSECOFR';
         MENUMGROUP = CSgAdmin;
         write MENUMGREC;
       endif;

       return;

      /end-free

