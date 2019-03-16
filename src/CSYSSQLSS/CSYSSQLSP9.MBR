
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CSYSSQLSP9

       // Service Program: Common System Services / SQL Support
       // Program        : Release CSYSSQLS

       //                  Release service program CSYSSQLS

       //                  DO NOT CALL THIS PROGRAM WHILE *SRVPGM CSYSSQLS
       //                  IS STILL IN USE


     h bnddir(
     h             'CSYSSQLS'
     h            :'CSYSBASE'
     h       )

      /include QINCSRC,PGM_HEAD2


     d Main            pr                  extpgm('CSYSSQLSP9')


      /include CSYSSQLSS,INCL_API
      /include CSYSBASES,INCL_API


     d Main            pi

      /free

       // Release all resources.
       RlsSpCSYSSQLS();

       return;

      /end-free

