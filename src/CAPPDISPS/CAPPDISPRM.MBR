
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module RM for *SRVPGM CAPPDISP


       // Service Program: Common App Services / Display
       // Module         : Resource Management


      /DEFINE CAPPDISP_MODULE
      /DEFINE CAPPDISP_CAPPDISPRM

      /include CAPPDISPS,INCL__MODH


      /include CAPPDISPS,INCL_RM

      /include CAPPDISPS,INCL__SI
      /include CAPPDISPS,INCL__HD
      /include CAPPDISPS,INCL__XX

      /include CAPPDISPS,INCL__MODD


       // ----- Implementation


     p RlsSpCAPPDISP   b                   export
     d RlsSpCAPPDISP   pi

      /free

       I_RlsModSI();
       I_RlsModHD();
       I_RlsModXX();

       return;

      /end-free
     p                 e
