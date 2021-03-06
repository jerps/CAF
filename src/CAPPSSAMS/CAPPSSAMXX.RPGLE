
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module XX for *SRVPGM CAPPSSAM

       // Service Program: Common App Services / SubSystem AppMenu
       // Module         : Miscellaneous


      /DEFINE CAPPSSAM_MODULE
      /DEFINE CAPPSSAM_CAPPSSAMXX

      /include CAPPSSAMS,INCL__MODH


      /include CAPPSSAMS,INCL_XX

      /include CAPPSSAMS,INCL__XX

      /include CAPPSSAMS,INCL__MODD


       // ----- Implementation


     p IsGrpSpecial    b                   export
     d IsGrpSpecial    pi              n
     d   group                             const like(TAM_GROUP)

      /free

       return    group = CSgAdmin
              or group = CSgAll
              or group = CSgNone;

      /end-free
     p                 e


     p GetSpGrpText    b                   export
     d GetSpGrpText    pi                        like(TAM_TEXT)
     d   group                             const like(TAM_GROUP)

      /free

       select;
       when group = CSgAdmin;
         return 'Menu Administration';
       when group = CSgAll;
         return 'All Members';
       when group = CSgNone;
         return 'No Members';
       endsl;

       return '';

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModXX       b                   export
     dI_RlsModXX       pi

      /free

       return;

      /end-free
     p                 e

