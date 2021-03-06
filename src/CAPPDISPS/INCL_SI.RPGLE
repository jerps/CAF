
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPDISP_INCL_SI)
      /EOF
      /ENDIF
      /DEFINE CAPPDISP_INCL_SI


       // INCLUDE: *SRVPGM CAPPDISP

       // Module SI: Select Item


      /include CAPPDISPS,INCL_DEFS


       // ---- General Information

       // Procedures in this module present a window to select items. The
       // top-left location of the window is given with parameters "row"
       // and "column", which are optional. If not given or *OMITted, or
       // the value is 0, then the current cursor row and/or column is
       // used which is read from the workstation information data structure
       // (INFDS). For this to work the WSI@ pointer, which is exported from
       // service program CSYSBASE, should point to the address of the client
       // program's workstation infds. If this is not the case the result
       // will be unpredictable.

       // If parameter "row" or "column" is negative then the window's
       // location is relative to the current cursor location (which is
       // read from WSI). The absolute value of the parameter(s) is added
       // to the current row/column location. Thus, if "row" is -1 and the
       // current cursor row is 15 then the top-left location of the window
       // is placed on row 16.


       // ----- Prototypes

       // SelectSimpleValue - Select Simple Value
       // Present a window with a list of values from which the user can
       // select one value. Return the selected value, or return blanks if
       // the user didn't select a value.
       // The window's title is given with parameter "wdwtitle".
       // The values to choose from are given with parameter "values". A
       // maximum of 100 values, each up to 40 characters, can be given.
       // Parameter "values#" is optional and contains the number of values
       // in array "values" that are shown (from the first element). If this
       // parameter is not given, or it's value is less than 1, then all
       // non-blank values in array "values" are shown.
     d SelectSimpleValue...
     d                 pr            40    extproc('SelectSimpleValue')
     d   wdwtitle                    40    const
     d   values                      40    const dim(100)
     d   values#                     10i 0 const options(*nopass:*omit)
     d   wdwrow                       2  0 const options(*nopass:*omit)
     d   wdwcol                       3  0 const options(*nopass:*omit)


       // - Select Item

       //   Each procedure below presents a window from which the user
       //   can select one item. If the procedure returns *on then the
       //   user made a selection and parameter "selkey" contains the
       //   selected item key. This key is always a data structure, with
       //   one or more subfields, which is defined together with the
       //   procedure. The data structure's name is the procedure's name
       //   appended with "$".

       //   The contents of "selkey" should be ignored if a procedure
       //   returns *off.

       // SelNwdType - Select Non-Work Day Type
     d SelNwdType$     ds                  qualified inz
         // id
     d   f1                           1
     d SelNwdType      pr              n   extproc('SelNwdType')
     d   selkey                                  likeds(SelNwdType$)
     d   wdwrow                       2  0 const options(*omit:*nopass)
     d   wdwcol                       3  0 const options(*omit:*nopass)

       // SelAppMenuGroup - Select AppMenu Group
     d SelAppMenuGroup$...
     d                 ds                  qualified inz
         // id
     d   f1                                like(TAM_GROUP)
     d SelAppMenuGroup...
     d                 pr              n   extproc('SelAppMenuGroup')
     d   selkey                                  likeds(SelAppMenuGroup$)
     d   wdwrow                       2  0 const options(*omit:*nopass)
     d   wdwcol                       3  0 const options(*omit:*nopass)

       // SelSqlStmtId - Select SQL Statement Id
     d SelSqlStmtId$   ds                  qualified inz
         // id
     d   f1                                like(TSQLS_ID)
     d SelSqlStmtId    pr              n   extproc('SelSqlStmtId')
     d   selkey                                  likeds(SelSqlStmtId$)
     d   wdwrow                       2  0 const options(*omit:*nopass)
     d   wdwcol                       3  0 const options(*omit:*nopass)

