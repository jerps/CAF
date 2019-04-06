
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module WM for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : Work Management


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASEWM

      /include CSYSBASES,INCL__MODH


      /include CSYSBASES,INCL_WM

      /include CSYSBASES,INCL__WM

      /include CSYSBASES,INCL__MODD


       // ----- OS/400 API Defs

       // Format JOBI0100 for API QUSRJOBI
     d OS4JOBI0100     ds                  qualified inz
     d   bytesrtn                    10i 0
     d   bytesavl                    10i 0
     d   jobname                     10
     d   username                    10
     d   jobnumber                    6
     d   intjobid                    16
     d   jobstatus                   10
     d   jobtype                      1
     d   jobsubtype                   1
     d   reserved01                   2
     d   runpriority                 10i 0
     d   timeslice                   10i 0
     d   defaultwait                 10i 0
     d   purge                       10

       // API QUSRJOBI
     d CallQUSRJOBI    pr                  extpgm('QUSRJOBI')
     d   jobi                                    like(OS4JOBI0100)
     d   jobisz                      10i 0 const
     d   fmtname                     10    const
     d   qjobname                    26    const
     d   intjobid                    16    const
     d   apierr                                  like(OS4Error)


       // ----- Implementation


     p JobIsInteractive...
     p                 b                   export
     d JobIsInteractive...
     d                 pi              n

      /free

       reset OS4Error;
       clear OS4JOBI0100;

       CallQUSRJOBI(OS4JOBI0100:%size(OS4JOBI0100):
                   'JOBI0100':'*':'':OS4Error);

       return     OS4Error.bavl = 0
              and OS4JOBI0100.bytesrtn > 0
              and OS4JOBI0100.jobtype = 'I';

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModWM       b                   export
     dI_RlsModWM       pi

      /free

       return;

      /end-free
     p                 e

