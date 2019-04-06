
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CAPPSSAMP1


       // Service Program: Common App Services / SubSystem AppMenu
       // Program        : Add user to group

       // To add the user, set parameter 3 to '1', else it is removed.


      /include QINCSRC,PGM_HEAD1


     fCAPPSSAMF4uf a e           k disk


      /include CAPPSSAMS,INCL_DEFS


     d Main            pr                  extpgm('CAPPSSAMP1')
     d   group                       15    const
     d   user                        10    const
     d   add                          1    const


     d Main            pi
     d   group                       15    const
     d   user                        10    const
     d   add                          1    const

      /free

       *inlR = *on;

       if add = '1';
         chain(n) (1:user:group) CAPPSSAMF4;
         if not %found;
           clear *all MENUMGREC;
           MENUMGMBRT = 1;
           MENUMGMBRN = user;
           MENUMGROUP = group;
           write MENUMGREC;
         endif;
       else;
         chain (1:user:group) CAPPSSAMF4;
         if %found;
           delete MENUMGREC;
         endif;
       endif;

       return;

      /end-free

