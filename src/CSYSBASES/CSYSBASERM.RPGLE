
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module RM for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : Resource Management


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASERM

      /include CSYSBASES,INCL__MODH


      /include CSYSBASES,INCL_RM

      /include CSYSBASES,INCL__DF
      /include CSYSBASES,INCL__XD
      /include CSYSBASES,INCL__WM
      /include CSYSBASES,INCL__TU
      /include CSYSBASES,INCL__DT
      /include CSYSBASES,INCL__CV
      /include CSYSBASES,INCL__XX

      /include CSYSBASES,INCL__MODD


       // ----- Implementation


     p RlsSpCSYSBASE   b                   export
     d RlsSpCSYSBASE   pi

      /free

       I_RlsModDF();
       I_RlsModXD();
       I_RlsModWM();
       I_RlsModTU();
       I_RlsModDT();
       I_RlsModCV();
       I_RlsModXX();

       return;

      /end-free
     p                 e

