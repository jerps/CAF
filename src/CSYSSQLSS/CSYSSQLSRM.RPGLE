
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module RM for *SRVPGM CSYSSQLS

       // Service Program: Common System Services / SQL Support
       // Module         : Resource Management


      /DEFINE CSYSSQLS_MODULE
      /DEFINE CSYSSQLS_CSYSSQLSRM

      /include CSYSSQLSS,INCL__MODH

      /include CSYSSQLSS,INCL_RM

      /include CSYSSQLSS,INCL__SS
      /include CSYSSQLSS,INCL__CI
      /include CSYSSQLSS,INCL__MODD


       // ----- Implementation


     p RlsSpCSYSSQLS   b                   export
     d RlsSpCSYSSQLS   pi

      /free

       I_RlsModSS();
       I_RlsModCI();

       return;

      /end-free

     p                 e

