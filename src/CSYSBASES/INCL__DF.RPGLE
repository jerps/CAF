
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL__DF)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL__DF


       // INCLUDE: *SRVPGM CSYSBASE

       // Module DF: DisplayFile

       // Internal


       // ----- Prototypes

       // I_RlsModDF - Release Module DF
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this module. If it's not called then
       // these resources are automatically released when the activation
       // group in which the module has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     dI_RlsModDF       pr                  extproc('I_RlsModDF')

