
       // (c) 2019 John Erps
       // This software is licensed under MIT (see LICENSE)


       // CAF - SQL Statements: Detail


       // WARNING:
       // This program executes SQL using service program CSYSSQLS.
       // See member CSYSSQLS/INCL_RM for detailed info about some issues.
       // This program DOES NOT release service program CSYSSQLS when it ends.
       // This may cause an exception if this program is the first one on
       // the call stack using this service program, and it is ended, and
       // then called again.


       // Pass 6 parameters:

       //   1 I  (10)    : Mode.
       //                    *ADD     - Add a new data record. Input/Output
       //                               parms contain the (partial) new key on
       //                               program start, and the new full key
       //                               on program end.
       //                    *DISPLAY - Data record is displayed only and can
       //                               not be updated or deleted. Input parms
       //                               contain the existing full key.
       //                    *UPDATE  - Data record can be updated but not
       //                               deleted. Input parms contain the
       //                               existing full key.
       //                    *DELETE  - Data record can be deleted but not
       //                               updated. Input parms contain the
       //                               existing full key.
       //                    *COPY    - Data record is displayed and can be
       //                               updated to add a new data record.
       //                               Input/Output parms contain the existing
       //                               full key on program start, and the new
       //                               full key on program end.

       //   2 I  (10)    : Special behavior codes.
       //                  This field can contain one or more letters listed
       //                  below to indicate special behaviors. Letters not
       //                  listed here are ignored.
       //                    A - Keep the program active; do NOT end the
       //                        program on ENTER. Normally, the program is
       //                        ended when the data record has been added,
       //                        updated, deleted or copied without issues,
       //                        or if the ENTER key is pressed and there are
       //                        no pending actions. With this special behavior
       //                        the only way to end the program is to press
       //                        F3 or F12.
       //                    V - Force DSPMOD(*NORMAL) on program init.
       //                    W - Force DSPMOD(*WIDE) on program init.
       //                    X - Do not allow resize/refresh (F9).

       //   3 O  (2,0)   : Return code (ERROR if >=30)
       //                    00 - Program ended normally:
       //                           mode *ADD:    data record has been added
       //                                         and output parms contain the
       //                                         key of the new data record;
       //                           mode *UPDATE: data record has been updated;
       //                           mode *DELETE: data record has been deleted;
       //                           mode *COPY:   data record has been added
       //                                         and output parms contain the
       //                                         key of the new data record.
       //                    01 - F3 key was pressed (exit)
       //                         and NOTHING ADDED/UPDATED/COPIED/DELETED.
       //                    02 - F12 key was pressed (cancel)
       //                         and NOTHING ADDED/UPDATED/COPIED/DELETED.
       //                    07 - Only when mode *UPDATE or *DELETE.
       //                         Special behavior A was NOT specified, the
       //                         program ended with ENTER, and the data
       //                         record has NOT been UPDATED/DELETED.
       //                    11 - Like 00, but user pressed F3 to exit with
       //                         "IdleState" *on.
       //                    12 - Like 00, but user pressed F12 to exit with
       //                         "IdleState" *on.
       //                    30 - An unspecified error occurred.
       //                    31 - Illegal parameter value.
       //                    32 - Function not allowed.
       //                    33 - Program fault.

       //   4 O  (100)   : Return message 1 (error).
       //   5 O  (100)   : Return message 2 (cause).

       //   6 IO ( 20)   : SQLSID - SQL Statement ID


       // Binding directories.
       // Release all service programs at the end of main by calling the
       // "RlsSp*" procedure for each. Be sure to do this in the correct
       // order, i.e. highest level first and lowest level last.
     h bnddir(
     h             'CAPPDISP'
     h            :'CAPPBASE'
     h            :'CSYSSQLS'
     h            :'CSYSBASE'
     h       )

      /include QINCSRC,DPGM_HEAD


     fCAFSQLSD  cf   e             workstn infds(WSI)
     f                                     sfile(DFSCREEN1S:SFLR1#)

     fCSYSSQLSF1uf a e           k disk


       // ----- Includes

      /include QINCSRC,CAFSQLSD

      /include CAPPDISPS,INCL_API
      /include CAPPBASES,INCL_API
      /include CSYSSQLSS,INCL_API
      /include CSYSBASES,INCL_API


       // ----- Constants

       // The minimum number of parameters needed by this program.
     d MinPgmParms     c                   6

       // Number of screens.
     d NumScreens      c                   1
       // Number of lines in a page in subfile 1 (screen 1) in *NORMAL mode.
     d SflPagelen1     c                   15
       // Row with the top line of a page in subfile 1 (screen 1).
     d SflTopline1     c                   6
       // Maximum no of lines for an SQL statement.
     d MaxSqlLines     c                   999

       // Row on which to display the bottom message (*NORMAL and *WIDE).
     d MsgRowNormal    c                   22
     d MsgRowWide      c                   25


       // ----- External Data Structures

      /IF NOT DEFINED(ERF_CSYSSQLSF1)
      /DEFINE ERF_CSYSSQLSF1
     dErfCSYSSQLSF1  e ds                  extname(CSYSSQLSF1)
      /ENDIF


       // ----- Internal Data Structures

      /include QINCSRC,DS_PSI


       // Data record key.
     d DrKey           ds                  qualified inz
     d   f1                                like(TSQLS_ID)

       // Data structure "DChgDspFlds" and field "DChgDspFldsF" are used
       // in add/update/copy mode to detect changes in an editable field
       // on screen. Ds "DChgDspFlds" MUST CONTAIN A SUBFIELD FOR EACH
       // EDITABLE DISPLAY FIELD, having the same name and type as in the
       // display format. Editable fields in subfiles must be handled
       // seperately.
     d DChgDspFlds     ds
     d   D_SID                             like(TSQLS_ID)
     d DChgDspFldsF    s                   like(DChgDspFlds)

       // Error structure.
       // For convenience, use local procedures "L_SetErr" and "L_AddErrFld".
     d Err             ds                  qualified inz
         // *on if an error occurred, else *off.
     d   e                             n
         // names of fields/attributes in error.
     d   flds                        12    dim(40)


       // ----- Arrays

       // Array "FEMap" associates field/attribute names with error indicators
       // *in31-*in69. A question mark ("?") in a name means that the position
       // matches any character. The first name which matches a field/attribute
       // name (case sensitive) determines the indicator to be set to *on.
       // Execute subr. "SetErrFldsInd" to set error indicators according to
       // the names in array "Err.flds" (see above).
     d FEMap           s             14    ctdata dim(50)
       // Cursor locations.
     d CursLocs        s              7    ctdata dim(50)
       // Texts
     d Text            s             80    ctdata dim(50)
       // Function key texts
     d FunText         s             60    ctdata dim(50)


       // ----- Fields/Vars

       // Number of parameters passed to this program.
     d Parms#          s             10i 0

       // Program activated.
     d PgmActivated    s               n   inz(*off)

       // Return code/message1/2 to be returned to caller.
     d Rtncd           s              2  0
     d Rtnmsg1         s            100
     d Rtnmsg2         s            100

       // Modes:
     d ModeAdd         s               n
     d ModeDisplay     s               n
     d ModeUpdate      s               n
     d ModeDelete      s               n
     d ModeCopy        s               n

       // Special behaviors:
       // - SbKeepActive : Keep program active.
       // - SbDspiNorm   : Force DSPMOD(*NORMAL) on program init.
       // - SbDspiWide   : Force DSPMOD(*WIDE) on program init.
       // - SbNoResize   : Do not allow resize/refresh (F9).
     d SbKeepActive    s               n
     d SbDspiNorm      s               n
     d SbDspiWide      s               n
     d SbNoResize      s               n

       // Display mode *WIDE if *on.
     d DspWide         s               n
       // Current screen rows and columns.
     d ScreenRows      s             10i 0
     d ScreenCols      s             10i 0
       // The screen to be displayed/processed (0 = exit).
     d Screen          s             10i 0
       // Previous screen.
     d PrevScreen      s                   like(Screen)
       // Recno for subfile n.
     d SFLR1#          s              5  0
       // Recno total for subfile n.
     d SFLR1#T         s              5  0

       // If "IdleState" is *on the program is in special "idle" state,
       // which means that the program only performs basic behavior like
       // pageup/pagedown, F1, F22, etc. In this mode nothing is processed,
       // or read from the database. The only meaningful actions the user
       // can do is pressing ENTER, F3 or F12 to end the program. Pressing
       // ENTER however does not end the program if special behavior "A"
       // is specified. The program always goes into idle state after subr.
       // "PcsScreen" is successfully executed, i.e. without fatal errors.
       // However, if special behavior "A" is not specified the program will
       // end immediately after subr. "PcsScreen" executed successfully,
       // unless indicator "StayActive" is set to *on in subr. "PcsScreen".
     d IdleState       s               n

       // The primary (error)message, to be displayed at the bottom, in
       // "ExScreen". This field is always cleared automatically, after
       // "ExScreen", with "CAPPBASE/ClrDspMsgs" (see below).
       // For convenience, use local procedures "L_SetErr" and "L_AddErrFld"
       // to set the "Err" data structure and "DspMsg" in one go in case
       // of an error.
       // NOTE: This field is defined in and exported from *SRVPGM CAPPBASE.
     d DspMsg          s            130            import('DspMsg')

       // A list of max. 99 supplementary (error)messages, to be displayed
       // in "ExScreen", like "DspMsg". This array is also always cleared
       // automatically, after "ExScreen". Field "DspMsg", together with
       // "DspMsgList" can be considered as one list with max. 100 messages,
       // where "DspMsg" is the first one, and "DspMsgList(1)" the second.
       // The first message in this list (either "DspMsg" or "DspMsgList(1)")
       // is displayed at the bottom, in "ExScreen". The last message in
       // "DspMsgList" is by definition in the element just before the first
       // blank element. Thus, if "DspMsgList(1)" is blank then the array is
       // considered to contain no messages at all. If "DspMsgList(1)" and
       // "DspMsg" are both not blank, or "DspMsgList(1)" and "DspMsgList(2)"
       // are both not blank, a "+" at the right of the displayed message at
       // the bottom is shown to indicate more messages. The user may press
       // F22 to display all messages within a pageable window, which includes
       // "DspMsg" (displayed at the top).
       // NOTES:
       //   - Use "CAPPBASE/ClrDspMsgs" to clear all messages, including
       //     "DspMsg".
       //   - Use "CAPPBASE/AddToDspMsgList" to place a message into the
       //     first non-blank element of "DspMsgList".
       //   - Array "DspMsgList" is defined in and exported from *SRVPGM
       //     CAPPBASE.
     d DspMsgList      s            130    dim(99) import('DspMsgList')

       // Is set to *on in "ExScreen" if there are more messages to display,
       // i.e. a "+" is shown on the right of the displayed message at the
       // bottom.
     d MoreMsgs        s               n

       // Is set to *on in subr. "PcsScreen" if processing executed success-
       // fully (no fatal errors), but the program should not end immediately
       // and should stay active in "idle state". E.g. because there are
       // warning or informational messages which should be reviewed by the
       // user first.
     d StayActive      s               n

       // The statusmessage to be displayed at the bottom row, in "ExScreen",
       // but only if "StatMsg <> *BLANKS", and "StatMsg <> DspMsg" and
       // "StatMsg <> DspMsgList(1)". This field is NOT cleared automatically.
       // NOTE: the statusmessage replaces the second line with function
       // key information, which is normally displayed at the bottom row.
     d StatMsg         s            130

       // The row on the screen on which to display the bottom message,
       // determined in subr. "CalcScrSizes".
     d DspMsgRow       s             10i 0

       // Cursor location on last input operation (exfmt).
     d CursRow         s             10i 0
     d CursCol         s             10i 0

       // If *on, set cursor on location "CursRow"/"CursCol" on next
       // display output operation (exfmt).
     d SetCurs         s               n

       // Is set to *on in display/update/delete/copy mode if the data record
       // has been found (and read). It should always be *off in add mode.
     d DataFound       s               n

       // Is set to *on in add/update/copy mode if one or more editable
       // display fields (D_*) have been changed since the last execution
       // of subr. "InitDspFlds" or "DataToDspFlds". It should always be
       // *off if not in add, update or copy mode.
     d ChgDspFld       s               n

       // Press key again to confirm if *off.
     d ConfirmExit     s               n
     d ConfirmCancel   s               n
     d ConfirmRefresh  s               n
     d ConfirmResize   s               n
     d ConfirmDelete   s               n

       // Header displayed on screen.
     d HdrText         s            100
       // Subfile options or function keys to be displayed on screen.
     d DspOpts         s           1056
       // Current subfile page length (number of rows).
     d PgLen           s             10i 0
       // Screen row of the first record of the current subfile page.
     d PgTopl          s             10i 0
       // A message.
     d Msg             s            130
       // A message number.
     d Msg#            s             10i 0
       // Subfile record#
     d SflRec          s             10i 0

       // Number of "options" parts (see "AddToAppOpts").
     d OptsNum         s             10i 0
       // Current "options" part.
     d Opts#           s             10i 0

       // Standard program parameter fields.
     d Pmode           s             10
     d Pspcbhvr        s             10
     d Prc             s                   like(Rtncd)
     d Prm1            s                   like(Rtnmsg1)
     d Prm2            s                   like(Rtnmsg2)

       // Original input parameter values.
     d Imode           s             10
     d Ispcbhvr        s             10


       // ----- MAIN Prototype

     d MAIN            pr


       // ----- Local Prototypes

      /include QINCSRC,DPGM_LPP


       // ----- Program Entry

     d PgmCAFSQLSD     pi
     d   @@Mode                      10    const
     d   @@Spcbhvr                   10    const
     d   @@Rtncd                      2  0
     d   @@Rtnmsg1                  100
     d   @@Rtnmsg2                  100
     d   @@Sqlsid                                like(TSQLS_ID)

      /free

       *inLR = *on;

       Parms# = %parms;

       if Parms# > 2;
         @@Rtncd = 0;
       endif;
       if Parms# > 3;
         @@Rtnmsg1 = '';
       endif;
       if Parms# > 4;
         @@Rtnmsg2 = '';
       endif;

       Rtncd = 0;
       Rtnmsg1 = '';
       Rtnmsg2 = '';

       MAIN();

       if    ModeAdd
          or ModeCopy;
         // Set output parameters in add/copy mode.
         if    Rtncd = 0
            or Rtncd = 11
            or Rtncd = 12;
           // Set output parameters to new key.
           @@Sqlsid = DrKey.f1;
         else;
           // Clear output parameters.
           clear @@Sqlsid;
         endif;
       endif;

       // Release all resources.
       RlsSpCAPPDISP();
       RlsSpCAPPBASE();
       RlsSpCSYSBASE();

       if Parms# > 2;
         @@Rtncd = Rtncd;
       endif;
       if Parms# > 3;
         @@Rtnmsg1 = Rtnmsg1;
       endif;
       if Parms# > 4;
         @@Rtnmsg2 = Rtnmsg2;
       endif;

       return;


      /end-free


     p MAIN            b
     d MAIN            pi

     d flag            s               n
     d n               s             10i 0
     d x               s             10i 0
     d sqlLine1        s                   like(D_SLINE)
     d sqlLine2        s                   like(D_SLINE)

      /free


       dou 0=0;

       if not PgmActivated;
         PgmActivated = *on;
         exsr Activate;
         if Rtncd <> 0;
           leave;
         endif;
       endif;

       exsr Init;
       if Rtncd <> 0;
         leave;
       endif;

       dow Screen <> 0;

         // Check if display mode *WIDE is supported.
         if     DspWide
            and not IsDspModeWideSupported();
           DspWide = *off;
           PushDspMsgs(RtvAMsgAB(1046:CAmsWarning));
         endif;

         // Make sure the first message is in "DspMsg" and up.
         DropDspMsgs();

         // Calculate current screen sizes.
         exsr CalcScrSizes;

         ChgDspFld = *off;

         if not IdleState;
           // Read associated data (to display).
           exsr RdAssocData;
         endif;

         // Execute screen / subfile.
         exsr ExScreen;

         if not IdleState;
           clear Err;       // Clear error data.
           ClrDspMsgs();    // Clear (error)messages.
           MoreMsgs = *off; // No more messages.
         endif;

         if not KeyPressed(KsF03);
           ConfirmExit = *off;
         endif;
         if not KeyPressed(KsF05);
           ConfirmRefresh = *off;
         endif;
         if not KeyPressed(KsF09);
           ConfirmResize = *off;
         endif;
         if not KeyPressed(KsF12);
           ConfirmCancel = *off;
         endif;
         if not KeyPressed(KsF14);
           ConfirmDelete = *off;
         endif;

         PrevScreen = Screen;

         // RETAIN CURSOR LOCATION BY DEFAULT
         SetCurs = *on;

         if     (   KeyPressed(KsPageDown)
                 or KeyPressed(KsPageUp))
            and Screen = 1
            and CursRow >= PgTopl
            and CursRow <  PgTopl + PgLen;
           // Pagedown/up pressed on SQL lines.
           if     KeyPressed(KsPageDown)
              and not IdleState
              and (   ModeAdd
                   or ModeUpdate
                   or ModeCopy);
             // Pagedown pressed in add/update/copy mode; add blank page.
             exsr SflAddBlankPage;
           elseif KeyPressed(KsPageDown);
             DspMsg = RtvAMsgAB(1012);
           elseif KeyPressed(KsPageUp);
             DspMsg = RtvAMsgAB(1011);
           endif;
         elseif     (   KeyPressed(KsF06)
                     or KeyPressed(KsF14))
                and not IdleState
                and (   ModeAdd
                     or ModeUpdate
                     or ModeCopy)
                and Screen = 1
                and CursRow >= PgTopl
                and CursRow <  PgTopl + PgLen;
           // F6 or F14 pressed pressed in add/update/copy mode
           // on SQL lines page; insert or delete one line.
           exsr InsertOrDeleteSqlLine;
         //elseif KeyPressed(KsPageDown);   >>ONLY ONE SCREEN<<
         //  // Pagedown pressed; next screen.
         //  if Screen < NumScreens;
         //    Screen = Screen + 1;
         //  else;
         //    Screen = 1;
         //  endif;
         //  SetCurs = *off; // Do not retain cursor location.
         //elseif KeyPressed(KsPageUp);   >>ONLY ONE SCREEN<<
         //  // Pageup pressed; previous screen.
         //  if Screen > 1;
         //    Screen = Screen - 1;
         //  else;
         //    Screen = NumScreens;
         //  endif;
         //  SetCurs = *off; // Do not retain cursor location.
         elseif KeyPressed(KsF03);
           // F03 pressed; exit program (if confirmed).
           if ConfirmExit;
             ConfirmExit = *off;
             if IdleState;
               Rtncd = 11;
             else;
               Rtncd = 1;
             endif;
             Screen = 0;
           else;
             ConfirmExit = *on;
             DspMsg = RtvAMsgAB(1004:CAmsInfo:'F3');
           endif;
         elseif     KeyPressed(KsF04)
                and not IdleState;
           // F04 pressed; select item.
           exsr SelectItem;
         elseif     KeyPressed(KsF05)
                and not IdleState;
           // F05 pressed; refresh data.
           if    not ChgDspFld
              or ConfirmRefresh;
             ConfirmRefresh = *off;
             if ModeAdd;
               exsr InitDspFlds;
             else;
               exsr DataToDspFlds;
             endif;
             SetCurs = *off; // Do not retain cursor location.
           else;
             // Data has been changed on screen; confirm.
             ConfirmRefresh = *on;
             DspMsg = RtvAMsgAB(1031);
           endif;
         elseif     KeyPressed(KsF09)
                and not SbNoResize
                and not IdleState;
           // F09 pressed; switch screen size & refresh
           if    not ChgDspFld
              or ConfirmResize;
             ConfirmResize = *off;
             DspWide = not DspWide;
             if ModeAdd;
               exsr InitDspFlds;
             else;
               exsr DataToDspFlds;
             endif;
             SetCurs = *off; // Do not retain cursor location.
           else;
             // Data has been changed on screen; confirm.
             ConfirmResize = *on;
             DspMsg = RtvAMsgAB(1032);
           endif;
         elseif KeyPressed(KsF12);
           // F12 pressed; cancel program (if no changes or confirmed).
           if    not ChgDspFld
              or ConfirmCancel;
             ConfirmCancel = *off;
             if IdleState;
               Rtncd = 12;
             else;
               Rtncd = 2;
             endif;
             Screen = 0;
           else;
             ConfirmCancel = *on;
             DspMsg = RtvAMsgAB(1004:CAmsInfo:'F12');
           endif;
         elseif     (   KeyPressed(KsF17)
                     or KeyPressed(KsF18))
                and Screen = 1
                and CursRow >= PgTopl
                and CursRow <  PgTopl + PgLen;
           // F17/F18 pressed on SQL lines; go to first/last page.
           D__CURREC = 1;
           if     KeyPressed(KsF18)
              and SFLR1#T > PgLen;
             D__CURREC = SFLR1#T - Pglen + 1;
           endif;
         elseif    KeyPressed(KsEnter)
                or     ModeDelete
                   and KeyPressed(KsF14)
                   and not IdleState;
           // Enter or F14 pressed.
           if     not IdleState
              and (   ModeAdd
                   or ModeCopy
                   or     ModeUpdate
                      and ChgDspFld
                   or     ModeDelete
                      and KeyPressed(KsF14));
             // Validate and process screen.
             if    ModeAdd
                or ModeCopy
                or DataFound;
               // Validate screen.
               exsr ValScreen;
               if not Err.e;
                 // No errors; process screen.
                 if     KeyPressed(KsF14)
                    and not ConfirmDelete;
                   // F14 must be pressed twice to delete data record.
                   ConfirmDelete = *on;
                   DspMsg = RtvAMsgAB(1023);
                 else;
                   // Process screen.
                   ConfirmDelete = *off;
                   exsr PcsScreen;
                   if Err.e;
                     // Errors.
                     if DspMsg = '';
                       // Set informational message.
                       select;
                       when ModeAdd;
                         DspMsg = RtvAMsgAB(1027);
                       when ModeUpdate;
                         DspMsg = RtvAMsgAB(1018);
                       when ModeDelete;
                         DspMsg = RtvAMsgAB(1020);
                       when ModeCopy;
                         DspMsg = RtvAMsgAB(1033);
                       endsl;
                     endif;
                   else;
                     // No errors; program goes to "idle state".
                     IdleState = *on;
                     exsr SflIntoIdleMode;
                     if DspMsg = '';
                       // Set informational message.
                       select;
                       when ModeAdd;
                         DspMsg = RtvAMsgAB(1028);
                       when ModeUpdate;
                         DspMsg = RtvAMsgAB(1019);
                       when ModeDelete;
                         DspMsg = RtvAMsgAB(1021);
                       when ModeCopy;
                         DspMsg = RtvAMsgAB(1034);
                       endsl;
                     endif;
                     if     not SbKeepActive
                        and not StayActive;
                       // End the program.
                       Screen = 0;
                     endif;
                   endif;
                 endif;
               endif;
             else;
               // Not in add/copy mode, and data not found.
               L_SetErr(RtvAMsgAB(1013:CAmsFatal));
             endif;
           elseif     not SbKeepActive
                  and not Err.e
                  and KeyPressed(KsEnter);
             // Enter pressed and no pending actions: end program.
             Screen = 0;
             if     not IdleState
                and (   ModeUpdate
                     or ModeDelete);
               Rtncd = 7;
             endif;
           endif;
         elseif     KeyPressed(KsF14)
                and IdleState;
           // Data record already deleted.
           L_SetErr(RtvAMsgAB(1037:CAmsFatal));
         else;
           // Function key not supported.
           L_SetErr(RtvAMsgAB(1010:CAmsFatal));
         endif;

       enddo;

       enddo;

       return;


       // Perform actions when the program is first activated.
       begsr Activate;

         // Set WSI@ to let service program CSYSBASE access
         // the workstation information in ds WSI.
         WSI@ = %addr(WSI);

       endsr;


       // Initialize program.
       begsr Init;

         clear Err;

         ClrDspMsgs();
         MoreMsgs = *off;
         StatMsg = '';

         Screen = 1;

         CursRow = 1;
         CursCol = 1;
         SetCurs = *off;

         IdleState      = *off;
         StayActive     = *off;
         DataFound      = *off;
         ChgDspFld      = *off;

         ConfirmExit    = *off;
         ConfirmCancel  = *off;
         ConfirmRefresh = *off;
         ConfirmResize  = *off;
         ConfirmDelete  = *off;

         Imode = '';
         Ispcbhvr = '';

         // Check number of parameters.
         if Parms# < MinPgmParms;
           Rtncd = 31;
           Rtnmsg1 =   'This program needs at least '
                     + %char(MinPgmParms) + ' parameters.';
           leavesr;
         endif;

         // Set mode indicators.
         if Parms# > 0;
           Imode = @@Mode;
         else;
           Imode = '*DISPLAY';
         endif;
         ModeAdd     = Imode = '*ADD';
         ModeDisplay = Imode = '*DISPLAY';
         ModeUpdate  = Imode = '*UPDATE';
         ModeDelete  = Imode = '*DELETE';
         ModeCopy    = Imode = '*COPY';
         if     not ModeAdd
            and not ModeDisplay
            and not ModeUpdate
            and not ModeDelete
            and not ModeCopy;
           Rtncd = 31;
           Rtnmsg1 = 'Value of parameter 1 (mode) is unsupported.';
           leavesr;
         endif;

         // Set special behavior indicators.
         if Parms# > 1;
           Ispcbhvr = @@Spcbhvr;
         endif;
         SbKeepActive = %scan('A':Ispcbhvr) > 0;
         SbDspiNorm   = %scan('V':Ispcbhvr) > 0;
         SbDspiWide   = %scan('W':Ispcbhvr) > 0;
         SbNoResize   = %scan('X':Ispcbhvr) > 0;

         if SbDspiNorm;
           DspWide = *off;
         elseif SbDspiWide;
           DspWide = *on;
         else;
           DspWide = IsDspModeWide();
         endif;

         D__CURREC = 1;

         exsr CalcScrSizes;

         if ModeAdd;
           exsr InitDspFlds;
         else;
           exsr DataToDspFlds;
         endif;

       endsr;


       // Read any data that is associated with the current screen.
       begsr RdAssocData;
       endsr;


       // Calculate current screen sizes.
       begsr CalcScrSizes;

         select;
         // when Screen = ?;
         other;
           // Screen 1 is default.
           PgLen = SflPagelen1;
           PgTopl = SflTopline1;
         endsl;
         if DspWide;
           ScreenRows = 27;
           ScreenCols = 132;
           PgLen = PgLen + 3;
           DspMsgRow = MsgRowWide;
         else;
           ScreenRows = 24;
           ScreenCols = 80;
           DspMsgRow = MsgRowNormal;
         endif;

       endsr;


       // Execute the current screen ("Screen").
       begsr ExScreen;

         if Err.e;
           // Set error indicators (31-69), as specified in "FEMap".
           exsr SetErrFldsInd;
         endif;

         // Set generic display indicators.
         *in10 = DspWide;
         *in30 = Err.e;
         *in74 =     not IdleState
                 and (ModeAdd or ModeCopy and DataFound);
         *in75 =     not IdleState
                 and (ModeAdd or (ModeUpdate or ModeCopy) and DataFound);
         *in76 = not ModeAdd and not DataFound;

         // "Msg" contains the message to display at the bottom.
         Msg = '';
         if DspMsg <> '';
           Msg = DspMsg;
           Msg# = 0;
         else;
           Msg = DspMsgList(1);
           Msg# = 1;
         endif;

         if        DspMsg <> ''
               and DspMsgList(1) <> ''
            or     DspMsgList(1) <> ''
               and DspMsgList(2) <> '';
           // Show "+" to indicate more messages.
           MoreMsgs = *on;
         endif;

         if     Msg = ''
            and not IdleState;
           // Set informational message.
           if    ModeAdd
              or ModeCopy;
             Msg = RtvAMsgAB(1026);
           elseif not DataFound;
             Msg = RtvAMsgAB(1013);
           elseif ModeDelete;
             Msg = RtvAMsgAB(1022);
           endif;
         endif;

         // Header.
         select;
         when ModeAdd;
           HdrText = Text(2);
         when ModeDisplay;
           HdrText = Text(3);
         when ModeUpdate;
           HdrText = Text(4);
         when ModeDelete;
           HdrText = Text(5);
         when ModeCopy;
           HdrText = Text(6);
         other;
           HdrText = '?';
         endsl;
         D__HDPGMI = %trim(PSI.pgmname) + '.' + %char(Screen);
         D__HDDATE = PtDate(%date);
         D__HDTIME = PtTime(%time);
         D__HDUSRI = PSI.curuser;
         if PSI.jobuser <> PSI.curuser;
           D__HDUSRI = %trim(D__HDUSRI) + '/' + %trim(PSI.jobuser);
         endif;
         evalr D__HDJOBI = %trim(PSI.jobname) + '/' +
                           %editc(PSI.jobnumber:'X');
         D__HDTXT1 = '';
         D__HDTXT2 = '';
         %subst(D__HDTXT1:
             %div(%len(D__HDTXT1)-%len(%trim(Text(1))):2)+1)
             = %trim(Text(1));
         %subst(D__HDTXT2:
             %div(%len(D__HDTXT2)-%len(%trim(HdrText)):2)-1)
             = '  ' + %trim(HdrText);
         write DFHEADER;

         // Footer.
         D__SCRIND = %char(Screen) + '/' + %char(NumScreens);
         DspOpts = '';
         OptsNum = 0;
         OptsNum = AddToAppOpts(FunText( 1):DspOpts:DspWide
                               :FunText(24));
         if not IdleState;
           if    ModeAdd
              or ModeUpdate
              or ModeCopy;
             OptsNum = AddToAppOpts(FunText( 6):DspOpts:DspWide
                                   :FunText(24));
             OptsNum = AddToAppOpts(FunText(31):DspOpts:DspWide
                                   :FunText(24));
           endif;
           if ModeDelete;
             OptsNum = AddToAppOpts(FunText(14):DspOpts:DspWide
                                   :FunText(24));
           endif;
         endif;
         if OptsNum > 1;
           AddToAppOpts(FunText(24):DspOpts:DspWide);
         endif;
         if Opts# < 1;
           Opts# = 1;
         elseif Opts# > OptsNum;
           Opts# = OptsNum;
         endif;

         if Screen = 1;
           if D__CURREC < 1;
             D__CURREC = 1;
           endif;
           if D__CURREC > SFLR1#T;
             D__CURREC = SFLR1#T;
           endif;
         endif;

         dou not (   KeyPressed(KsF01)
                  or KeyPressed(KsF10)
                  or      KeyPressed(KsF22)
                     and GetCursRow() = DspMsgRow
                  or     KeyPressed(KsF24)
                     and OptsNum > 1
                  or     (   KeyPressed(KsPageDown)
                          or KeyPressed(KsPageUp))
                     and GetCursRow() = DspMsgRow);

           D__FTTEXTW = '';
           if OptsNum > 0;
             D__FTTEXTW = GetAppOptsPart(Opts#:DspOpts:DspWide);
           endif;
           D__FTTEXT = D__FTTEXTW;

           D__FTMSG1  = Msg;
           D__FTMSG1W = Msg;
           D__FTMSG2  = Msg;
           D__FTMSG2W = Msg;
           if MoreMsgs;
             if Msg# < GetDspMsgListCount();
               %subst(D__FTMSG1 :%len(D__FTMSG1 )-1) = ' +';
               %subst(D__FTMSG1W:%len(D__FTMSG1W)-1) = ' +';
               %subst(D__FTMSG2 :%len(D__FTMSG2 )-1) = ' +';
               %subst(D__FTMSG2W:%len(D__FTMSG2W)-1) = ' +';
             else;
               %subst(D__FTMSG1 :%len(D__FTMSG1 )-1) = ' <';
               %subst(D__FTMSG1W:%len(D__FTMSG1W)-1) = ' <';
               %subst(D__FTMSG2 :%len(D__FTMSG2 )-1) = ' <';
               %subst(D__FTMSG2W:%len(D__FTMSG2W)-1) = ' <';
             endif;
           endif;
           if DspWide;
             write DFFOOTERW;
           else;
             write DFFOOTER;
           endif;

           if     StatMsg <> ''
              and StatMsg <> Msg;
             // Display statusmessage.
             DspStatMsg(%trimr(StatMsg));
           endif;

           *in27 = SetCurs;
           if SetCurs;
             if     CursRow >= 1
                and CursRow <= ScreenRows
                and CursCol >= 1
                and CursCol <= ScreenCols;
               D__CURSROW = CursRow;
               D__CURSCOL = CursCol;
             else;
               *in27 = *off;
             endif;
             SetCurs = *off;
           endif;

           select;
           // when Screen = ?;
           other;
             // Screen 1 is default.
             *in21 = *on;
             *in22 = *on;
             *in23 = *off;
             *in29 = *on;
             exfmt DFSCREEN1;
           endsl;

           // Determine cursor location.
           CursRow = GetCursRow();
           CursCol = GetCursCol();

           if KeyPressed(KsF01);
             SetCurs = *on;
             DspHelp(' ');
           elseif KeyPressed(KsF10);
             exsr SetNextCursLoc;
           elseif     KeyPressed(KsF22)
                  and GetCursRow() = DspMsgRow
                  and MoreMsgs;
             SetCurs = *on;
             ShowDspMsgs();
           elseif     KeyPressed(KsF24)
                  and OptsNum > 1;
             SetCurs = *on;
             if Opts# < OptsNum;
               Opts# = Opts# + 1;
             else;
               Opts# = 1;
             endif;
           elseif     (   KeyPressed(KsPageDown)
                       or KeyPressed(KsPageUp))
                  and GetCursRow() = DspMsgRow;
             SetCurs = *on;
             if MoreMsgs;
               if KeyPressed(KsPageDown);
                 Msg# = Msg# + 1;
               else;
                 Msg# = Msg# - 1;
               endif;
               if Msg# < 0;
                 Msg# = GetDspMsgListCount();
               elseif Msg# > GetDspMsgListCount();
                 Msg# = 0;
               endif;
               if Msg# = 0;
                 Msg = DspMsg;
               else;
                 Msg = DspMsgList(Msg#);
               endif;
               Msg = %char(Msg# + 1) + ': ' + Msg;
             endif;
           endif;

         enddo;

         // Set off all indicators.
         *in(*) = *off;

         if Screen = 1;
           // Calculate the correct subfile record# to set the
           // cursor location on next display.
           if CursRow < PgTopl;
             D__CURREC = WSI.sfrrn;
           elseif CursRow >= PgTopl + PgLen;
             D__CURREC = WSI.sfrrn + PgLen - 1;
           else;
             D__CURREC = WSI.sfrrn + CursRow - PgTopl;
           endif;
         endif;

         if     not IdleState
            and (   ModeAdd
                 or ModeUpdate
                 or ModeCopy);
           // Detect whether one or more editable display fields
           // have been changed since the last execution of subr.
           // "InitDspFlds" or "DataToDspFlds".
           ChgDspFld = DChgDspFlds <> DChgDspFldsF;
           if not ChgDspFld;
             // Check editable fields in subfile.
             for SflRec = 1 to SFLR1#T;
               select;
               // when Screen = ?;
               other;
                 // Screen 1 is default.
                 chain SflRec DFSCREEN1S;
                 if D_SLINE <> D__SLINE;
                   ChgDspFld = *on;
                   leave;
                 endif;
               endsl;
             endfor;
           endif;
         endif;

         SetCurs = *off;

       endsr;


       // Validate the current screen, identified with "Screen".
       // Set ds "Err" in case of errors.
       // Setting "Err.e" to *on indicates one or more fatal errors.
       // If "Err.e" is *off after executing this subroutine then subr.
       // "PcsScreen" will be executed.
       begsr ValScreen;

         //L_SetErr(RtvAMsgAB(1991:CAmsFatal));
         //leavesr;

         if    ModeUpdate
            or ModeDelete;
           // First, in update or delete mode, check if the data in
           // the database has been updated by another user or process.
           exsr CheckStaleData;
           if Err.e;
             leavesr;
           endif;
         endif;

         // Clear all messages first.
         ClrDspMsgs();

         if    ModeAdd
            or ModeCopy;

           if %subst(D_SID:1:1) = '';
             AddDCVMsg(RtvAMsgAB(5002:CAmsFatal):'D_SID');
           else;
             SQLSID = D_SID;
             setll (SQLSID) CSYSSQLSF1;
             if %equal;
               AddDCVMsg(RtvAMsgAB(5003:CAmsFatal):'D_SID');
             endif;
           endif;

         elseif ModeUpdate;

           // Check if any text has been entered for the SQL statement.
           flag = *on;
           for SflRec = 1 to SFLR1#T;
             chain SflRec DFSCREEN1S;
             if D_SLINE <> '';
               flag = *off;
               leave;
             endif;
           endfor;
           if flag;
             chain 1 DFSCREEN1S;
             *in75 = *on;
             *in76 = *off;
             *in32 = *on; // error ind.
             update DFSCREEN1S;
             AddDCVMsg(RtvAMsgAB(5001:CAmsFatal));
             D__CURREC = 1;
           endif;

         endif;

         if GetDspMsgListCount() > 0;

           // There were errors.

           L_SetErr('');         // set err ind. & clear msg/db flds
           DropDspMsgs();        // "DspMsg" becomes first msg
           exsr AddAssocErrFlds; // add assoc. db flds to "Err.flds"

         endif;

       endsr;


       // Process the current screen, identified with "Screen".
       // Set ds "Err" in case of errors.
       // Setting "Err.e" to *on indicates one or more fatal errors.
       // If "Err.e" is *off after executing this subroutine the
       // program will end immediately, unless special behavior "A"
       // is specified or indicator "StayActive" is set to *on (the
       // program stays in "idle state").
       //
       // IN ADD/COPY MODE: SET DS "DRKEY" TO THE NEW KEY !!!
       begsr PcsScreen;

         // Assign display fields to their corresponding database fields.
         // Some display fields must be interpreted first (e.g. numbers
         // and dates) while other display fields can be assigned "as-is".

         if    ModeUpdate
            or ModeDelete;

           // Delete records.
           setll (@@Sqlsid) CSYSSQLSF1;
           reade (@@Sqlsid) CSYSSQLSF1;
           dow not %eof;
             delete SQLSREC;
             reade (@@Sqlsid) CSYSSQLSF1;
           enddo;

         endif;

         if not ModeDelete;

           // Add records; skip leading and trailing blank lines.
           clear *all SQLSREC;
           if    ModeAdd
              or ModeCopy;
             SQLSID = D_SID;
           else;
             SQLSID = @@Sqlsid;
           endif;
           SQLSLINENO = 0;
           flag = *off;
           n = 0; // # trailing blank lines up to next non-blank line or end sf
           for SflRec = 1 to SFLR1#T;
             chain SflRec DFSCREEN1S;
             if flag;
               if D_SLINE = '';
                 n = n + 1;
               endif;
             elseif D_SLINE <> '';
               flag = *on;
             endif;
             if D_SLINE <> '';
               // Add N blank lines, and current line.
               for x = 1 to n;
                 if SQLSLINENO < *hival;
                   SQLSLINE   = '';
                   SQLSLINENO = SQLSLINENO + 1;
                   write SQLSREC;
                 endif;
               endfor;
               n = 0;
               if SQLSLINENO < *hival;
                 SQLSLINE   = D_SLINE;
                 SQLSLINENO = SQLSLINENO + 1;
                 write SQLSREC;
               endif;
             endif;
           endfor;

         endif;

         if     (ModeAdd or ModeCopy)
            and not Err.e;
           // No errors in add/copy mode; set "DrKey".
           DrKey.f1 = D_SID;
         endif;

       endsr;


       // Check whether the data read earlier in subr. "DataToDspFlds"
       // is stale. Do this by reading the same data as in "DataToDspFlds"
       // and append it in the same order to data block 1. Then, use
       // "DataBlockComp" to compare data blocks 0 and 1.
       // Set "Err.e" to *on and set "DspMsg" if the data is stale.
       begsr CheckStaleData;

         DataBlockClear(1);
         setll (@@Sqlsid) CSYSSQLSF1;
         if not %equal;
           // Data has been deleted by another user or process.
           L_SetErr(RtvAMsgAB(1029:CAmsFatal));
           leavesr;
         endif;
         reade(n) (@@Sqlsid) CSYSSQLSF1;
         dow not %eof;
           DataBlockAppend(1:%addr(ErfCSYSSQLSF1):%size(ErfCSYSSQLSF1));
           reade(n) (@@Sqlsid) CSYSSQLSF1;
         enddo;
         if DataBlockComp(0:1) <> 0;
           // Data has been updated by another user or process.
           L_SetErr(RtvAMsgAB(1030:CAmsFatal));
         endif;
         DataBlockClear(1);

       endsr;


       // Select an item for the current display field on the
       // current screen, identified with "Screen".
       begsr SelectItem;

         //if     not ModeAdd
         //   and not ModeUpdate
         //   and not ModeCopy;
           L_SetErr(RtvAMsgAB(1025:CAmsFatal));
           leavesr;
         //endif;

         select;
         // when Screen = ?;
         other;
           // Screen 1 is default.
           select;
           when D__CURSFLD = 'D_XXX';
             //if SelXxx(SelXxx$:-1);
             //  D_XXX = SelXxx$.f1;
             //  DspMsg = RtvAMsgAB(1016);
             //else;
             //  DspMsg = RtvAMsgAB(1059);
             //endif;
             leavesr;
           endsl;
         endsl;

         L_SetErr(RtvAMsgAB(1015:CAmsFatal));

       endsr;


       // Initialize/clear all data fields and all subfiles on
       // all screens. Set each field to blanks/zeros or to a
       // default value.
       // In "add" mode, ensure that the subfiles contain at
       // least one (blank) record to avoid I/O errors.
       // When not in "add" mode, subroutine "DataToDspFlds" is
       // executed which first executes this subr. to initialize
       // and then fills any subfiles with data.
       begsr InitDspFlds;

         // Needed to correctly switch to/from DSPMOD(*WIDE).
         *in10 = DspWide;
         write DFHEADER;

         // Clear fields.
         clear *all DFSCREEN1;

         // Set key fields.
         D_SID = @@Sqlsid;

         // Clear subfiles.
         SFLR1#T = 0;
         *in21 = *off;
         *in22 = *off;
         *in23 = *on;
         write DFSCREEN1;

         if ModeAdd;
           // Fill subfiles with blank record(s).
           for SflRec = 1 to PgLen;
             clear *all DFSCREEN1S;
             *in75 = *on;
             *in76 = *off;
             *in32 = *off; // error ind.
             SFLR1# = SFLR1#T + 1;
             evalr D_LINENO = %char(SFLR1#) + ':';
             write DFSCREEN1S;
             SFLR1#T = SFLR1#;
           endfor;
         endif;

         if    ModeAdd
            or ModeUpdate
            or ModeCopy;
           // Editable fields are "not changed".
           DChgDspFldsF = DChgDspFlds;
           ChgDspFld = *off;
         endif;

         D__CURREC = 1;

       endsr;


       // Read the data from the database and fill display fields.
       // Set "DataFound" to *on if found, else set to *off.
       // This subroutine should NOT be called in "add" mode.
       // In update or delete mode, if the data has been found, use
       // "DataBlockAppend" to append all relevant data that was read
       // from the database to data block 0. This is used later in
       // subr. "CheckStaleData" to detect whether the data in the
       // database has been updated by another user or process.
       begsr DataToDspFlds;

         DataFound = *off;

         if ModeAdd;
           leavesr;
         endif;

         if ModeUpdate or ModeDelete;
           // Clear data blocks 0 and 1. Block 0 is filled here with
           // the orginal data, read from the database. Block 1 is
           // filled later in "PcsScreen" with the same data from the
           // database, which could be different from the data in block
           // 0 if it has been changed in the mean time. Then, both
           // blocks are compared with "DataBlockComp" to detect whether
           // the data in block 0 is stale.
           DataBlockClear(0);
           DataBlockClear(1);
         endif;

         clear *all SQLSREC;

         setll (@@Sqlsid) CSYSSQLSF1;

         DataFound = %equal;

         if DspMsg = '';
           if DataFound;
             DspMsg = RtvAMsgAB(1014);
           else;
             DspMsg = RtvAMsgAB(1013);
           endif;
         endif;

         exsr InitDspFlds;

         if DataFound;

           if ModeUpdate or ModeDelete;
             //DataBlockAppend(0:%addr(ErfCSYSSQLSF1):%size(ErfCSYSSQLSF1));
           endif;

           reade(n) (@@Sqlsid) CSYSSQLSF1;
           dow not %eof;
             if ModeUpdate or ModeDelete;
               DataBlockAppend(0:%addr(ErfCSYSSQLSF1):%size(ErfCSYSSQLSF1));
             endif;
             if SFLR1#T < MaxSqlLines;
               clear *all DFSCREEN1S;
               *in75 = ModeUpdate or ModeCopy;
               *in76 = *off;
               *in32 = *off; // error ind.
               D_SLINE  = SQLSLINE;
               D__SLINE = SQLSLINE;
               SFLR1# = SFLR1#T + 1;
               evalr D_LINENO = %char(SFLR1#) + ':';
               write DFSCREEN1S;
               SFLR1#T = SFLR1#;
             endif;
             reade(n) (@@Sqlsid) CSYSSQLSF1;
           enddo;

         endif;

         if     (ModeUpdate or ModeCopy)
            and SFLR1#T < MaxSqlLines;
           // Fill last subfile page with blank records.
           n = PgLen - %rem(SFLR1#T:PgLen);
           if n < PgLen or SFLR1#T = 0;
             for SflRec = 1 to n;
               if SFLR1#T < MaxSqlLines;
                 clear *all DFSCREEN1S;
                 *in75 = *on;
                 *in76 = *off;
                 *in32 = *off; // error ind.
                 SFLR1# = SFLR1#T + 1;
                 evalr D_LINENO = %char(SFLR1#) + ':';
                 write DFSCREEN1S;
                 SFLR1#T = SFLR1#;
               endif;
             endfor;
           endif;
         endif;

         // Add dummy record if subfile is empty.
         if SFLR1#T = 0;
           SFLR1# = 1;
           clear *all DFSCREEN1S;
           *in75 = *off;
           *in76 = *on;
           write DFSCREEN1S;
           SFLR1#T = SFLR1#;
         endif;

         D__CURREC = 1;

         if ModeUpdate or ModeCopy;
           // Editable fields are "not changed".
           DChgDspFldsF = DChgDspFlds;
           ChgDspFld = *off;
         endif;

       endsr;


       // Add a blank subfile page after pressing PageDown on the last
       // page, but only if the last page is currently not all blanks.
       begsr SflAddBlankPage;

         SflRec = SFLR1#T - PgLen + 1;
         if SflRec > 0;
           dow SflRec <= SFLR1#T;
             chain SflRec DFSCREEN1S;
             if D_SLINE <> '';
               leave;
             endif;
             SflRec = SflRec + 1;
           enddo;
           if SflRec > SFLR1#T;
             // Last page is all blanks; leave subr.
             DspMsg = RtvAMsgAB(1050);
             leavesr;
           endif;
         endif;

         for SflRec = 1 to PgLen;
           if SFLR1#T < MaxSqlLines;
             clear *all DFSCREEN1S;
             *in75 = *on;
             *in76 = *off;
             *in32 = *off; // error ind.
             SFLR1# = SFLR1#T + 1;
             evalr D_LINENO = %char(SFLR1#) + ':';
             write DFSCREEN1S;
             SFLR1#T = SFLR1#;
             if SflRec = 1;
               D__CURREC = SFLR1#T;
             endif;
           endif;
         endfor;

       endsr;


       // Program goes into idle mode; update the subfile fields
       // to make fields non-editable.
       begsr SflIntoIdleMode;

         for SflRec = 1 to SFLR1#T;
           select;
           // when Screen = ?;
           other;
             // Screen 1 is default.
             chain SflRec DFSCREEN1S;
             *in75 = *off;
             *in76 = *off;
             update DFSCREEN1S;
           endsl;
         endfor;

       endsr;


       // Insert (KeyPressed(KsF06)) a blank line or delete
       // (KeyPressed(KsF14)) the line on the current cursor
       // position on the SQL lines page.
       begsr InsertOrDeleteSqlLine;

         flag = KeyPressed(KsF06);

         if    CursRow <  PgTopl
            or CursRow >= PgTopl + PgLen
            or     not flag
               and SFLR1#T < 2;
           leavesr;
         endif;

         n = WSI.sfrrn + CursRow - PgTopl;
         if n > SFLR1#T;
           leavesr;
         endif;

         if flag;
           SflRec = 1;
         else;
           SflRec = SFLR1#T;
         endif;
         sqlLine1 = '';
         dow        flag
                and SflRec <= SFLR1#T
             or     not flag
                and SflRec > 0;
           chain SflRec DFSCREEN1S;
           if SflRec >= n;
             sqlLine2 = D_SLINE;
             D_SLINE = sqlLine1;
             sqlLine1 = sqlLine2;
           endif;
           *in75 = *on;
           *in76 = *off;
           *in32 = *off;
           update DFSCREEN1S;
           if flag;
             SflRec = SflRec + 1;
           else;
             SflRec = SflRec - 1;
           endif;
         enddo;
         if     flag
            and sqlLine1 <> '';
           for SflRec = 1 to PgLen;
             if SFLR1#T < MaxSqlLines;
               clear *all DFSCREEN1S;
               if SflRec = 1;
                 D_SLINE = sqlLine1;
                endif;
               *in75 = *on;
               *in76 = *off;
               *in32 = *off;
               SFLR1# = SFLR1#T + 1;
               evalr D_LINENO = %char(SFLR1#) + ':';
               write DFSCREEN1S;
               SFLR1#T = SFLR1#;
             endif;
           endfor;
         endif;

       endsr;


      /include QINCSRC,DPGM_SUBR


      /end-free
     p                 e


      /include QINCSRC,DPGM_LPI


** FEMap (nnnnnnnnnnnnii, field/attribute name where ?=any, indicator)
D_SID       31
** CursLocs (snrrccc, screensize/screen#/row/col, s=W/N/blank, n=blank=all)
 106007
N 22001
W 25001
** Text
SQL Statement
Add
Display
Update
Delete
Copy
** FunText
F1=Help
F2=
F3=
F4=
F5=
F6=Insert line
F7=
F8=
F9=
F10=
F11=
F12=
F13=
F14=DELETE
F15=
F16=
F17=
F18=
F19=
F20=
F21=
F22=
F23=
F24=More keys
25:RESERVED
26:RESERVED
27:RESERVED
28:RESERVED
29:RESERVED
30:RESERVED
F14=Delete line

