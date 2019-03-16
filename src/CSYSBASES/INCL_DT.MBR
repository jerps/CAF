
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_DT)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_DT


       // INCLUDE: *SRVPGM CSYSBASE

       // Module DT: Date/Time functions


      /include CSYSBASES,INCL_DEFS


       // ----- Constants

       // Cutoff year
       // A 2-digit year that is less than or equal to the last two digits
       // of the cutoff year is in the same century as the cutoff year, else
       // it is in the century before that of the cutoff year.
     dCCutoffYear      c                   2039

       // Non-Workday Type "WORKDAY".
       // See the description for table CSYSBASEF2 for more info.
     dCNwdtWrkdayCode  c                   '*'
     dCNwdtWrkdayName  c                   'WORKDAY'


       // ----- Data Structures

       // This data structure represents a weekdate with it's components.
       // It's just for convenience; to be used by client programs.
       // The contents of this data structure is never used/changed
       // by procedures in this module.
     d WdtDS           ds                  qualified
     d   wdt                          7  0
     d   yyyy                         4  0 overlay(wdt)
     d   ww                           2  0 overlay(wdt:*next)
     d   d                            1  0 overlay(wdt:*next)


       // ----- Prototypes

       // IsoWkdayNum - ISO Weekday Number
       // Return the ISO weekday number (1-7) of "date".
       // Day 1 is a monday.
     d IsoWkdayNum     pr            10i 0 extproc('IsoWkdayNum')
     d   date                          d   const

       // IsoWkdayName - ISO Weekday Name
       // Return the ISO weekday name for "daynum" (1-7).
       // Day 1 is a monday.
       // Return '' if "daynum" is not a valid weekday number.
       // If optional parameter "option" is not given then the
       // normal name is returned, without capitalization.
       // Parameter "option" can have one of the following values
       // to specify a specific form of the weekday name:
       //   *CAPITAL: with capitalization;
       //   *SHORT  : short name without capitalization;
       //   *SHORTC : short name with capitalization.
     d IsoWkdayName    pr            30    varying extproc('IsoWkdayName')
     d   daynum                      10i 0 const
     d   option                      10    const options(*nopass)

       // IsoWeekNum - ISO Week Number
       // Return the ISO week number (1-53) of "date".
       // Return 0 if the year of "date" is less than 2 or greater than 9998.
     d IsoWeekNum      pr            10i 0 extproc('IsoWeekNum')
     d   date                          d   const

       // IsoLastWeekNum - ISO Last Week Number
       // Return the last ISO week number (1-53) of year "yyyy".
       // Return 0 if "yyyy" is less than 2 or greater than 9998.
     d IsoLastWeekNum  pr            10i 0 extproc('IsoLastWeekNum')
     d   yyyy                        10i 0 const

       // MonthName - Month Name
       // Return the month name for "month" (1-12).
       // Return '' if "month" is not valid.
       // If optional parameter "option" is not given then the
       // normal name is returned, without capitalization.
       // Parameter "option" can have one of the following values
       // to specify a specific form of the month name:
       //   *CAPITAL: with capitalization;
       //   *SHORT  : short name without capitalization;
       //   *SHORTC : short name with capitalization.
     d MonthName       pr            30    varying extproc('MonthName')
     d   month                       10i 0 const
     d   option                      10    const options(*nopass)

       // Gdt2Wdt - Gregorian date To Week date
       // Convert a gregorian date to a (ISO) week date. The week date
       // has format ccyywwd, where "ww" is a number from 1 to 53, and
       // "d" is a number from 1 (monday) to 7 (sunday).
       // Return 0 if the year of "gdate" is less than 2 or greater than 9998.
     d Gdt2Wdt         pr             7  0 extproc('Gdt2Wdt')
     d   gdate                         d   const

       // Gdt2IsoNum - Gregorian date To ISO Number
       // Convert a gregorian date to an ISO formatted number (yyyymmdd).
     d Gdt2IsoNum      pr             8  0 extproc('Gdt2IsoNum')
     d   gdate                         d   const

       // Wdt2Gdt - Week date To Gregorian date
       // Convert a (ISO) week date to a gregorian date. The week date is
       // given with parameter "wdate", with format ccyywwd, where "ww"
       // is a number from 1 to 53, and "d" is a number from 1 (monday)
       // to 7 (sunday).
       // Return *loval if the given week date is invalid.
     d Wdt2Gdt         pr              d   extproc('Wdt2Gdt')
     d   wdate                        7  0 const

       // IsValidGdt - Is Valid Gregorian date
       // Return *on if "yyyy", "mm" and "dd" together represent a
       // valid date, else return *off.
     d IsValidGdt      pr              n   extproc('IsValidGdt')
     d   yyyy                        10i 0 const
     d   mm                          10i 0 const
     d   dd                          10i 0 const

       // IsValidGdt1 - Is Valid Gregorian date (variant 1)
       // Return *on if "yyyymmdd" represents a valid date, else return *off.
     d IsValidGdt1     pr              n   extproc('IsValidGdt1')
     d   yyyymmdd                    10i 0 const

       // IsValidGdt2 - Is Valid Gregorian date (variant 2)
       // Return *on if "yymmdd" represents a valid date, else return *off.
     d IsValidGdt2     pr              n   extproc('IsValidGdt2')
     d   yymmdd                      10i 0 const

       // IsValidWdt - Is Valid Week date
       // Return *on if "yyyy", "ww" and "d" together represent a
       // valid date, else return *off.
     d IsValidWdt      pr              n   extproc('IsValidWdt')
     d   yyyy                        10i 0 const
     d   ww                          10i 0 const
     d   d                           10i 0 const

       // IsValidWdt1 - Is Valid Week date (variant 1)
       // Return *on if "wdate", with format ccyywwd, represents a
       // valid date, else return *off.
     d IsValidWdt1     pr              n   extproc('IsValidWdt1')
     d   wdate                        7  0 const

       // MakeGdt - Make Gregorian date
       // Return a new gregorian date from "yyyy", "mm" and "dd".
       // Return *loval if the date is invalid.
     d MakeGdt         pr              d   extproc('MakeGdt')
     d   yyyy                        10i 0 const
     d   mm                          10i 0 const
     d   dd                          10i 0 const

       // MakeGdt1 - Make Gregorian date (variant 1)
       // Return a new gregorian date from "yyyymmdd".
       // Return *loval if the date is invalid.
     d MakeGdt1        pr              d   extproc('MakeGdt1')
     d   yyyymmdd                    20i 0 const

       // SplitGdt - Split Gregorian date
       // Return the components of gregorian date "gdt" via
       // parameters "yyyy", "mm" and "dd".
     d SplitGdt        pr                  extproc('SplitGdt')
     d   gdt                           d   const
     d   yyyy                        10i 0       options(*nopass:*omit)
     d   mm                          10i 0       options(*nopass:*omit)
     d   dd                          10i 0       options(*nopass:*omit)

       // MakeWdt - Make Week date
       // Return a new week date from "yyyy", "ww" and "d".
       // The returned week date may be an invalid date; this is NOT checked.
       // Return 0 if parameter values are invalid, i.e. they must be
       // between 1-9999, 1-53 and 1-7, resp.
     d MakeWdt         pr             7  0 extproc('MakeWdt')
     d   yyyy                        10i 0 const
     d   ww                          10i 0 const
     d   d                           10i 0 const

       // MakeWdt1 - Make Week date (variant 1)
       // Return a new week date from "cc", "yyww" and "d".
       // The returned week date may be an invalid date; this is NOT checked.
       // Return 0 if parameter values are invalid, i.e. they must be
       // between 0-99, 0-9953 and 1-7, resp.
     d MakeWdt1        pr             7  0 extproc('MakeWdt1')
     d   cc                          10i 0 const
     d   yyww                        10i 0 const
     d   d                           10i 0 const

       // MakeWdt2 - Make Week date (variant 2)
       // Return a new week date from "cc", "yy", "ww" and "d".
       // The returned week date may be an invalid date; this is NOT checked.
       // Return 0 if parameter values are invalid, i.e. they must be
       // between 0-99, 0-99, 1-53 and 1-7, resp.
     d MakeWdt2        pr             7  0 extproc('MakeWdt2')
     d   cc                          10i 0 const
     d   yy                          10i 0 const
     d   ww                          10i 0 const
     d   d                           10i 0 const

       // MakeWdt3 - Make Week date (variant 3)
       // Return a new week date from "yyww" and "d".
       // The returned week date may be an invalid date; this is NOT checked.
       // Return 0 if parameter values are invalid, i.e. they must be
       // between 0-9953 and 1-7, resp.
       // The century is calculated using "YY2YYYY".
     d MakeWdt3        pr             7  0 extproc('MakeWdt3')
     d   yyww                        10i 0 const
     d   d                           10i 0 const

       // SplitWdt - Split Week date
       // Return the components of week date "wdt" (yyyywwd) via
       // parameters "yyyy", "ww" and "d".
     d SplitWdt        pr                  extproc('SplitWdt')
     d   wdt                          7  0 const
     d   yyyy                        10i 0       options(*nopass:*omit)
     d   ww                          10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

       // SplitWdt1 - Split Week date (variant 1)
       // Return the components of week date "wdt" (ccyywwd) via
       // parameters "cc", "yyww", and "d".
     d SplitWdt1       pr                  extproc('SplitWdt1')
     d   wdt                          7  0 const
     d   cc                          10i 0       options(*nopass:*omit)
     d   yyww                        10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

       // SplitWdt2 - Split Week date (variant 2)
       // Return the components of week date "wdt" (ccyywwd) via
       // parameters "cc", "yy", "ww", and "d".
     d SplitWdt2       pr                  extproc('SplitWdt2')
     d   wdt                          7  0 const
     d   cc                          10i 0       options(*nopass:*omit)
     d   yy                          10i 0       options(*nopass:*omit)
     d   ww                          10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

       // SplitWdt3 - Split Week date (variant 3)
       // Return the components of week date "wdt" (ccyywwd) via
       // parameters "yyww" and "d".
     d SplitWdt3       pr                  extproc('SplitWdt3')
     d   wdt                          7  0 const
     d   yyww                        10i 0       options(*nopass:*omit)
     d   d                           10i 0       options(*nopass:*omit)

       // IsLeapYear - Is Leap Year
       // Return *on if "yyyy" is a leap year, else return *off.
     d IsLeapYear      pr              n   extproc('IsLeapYear')
     d   yyyy                        10i 0 const

       // YY2YYYY - yy to yyyy
       // Return the 4-digit year representing the 2-digit year "yy",
       // using "CCutoffYear".
     d YY2YYYY         pr             4  0 extproc('YY2YYYY')
     d   yy                           2  0 const

       // CrtTimestamp9 - Create Timestamp 9
       // Return a 9-digit number based on the current time.
       // The format of the returned number is "hhmmsszzz", where zzz
       // is the number of milliseconds.
     d CrtTimestamp9   pr             9  0 extproc('CrtTimestamp9')

       // IsWorkday - Is Workday
       // Return *on if "date" and/or week date "wkdate" is a workday,
       // as specified in table CSYSBASEF2, else return *off.
       // This procedure uses "RtvNwdType" to retrieve to nwd type for
       // "date" and/or "wkdate".
       // At least one of the parameters "date" or "wkdate" must be given,
       // preferably both (see the description for procedure "RtvNwdType").
       // If none of the parameters "date" or "wkdate" are given then the
       // procedure does nothing and immediately returns *off.
       //
       // --------------------------------------------------------------------
       // |                                                                  |
       // |     IF "wkdate" IS INVALID, THE RESULT WILL BE UNPREDICTABLE     |
       // |                                                                  |
       // --------------------------------------------------------------------
       //
     d IsWorkday       pr              n   extproc('IsWorkday')
     d   date                          d   const options(*nopass:*omit)
     d   wkdate                       7  0 const options(*nopass:*omit)

       // AddWorkdays - Add Workdays
       // Return a new date after adding "days" workdays to "date". If
       // parameter "days" is negative then the new date will be less than
       // "date".
       // By default, days which are non-workdays as specified in table
       // CSYSBASEF2 are skipped and not counted. However, with parameters
       // "s1".."s6" this behavior can be changed to skip one or more expli-
       // citly specified weekdays instead of the non-workdays specified
       // in CSYSBASEF2.
       // One or more of the parameters "s1".."s6" can be given with a value
       // from 1 (monday) to 7 (sunday) to specify that one or more weekdays
       // must be skipped. For example values 6 and 7 will skip the week-end
       // days. Parameters "s1".."s6" with a value less than 1 or greater than
       // 7 are ignored. The same value can be passed more than once, with no
       // effect.
       // If one or more of the parameters "s1".."s6" are given then the
       // non-workdays as specified in table CSYSBASE are never used, even
       // if the given values are invalid. E.g., if only parameter "s1" is
       // given with value 0 then no days are skipped at all and the procedure
       // functions the same as expression "date + %days(days)".
       // If the year of "date" is less than 2 or greater than 9998 then "date"
       // is simply returned.
       // If the calculated gregorian date lies before week date 0002-01-1
       // (year 2, week 1, day 1) then the gregorian date corresponding to
       // this week date is returned.
       // If the calculated gregorian date lies after week date 9998-lw-7
       // (year 9998, last week of 9998, day 7) then the gregorian date
       // corresponding to this week date is returned.
     d AddWorkdays     pr              d   extproc('AddWorkdays')
     d   date                          d   const
     d   days                        10i 0 const
     d   s1                          10i 0 const options(*nopass)
     d   s2                          10i 0 const options(*nopass)
     d   s3                          10i 0 const options(*nopass)
     d   s4                          10i 0 const options(*nopass)
     d   s5                          10i 0 const options(*nopass)
     d   s6                          10i 0 const options(*nopass)

       // GetNwdtName - Get Non-workday type Name
       // Return the name of non-workday type "nwdt".
       // Return blanks if the type does not exist.
     d GetNwdtName     pr            50    extproc('GetNwdtName')
     d   nwdt                         1    const

       // RtvNwdType - Retrieve Non-Workday Type
       // Return the type (NWDTYPE) of "date" and/or week date "wkdate",
       // as specified in table CSYSBASEF2.
       // Either parameter "date", or "wkdate", or both can be provided
       // to determine the right nwd type. Both are necessary to determine
       // the right nwd type. If one is not provided it is calculated with
       // procedure "Gdt2Wdt" or "Wdt2Gdt".
       // If "wkdate" is not provided the year of "date" must be between 2
       // and 9998. If not then '' is returned.
       // For efficiency, the contents of table CSYSBASEF2 is loaded into
       // memory incrementally. The records for one year are all loaded into
       // memory when needed. In principle, each year is loaded only once
       // (while the program is activated). However, only the last two digits
       // of the 4-digit year are significant in this respect (the century is
       // ignored). E.g., when this procedure is called the first time after
       // program activation with a date in year 2010 it will load all records
       // for year 2010 into memory. Then it is called with a date in year
       // 2011 and it loads all records for year 2011 into memory. Both years
       // are now in memory and do not need to be loaded again. In practice,
       // most of the times only 1 maybe 2 or 3 years will be loaded into
       // memory. However, because only the last two digits of the (4-digit)
       // year are significant, if this procedure is called again with a date
       // in year 1910 and 2010 is already loaded, it will replace the records
       // of 2010 with the ones of 1910. Therefore, the worst case performance
       // wise is when this procedure is called many times where each successive
       // date is in the same year but in another century, which causes this
       // "thrashing" of memory. In practice this is unlikely to happen. The
       // records for year 0000 however are always loaded only once.
       // Call this procedure with no parameters to release (free) all memory
       // containing the loaded records. If this procedure is called again,
       // the records are loaded into memory again.
       // If "date" is *loval it is considered as "not provided". Likewise, if
       // "wkdate" < 1 it is considered as "not provided".
       //
       // --------------------------------------------------------------------
       // |                                                                  |
       // |     IF "wkdate" IS INVALID, THE RESULT WILL BE UNPREDICTABLE     |
       // |                                                                  |
       // --------------------------------------------------------------------
       //
     d RtvNwdType      pr             1    extproc('RtvNwdType')
     d   date                          d   const options(*nopass:*omit)
     d   wkdate                       7  0 const options(*nopass:*omit)

