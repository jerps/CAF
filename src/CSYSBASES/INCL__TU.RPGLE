
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL__TU)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL__TU


       // INCLUDE: *SRVPGM CSYSBASE

       // Module TU: Text Utilities

       // Internal


       // ----- Prototypes

       // I_RlsModTU - Release Module TU
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this module. If it's not called then
       // these resources are automatically released when the activation
       // group in which the module has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     dI_RlsModTU       pr                  extproc('I_RlsModTU')

