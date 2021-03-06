
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_DEFS)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_DEFS


       // INCLUDE: *SRVPGM CAPPBASE

       // Definitions


       // ----- Prerequisite Service Program Definitions

      /include CSYSBASES,INCL_DEFS


       // ----- Constants

       // Application message severity (Fatal, Warning, Informational)
     dCAmsFatal        c                   'F'
     dCAmsWarning      c                   'W'
     dCAmsInfo         c                   'I'

       // Special behavior codes that should be passed by default
       // from caller to callee.
     dCSbcPassToCallee...
     d                 c                   'IJKX'


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

