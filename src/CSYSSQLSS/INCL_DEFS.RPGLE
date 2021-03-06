
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSSQLS_INCL_DEFS)
      /EOF
      /ENDIF
      /DEFINE CSYSSQLS_INCL_DEFS


       // INCLUDE: *SRVPGM CSYSSQLS

       // Definitions


       // ----- Prerequisite Service Program Definitions

      /include CSYSBASES,INCL_DEFS


       // ----- Constants

       // Maximum # allocated connections and (total) cursors.
     dCSqlsMaxConn     c                   1
     dCSqlsMaxCurs     c                   99


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

      /IF NOT DEFINED(ERF_CSYSSQLSFR)
      /DEFINE ERF_CSYSSQLSFR
     dErfCSYSSQLSFR  e ds                  extname(CSYSSQLSFR)
      /ENDIF


       // ----- Data Structures

