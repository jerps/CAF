
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPDISP_INCL_RM)
      /EOF
      /ENDIF
      /DEFINE CAPPDISP_INCL_RM


       // INCLUDE: *SRVPGM CAPPDISP

       // Module RM: Resource Management


      /include CAPPDISPS,INCL_DEFS


       // ----- Prototypes

       // RlsSpCAPPDISP - Release Service Program CAPPDISP
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this service program, e.g. when the
       // program using this service program exits. If it's not called then
       // these resources are automatically released when the activation
       // group in which the service program has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     d RlsSpCAPPDISP   pr                  extproc('RlsSpCAPPDISP')

