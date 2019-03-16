
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module RM for *SRVPGM CAPPSSAM

       // Service Program: Common App Services / SubSystem AppMenu
       // Module         : Resource Management


      /DEFINE CAPPSSAM_MODULE
      /DEFINE CAPPSSAM_CAPPSSAMRM

      /include CAPPSSAMS,INCL__MODH


      /include CAPPSSAMS,INCL_RM

      /include CAPPSSAMS,INCL__MO
      /include CAPPSSAMS,INCL__DC
      /include CAPPSSAMS,INCL__DQ
      /include CAPPSSAMS,INCL__XX
      /include CAPPSSAMS,INCL__AM
      /include CAPPSSAMS,INCL__VA

      /include CAPPSSAMS,INCL__MODD


       // ----- Implementation


     p RlsSpCAPPSSAM   b                   export
     d RlsSpCAPPSSAM   pi

      /free

       I_RlsModMO();
       I_RlsModDC();
       I_RlsModDQ();
       I_RlsModXX();
       I_RlsModAM();
       I_RlsModVA();

       return;

      /end-free
     p                 e
