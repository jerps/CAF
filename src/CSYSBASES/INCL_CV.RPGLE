
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_CV)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_CV


       // INCLUDE: *SRVPGM CSYSBASE

       // Module CV: Conversions


      /include CSYSBASES,INCL_DEFS


       // ----- Prototypes

       // CvtTxtToInt - Convert Text To Integer
       // Ignore all characters except all digits and an optional minus
       // sign (-) which must appear as the first character in "text".
       // If parameter "option" is specified with value "*NONEG" then
       // the minus sign, if present, is ignored so that the result is
       // always positive.
     d CvtTxtToInt     pr            20i 0 extproc('CvtTxtToInt')
     d   text                        30    const
     d   option                      10    const options(*nopass)

       // CvtIntToTxt- Convert Integer To Text
       // The resulting text contains only digits with no leading
       // zeros, which is preceded with a minus sign if "int" is
       // negative.
     d CvtIntToTxt     pr            30    extproc('CvtIntToTxt')
     d   int                         20i 0 const

       // CvtCCSID - Convert CCSID
       // Convert text "source", which has a specific CCSID, to the same
       // text but with another CCSID, into parameter "target".
       // The conversion is done with POSIX routine "iconv()".
       // Parameter "tccsid" is the target CCSID, the CCSID of "target".
       // If "tccsid" is 0 then the job default is used.
       // Optional parameter "sccsid" is the CCSID of "source".
       // If "sccsid" is 0 or not given then the job default is used.
       // This procedure returns 0 if "source" has been completely converted.
       // If not it returns the POSIX errorcode "errno", which is retrieved
       // with "CErrNoInt". In this case "target" will be empty (length 0).
     d CvtCCSID        pr            10i 0 extproc('CvtCCSID')
     d   source                   32766    const varying
     d   target                   32766          varying
     d   tccsid                      10i 0 value
     d   sccsid                      10i 0 value options(*nopass)

