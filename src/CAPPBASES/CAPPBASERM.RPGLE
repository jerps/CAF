
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module RM for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Resource Management


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASERM

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL_RM

      /include CAPPBASES,INCL__PT
      /include CAPPBASES,INCL__IR
      /include CAPPBASES,INCL__MS
      /include CAPPBASES,INCL__XX
      /include CAPPBASES,INCL__AM
      /include CAPPBASES,INCL__VA

      /include CAPPBASES,INCL__MODD


       // ----- Implementation


     p RlsSpCAPPBASE   b                   export
     d RlsSpCAPPBASE   pi

      /free

       I_RlsModPT();
       I_RlsModIR();
       I_RlsModMS();
       I_RlsModXX();
       I_RlsModAM();
       I_RlsModVA();

       return;

      /end-free
     p                 e

