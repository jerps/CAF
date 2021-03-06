
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_PT)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_PT


       // INCLUDE: *SRVPGM CAPPBASE

       // Module PT: Presentation Texts


      /include CAPPBASES,INCL_DEFS


       // ----- Prototypes

       // PtNumber - Present as text: Number
       // Return a text representing "number" with "dec" decimal digits.
       // If "dec" is negative, then represent "number" with a variable
       // number of decimal digits up to a maximum of abs("dec") with the
       // significant decimal digits only. If "dec" is not given or zero
       // then "number" is represented without decimal digits.
       // The decimal separator is given with NumSepDec() and the
       // group separator is given with NumSepGrp().
       // Optional parameter "fmtopt" may contain one or more of the
       // following formatting options:
       //   "g" - No group separators.
       //   "z" - No zero (return blanks if "number" is equal to 0).
       //   "R" - Put minus sign at the right instead of the left.
       //         If "number" is positive then a space is put to the
       //         right instead of the minus sign.
       // Optional parameter "wnd" specifies the number of "whole number
       // digits" to be included in the text, i.e the number of digits
       // before the decimal separator. If not given then all digits before
       // the decimal separator are included (which is a variable number of
       // "whole number digits"). If given and positive or zero, then it
       // specifies the exact number of digits that must appear before the
       // decimal separator in the text, possibly padded with zero's. If
       // "wnd" is negative, then abs("wnd") specifies the maximum number
       // of "whole number digits" to be included in the text.
       // Note that if "dec" and "wnd" are both zero the resulting text
       // has always length zero ('').
     d PtNumber        pr            30    varying extproc('PtNumber')
     d   number                      30  9 const
     d   dec                          1  0 const options(*nopass)
     d   fmtopt                      10    const options(*nopass)
     d   wnd                          2  0 const options(*nopass)

       // PtWeekdate - Present as text: Week date
       //              ccyywwd -> ccyyww-d
       //              ccyywwd -> yyww-d     (option "*YYWW")
       // Return a text representing a week date.
       // The week date is given with parameter "wdate", which has format
       // "ccyywwd", where "ww" is a number from 1 to 53, and "d" is a
       // number from 1 (monday) to 7 (sunday).
       // Parameter "option" may have one of the following values:
       //   *YYWW : the weekdate is formatted without the century (yyww-d).
     d PtWeekdate      pr             8    extproc('PtWeekdate')
     d   wdate                        7  0 const
     d   option                      10    const options(*nopass)

       // PtWeekdate2 - Present as text: Week date (2)
       //               cyyww:d -> ccyyww-d
       //               cyyww:d -> yyww-d    (option "*YYWW")
       // Like "PtWeekdate", but the week date is given with parameters
       // "week" and "day". Parameter "week" has format "cyyww", where
       // "c" is the century (0=19, 1=20, etc).
     d PtWeekdate2     pr             8    extproc('PtWeekdate2')
     d   week                         5  0 const
     d   day                          1  0 const
     d   option                      10    const options(*nopass)

       // PtDate - Present as text: Date
       //          -> yy-mm-dd
       // Return a text representing parameter "date", format "yy-mm-dd".
     d PtDate          pr             8    extproc('PtDate')
     d   date                          d   const

       // PtDateNI - Present as text: Date Numeric Iso
       //            yyyymmdd -> yy-mm-dd
       // Return a text representing parameter "date", which contains
       // a numeric date in ISO format, format "yy-mm-dd".
     d PtDateNI        pr             8    extproc('PtDateNI')
     d   date                         8  0 const

       // PtTime - Present as text: Time
       //          -> (h)h:mm:ss
       //          -> (h)h:mm     (option "*HM")
       // Return a text representing parameter "time", format "hh:mm:ss".
       // If the number of hours is 9 or less then the first character of
       // the text will be a space.
       // Parameter "option" may have one of the following values:
       //   *HM : the time is formatted with hours and minutes only.
     d PtTime          pr             8    extproc('PtTime')
     d   time                          t   const
     d   option                      10    const options(*nopass)

       // PtPgmRtncd - Present as text: Program Return code
       // Return a text representing a standard program return code.
       // Return blanks if the given return code is not recognized as
       // a standard return code.
     d PtPgmRtncd      pr           100    extproc('PtPgmRtncd')
     d   rtncd                        2  0 const

       // PtPgmResult - Present as text: Program Result
       // Return a text representing the result of executing a program,
       // which is indicated with return code "rtncd", return message 1
       // (error) "rtnmsg1", and return message 2 (cause) "rtnmsg2".
       // The returned text includes the return code, the text representing
       // this return code (using "PtPgmRtncd"), and return message 1 and 2.
       // Optionally, if parameter "rcmsg" is given (and is not blank),
       // then this text is included instead of the return code ("rtncd")
       // and the text representing this return code.
     d PtPgmResult     pr           200    extproc('PtPgmResult')
     d   rtncd                        2  0 const
     d   rtnmsg1                    100    const
     d   rtnmsg2                    100    const
     d   rcmsg                      100    const options(*nopass)

