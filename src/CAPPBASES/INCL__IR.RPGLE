
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL__IR)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL__IR


       // INCLUDE: *SRVPGM CAPPBASE

       // Module IR: Interpret Raw input

       // Internal


       // ----- Prototypes

       // I_RlsModIR - Release Module IR
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this module. If it's not called then
       // these resources are automatically released when the activation
       // group in which the module has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     dI_RlsModIR       pr                  extproc('I_RlsModIR')

