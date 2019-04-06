
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPDISP_INCL_DEFS)
      /EOF
      /ENDIF
      /DEFINE CAPPDISP_INCL_DEFS


       // INCLUDE: *SRVPGM CAPPDISP

       // Definitions


       // ----- Prerequisite Service Program Definitions

      /include CAPPSSAMS,INCL_DEFS
      /include CAPPBASES,INCL_DEFS
      /include CSYSSQLSS,INCL_DEFS
      /include CSYSBASES,INCL_DEFS


       // ----- Constants


       // ----- Public Record Formats

       // This section defines PUBLIC record formats that are relevant
       // for this service program as external data structures.

       // Private record formats should be defined in member INCL__MODD.

       // Each format's name is equal to the physical file name, prefixed
       // with "Erf".

       // Each external data structure that defines a database record format
       // is conditioned with a condition-name that begins with "ERF_", which
       // is followed by the physical file name. This ensures that the same
       // external record format is only defined once.


       // ----- Data Structures

