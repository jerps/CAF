
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module AM for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Application Messages


       // All available messages are contained in compile-time array "AppMsg",
       // defined in the module. Each message text starts with its unique
       // 4-digit number, a colon and a space.

       // The first element of "AppMsg" contains the array length (the first
       // three characters) and the number of elements (the next four chars).


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASEAM

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL_AM
      /include CSYSBASES,INCL_API

      /include CAPPBASES,INCL__AM

      /include CAPPBASES,INCL__MODD


       // Subsystem id.
     d Subsysid        c                   'AB'


       // Application messages.
     d AppMsg          s            100    ctdata dim(500)


       // ----- Implementation


     p RtvAMsgAB       b                   export
     d RtvAMsgAB       pi           200
     d   id                           4  0 const
     d   sev                          1    const         options(*nopass:*omit)
     d   subst1                     200    const varying options(*nopass)
     d   subst2                     200    const varying options(*nopass)
     d   subst3                     200    const varying options(*nopass)
     d   subst4                     200    const varying options(*nopass)
     d   subst5                     200    const varying options(*nopass)
     d   subst6                     200    const varying options(*nopass)
     d   subst7                     200    const varying options(*nopass)
     d   subst8                     200    const varying options(*nopass)
     d   subst9                     200    const varying options(*nopass)

     d msg             s            200

      /free

       msg = GetBuffldId(%addr(AppMsg):%editc(id:'X'));
       if msg = '';
         msg = *all'?';
         %subst(msg:1:%len(id)) = %editc(id:'X');
       endif;
       select;
       when %parms > 10;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6:subst7:subst8:subst9);
       when %parms > 9;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6:subst7:subst8);
       when %parms > 8;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6:subst7);
       when %parms > 7;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6);
       when %parms > 6;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5);
       when %parms > 5;
         msg = SubstText(msg:subst1:subst2:subst3:subst4);
       when %parms > 4;
         msg = SubstText(msg:subst1:subst2:subst3);
       when %parms > 3;
         msg = SubstText(msg:subst1:subst2);
       when %parms > 2;
         msg = SubstText(msg:subst1);
       endsl;
       if     %parms > 1
          and %addr(sev) <> *null
          and sev <> '';
         return Subsysid + sev + msg;
       else;
         return Subsysid + CAmsInfo + msg;
       endif;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModAM       b                   export
     dI_RlsModAM       pi

      /free

       return;

      /end-free
     p                 e


** AppMsg
1000500

1001: End of data reached; try refresh or reposition.
1002: No data to display; try refresh or reposition.
1003: Invalid option.
1004: Press %1 again to CONFIRM.
1005: First page already displayed; try refresh or reposition.
1006: First page has been read.
1007: Can not reposition with other actions pending.
1008: Reposition ignored.
1009: No data found; try refresh or reposition.
1010: Function key (currently) not supported; press F1 for help.
1011: First page.
1012: Last page.
1013: Data record not found; try refresh.
1014: Data record has been read.
1015: Selection is currently not supported for this cursor location.
1016: Selection has been filled in.
1017: End of data reached.
1018: Data record NOT UPDATED.
1019: Data record UPDATED.
1020: Data record NOT DELETED.
1021: Data record DELETED.
1022: Press F14 twice to delete data record.
1023: Press F14 again to CONFIRM DELETE.
1024: Data record already exists.
1025: Selection is currently not supported.
1026: Press ENTER to add new data record.
1027: Data record NOT ADDED.
1028: Data record ADDED.
1029: Data record has been DELETED BY ANOTHER USER OR PROCESS.
1030: Data record has been UPDATED BY ANOTHER USER OR PROCESS.
1031: Data has been changed on screen; press F5 again to CONFIRM REFRESH.
1032: Data has been changed on screen; press F9 again to CONFIRM RESIZE/REFRESH.
1033: Data record NOT COPIED.
1034: Data record COPIED.
1035: READING THE SAME DATA; Use F5 to execute the query again.
1036: Number contains invalid characters, or has too many (decimal) digits.
1037: Data record already deleted.
1038: Data record UPDATED; please review warning/info messages with F22.
1039: Data record DELETED; please review warning/info messages with F22.
1040: Data record ADDED; please review warning/info messages with F22.
1041: Data record COPIED; please review warning/info messages with F22.
1042: Only one data record can be selected.
1043: Can not select a data record if other options are entered.
1044: Can not delete a data record if other options are entered.
1045: Can not copy a data record if other options are entered.
1046: The display device currently does not support *WIDE mode.
1047: ?
1048: Option "%1" is allowed only once with no other options.
1049: No options are allowed.
1050: Last page is blank; can not add new blank page.
1051: Invalid positioning key.
1052: Value "%1" is not a number, or the number of digits is incorrect.
1053: No value provided, or it is invalid.
1059: Nothing selected.
1061: Cursor is out of designated area; relocate cursor and try again.
1062: Cursor is not on a data line; relocate cursor and try again.
1063: Function is currently not supported for this cursor location.
1071: Press F5 again to CONFIRM REFRESH (new screen data is lost).
1072: Press F9 again to CONFIRM RESIZE/REFRESH (new screen data is lost).
1073: Press %1 again to CONFIRM (new screen data is lost).
1081: Only one page to display.
1091: Please wait . . .


