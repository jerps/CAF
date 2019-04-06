
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_DEFS)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_DEFS


       // INCLUDE: *SRVPGM CSYSBASE

       // Definitions


       // ----- Prerequisite Service Program Definitions


       // ----- Constants

       // New Line character(s) to end a text line.
     dCNewLine         c                   x'25'

       // End-Of-Line sequence for Windows.
     dCEOLWin          c                   x'0D25'

       // Character Constants.
       // - Line Feed
     dCCharLF          c                   x'25'
       // - Carriage Return
     dCCharCR          c                   x'0D'
       // - All digits
     dCCharDigits      c                   '0123456789'
       // - All uppercase letters (ASCII).
     dCCharLettersUC   c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
       // - All lowercase letters (ASCII).
     dCCharLettersLC   c                   'abcdefghijklmnopqrstuvwxyz'

       // Default Messagefile
     dCDftMsgf         c                   'QCPFMSG'

       // Maximum C-style string length.
     dCMaxCStringLen   c                   65534


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

