
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_WM)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_WM


       // INCLUDE: *SRVPGM CSYSBASE

       // Module WM: Work Management


      /include CSYSBASES,INCL_DEFS


       // ----- Prototypes

       // JobIsInteractive - Job Is Interactive
       // Return *on if the current job is interactive (i.e. type INT
       // on the WRKACTJOB command), else return *off.
     d JobIsInteractive...
     d                 pr              n   extproc('JobIsInteractive')