1100: Database query in progress . . .  %1
1101: SQL ERROR: could not bind result set (SEE JOB LOG). SqlsStatus=%1, SSID=%2
1102: SQL ERROR: no cursor. SqlsStatus=%1, SSID=%2
1103: SQL ERROR: could not execute query (SEE JOB LOG). SqlsStatus=%1, SSID=%2
1105: SQL ERROR: could not retrieve SQL stmt or stmt too long. SSID=%1
1106: SQL ERROR: statement should not return a cursor. SqlsStatus=%1, SSID=%2
1107: SQL ERROR: could not fetch next row (SEE JOB LOG). SqlsStatus=%1, SSID=%2
1108: SQL ERROR: wrong statement; does not start with "%1". SSID=%2
1111: SQL ERROR: SSID=%1

1121: ERROR executing query (SEE JOB LOG).
1122: ERROR fetching next row (SEE JOB LOG).

1131: Data record "%1" already exists; can not add.
1132: Data record "%1" not found; can not update.
1133: Data record "%1" not found; can not delete.

1201: No updates; nothing to save.
1202: No actions have been performed.
1211: Repositioned.
1280: Data records add/upd/del: %1/%2/%3.
1281: Copied %1 data records.
1290: Processing was cancelled by user.
1291: Delete was cancelled by user.

1801: Unrecognized option "%1".
1802: Unrecognized return code "%1".

1900: Error reading data items.
1901: Can not display more than 9999 data records.
1991: Unsupported function.

2500: Normal end.
2501: Exited.
2502: Cancelled.
2507: Nothing updated/deleted.
2510: Data record selected.
2511: Normal end; exited.
2512: Normal end; cancelled.
2530: An unspecified error occurred.
2531: Illegal parameter value.
2532: Function not allowed.
2533: Program fault.

3001: Processed all %1 files without errors.
3002: Processing stopped because of error %1; %2 files processed.
3003: Processing stopped because of error %1, reason %2; %3 files processed.

3102: Copied %1 files to local directory %2.

5000: Invalid value.
5001: Field can not be blank.
5002: First character can not be blank.
5003: Key already exists.
5004: Item does not exist.
5011: Field must have a value greater than 0.
5012: Enter a number from %1 to %2.
5013: Enter a number greater than zero.
5021: The combination of these values is not valid.

5101: Enter "Y" for yes, or "N" for no.
5102: Duplicates are not allowed.
5103: Enter "Y", "N" or blank.


60..: GENERIC ERRORS
61..: ""
62..: ""

6001: Date %1 is not a work day.

6290: Program parameter error.


7...: APPLICATION SPECIFIC
8...: APPLICATION SPECIFIC

-- Non-Work Days --
7001: Specify (part of) a gregorian date (mm-dd) OR a week date (ww-d).
7002: Do not specify both a gregorian date (mm-dd) and a week date (ww-d).
7003: Non-work day type "%1" does not exist.
7004: Not allowed to update or delete "special" type "%1".


9...: GENERIC (SEVERE) TECHNICAL ERRORS

9001: Can not add new record; maximum sequenceno. reached.

9100: DATABASE ERROR (see job log); pgm status/exc = %2/%3.
9101: ERROR trying to access table "%1"; pgm status/exc = %2/%3.
9102: ERROR trying to update record "%1" in table "%2".
9104: ERROR trying to delete record "%1" in table "%2".
9106: ERROR trying to write record "%1" to table "%2".
9111: ERROR trying to access table "%1".
9112: ERROR trying to update record in table "%1".
9114: ERROR trying to delete record in table "%1".
9116: ERROR trying to write record to table "%1".
9120: ERROR assigning db fields (table %1, pgm status %2).
9151: Record %1 not found in table %2.

9901: PROGRAM STATUS: %1
9990: PROGRAM ERROR: status/exc = %1/%2.
9991: %1
9992: %1: %2
9993: Error %1; see other messages.
9995: WARNING: %1
9999: ERROR: %1

