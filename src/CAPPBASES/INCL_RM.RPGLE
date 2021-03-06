
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_RM)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_RM


       // INCLUDE: *SRVPGM CAPPBASE

       // Module RM: Resource Management


      /include CAPPBASES,INCL_DEFS


       // ----- Prototypes

       // RlsSpCAPPBASE - Release Service Program CAPPBASE
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this service program, e.g. when the
       // program using this service program exits. If it's not called then
       // these resources are automatically released when the activation
       // group in which the service program has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     d RlsSpCAPPBASE   pr                  extproc('RlsSpCAPPBASE')

