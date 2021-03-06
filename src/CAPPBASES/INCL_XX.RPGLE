
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_XX)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_XX


       // INCLUDE: *SRVPGM CAPPBASE

       // Module XX: Miscellaneous


       // Do NOT include INCL_XX explicitly; use INCL_API instead.
       // The artifacts contained in module XX are not categorized yet
       // and therefore susceptible of being moved to another module.


      /include CAPPBASES,INCL_DEFS


       // ----- Prototypes

       // NumSepDec - Return 1-character number decimal separator
       // If parameter "sep" is given and is not blank then the
       // decimal separator is set to "sep". Call again with "sep"
       // being blank to set the default again.
     d NumSepDec       pr             1    extproc('NumSepDec')
     d   sep                          1    const options(*nopass)

       // NumSepGrp - Return 1-character number group separator
       // If parameter "sep" is given and is not blank then the
       // group separator is set to "sep". Call again with "sep"
       // being blank to set the default again.
     d NumSepGrp       pr             1    extproc('NumSepGrp')
     d   sep                          1    const options(*nopass)

       // SetQdsDs - Set "Qds" Data structure
       // Fill the first three subfields in a "Qds" data structure with
       // parameters "rc", "msg", and "fld1" through "fld7". This is a
       // special kind of data structure which is used in different parts
       // of the system. It's purpose is to be filled with data items that
       // are queried from the database. The first three subfields of every
       // "Qds" data structure is a 2-digit returncode ("rc"), a field with
       // length 200 which may contain an (error) message ("msg"), and an
       // array ("dbf") with field length 10 and 7 elements to contain field
       // and/or (logical) attribute names ("dbf"). These names specify the
       // data items, (logical) attributes and/or (database) field names that
       // are associated with the message. This procedure can be used as a
       // convenience to fill subfield "rc" with parameter "rc", subfield
       // "msg" with parameter "msg", and subfield "dbf" with parameters
       // "fld1" through "fld7". The first parameter, "qds", is used to pass
       // the "Qds" data structure (by ref). The three subfields are always
       // cleared first, i.e. "rc" is set to zero and "msg" and "dbf" are set
       // to blanks. Call this procedure with only parameter "qds" to simply
       // clear the three subfields.
       // IMPORTANT: This procedure assumes that "qds" has the correct layout
       // and that position 1 of parameter "qds" is this first digit of "rc",
       // and position 3 is the first position of "msg", and position 203 is
       // position 1 of field 1 of array "dbf", and that position 215 is posi-
       // tion 1 of field 2, etc, until position 275 which is the first posi-
       // tion of field 7. The first data item starts at position 311.
     d SetQdsDs        pr                  extproc('SetQdsDs')
     d   qds                      30000          options(*varsize)
     d   rc                           2  0 const options(*nopass)
     d   msg                        200    const options(*nopass)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

       // SetQdsDsMsg - Set "Qds" Data structure Message
       // Like "SetQdsDs", but this procedure ignores subfield "rc"
       // and only clears/fills "msg" and "dbf".
     d SetQdsDsMsg     pr                  extproc('SetQdsDsMsg')
     d   qds                      30000          options(*varsize)
     d   msg                        200    const options(*nopass)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

       // AddToAppOpts - Add To Application Options
       // Append "option" to "options". If "wide" is given, it indicates
       // whether the options are supposed to be presented on a wide screen
       // (*on) or not (*off). If not given then this depends on the current
       // display mode, which is queried using "CSYSBASE/DspModeIsWide".
       // Each option allways occupies either a field of 20 (*NORMAL), or 22
       // (*WIDE) characters. The field is padded to the right with blanks.
       // Field "options" can be divided into 4 parts of the same length.
       // Only one of these parts can be displayed on the screen on 2 rows.
       // Return the part to which "option" has been added. Return 0 if all
       // parts are filled.
       // Procedure "GetAppOptsPart" must be used to get a specific part of
       // "options". The length of a part depends on parameter "wide", or
       // "CSYSBASE/DspModeIsWide" if "wide" is not given.
       // Depending on "wide" or "CSYSBASE/DspModeIsWide", the length of a
       // part is either 160 (*NORMAL), or 264 (*WIDE). Because each option
       // must be followed by at least one space, the maximum length of an
       // option is either 19 (*NORMAL) or 21 (*WIDE). In *NORMAL mode, a
       // part contains at most 8 options (2 x 4). In *WIDE mode, a part
       // contains at most 12 options (2 x 6).
       // Optional parameter "lastoption" contains an option which is
       // appended to "options" instead of "option" if the current part
       // of "options" (1-3) has only room for one more option. If there
       // is room for more or if the current part is the last one (4) then
       // this parameter has no effect. However, if there is only room for
       // one and the current part is not part 4 then first "lastoption" is
       // appended first and then "option" is appended to the next part (and
       // becomes the first option of the next part). In this case the result
       // is the same as if this procedure has been called twice. The first
       // one with "lastoption" as the option and the second with "option".
       // This is useful to append the F24 (more keys) option text at the end
       // of each part if more than 1 parts are filled.
     d AddToAppOpts    pr            10i 0 extproc('AddToAppOpts')
     d   option                      21    const
     d   options                   1056
     d   wide                          n   const options(*nopass:*omit)
     d   lastoption                  21    const options(*nopass)

       // GetAppOptsArray - Get Application Options Array
       // Return an array with all individual options in "options", which
       // must have been filled with procedure "AddToAppOpts".
       // Depending on "wide" or "CSYSBASE/DspModeIsWide", the length of
       // an option is either 19 (*NORMAL) or 21 (*WIDE). The maximum number
       // of returned options is either 32 (*NORMAL) or 48 (*WIDE).
       // The value of "wide" or "CSYSBASE/DspModeIsWide" MUST be the
       // same as when the options were appended to "options" with
       // procedure "AddToAppOpts".
     d GetAppOptsArray...
     d                 pr            21    dim(48) extproc('GetAppOptsArray')
     d   options                   1056    const
     d   wide                          n   const options(*nopass)

       // GetAppOptsPart - Get Application Options Part
       // Return "part" 1, 2 3 or 4 of "options", which must have been
       // filled with procedure "AddToAppOpts".
       // Depending on "wide" or "CSYSBASE/DspModeIsWide", the length of
       // a part is either 160 (*NORMAL), or 264 (*WIDE).
       // The value of "wide" or "CSYSBASE/DspModeIsWide" MUST be the
       // same as when the options were appended to "options" with
       // procedure "AddToAppOpts".
     d GetAppOptsPart  pr           264    extproc('GetAppOptsPart')
     d   part                        10i 0 const
     d   options                   1056    const
     d   wide                          n   const options(*nopass)

       // CalleeSpcBhvr - Callee Special Behavior
       // Return a field with zero or more "special behavior" codes, which
       // are provided with parameter "sbc", "sbcpass" and/or "sbcadd".
       // A special behavior code is some character in a parameter field
       // that is passed to a called program to indicate that the program
       // should behave in some special (non-default) way. For example, code
       // "X" is normally used to indicate that F9 (screen resize) is not
       // allowed (the default behavior is to allow F9). Another one is "A"
       // (keep active) to indicate that the program should not end automati-
       // cally when the user presses the enter key and there are no further
       // actions (like processing a subfile option). The default behavior is
       // to end the program.
       // When program 1 calls program 2 some special behaviors for program
       // 1 - usually - must be passed to program 2 and other codes should not
       // be passed. Simply passing the same special behaviors is usually not
       // a good idea.
       // This procedure helps with easily passing the right codes from the
       // caller to the callee.
       // Parameter "sbc" contains the special behavior codes that were passed
       // to the caller (program 1). The special behavior codes for the callee
       // (program 2) are returned.
       // Parameters "sbcpass", "sbcadd" and "sbcsub" are optional. Parameter
       // "sbcpass" contains the special behavior codes that must be passed
       // to the callee *IFF* the code is in parameter "sbc" (i.e. passed from
       // program 1 to program 2). Parameter "sbcadd" contains the codes that
       // must be passed to the callee whether they are in "sbc" or not. Para-
       // meter "sbcsub" contains the codes that must not be passed, even when
       // they are in "sbcadd".
       // Some special behavior codes should usually be passed on from the
       // caller to the callee, such as "X". I.e. if program 1 is not allowed
       // to resize then usually program 2 should also be not allowed to resize.
       // Other special behavior codes normally should not be passed on to the
       // callee, such as "A". I.e. if program 1 must stay active then program
       // 2 should not necessarily stay active also (usually not).
       // To help with these common cases parameter "sbcpass" has a sensible
       // default value if it's not provided or if it is blank. The default
       // value for "sbcadd" and "sbcsub" is simply blank. So just providing
       // parameter "sbc" should be enough for most cases.
       // The default value for parameter "sbcpass" is "IJKX". These codes
       // indicate the following special behaviors:
       //   I = inhibit in-line updating;
       //   J = do not allow adding or copying;
       //   K = do not allow deleting;
       //   X = do not allow resize.
       // Constant "CSbcPassToCallee" contains the special behavior codes
       // listed above that should be passed by default from the caller to
       // the callee.
       // Character "*" can be used with "sbcpass" to indicate that all
       // codes in "sbc" should be passed.
       // Note: Don't use an asterisk ("*") as a special behavior code.
     d CalleeSpcBhvr   pr            10    extproc('CalleeSpcBhvr')
     d   sbc                         10    const
     d   sbcpass                     10    const options(*nopass:*omit)
     d   sbcadd                      10    const options(*nopass:*omit)
     d   sbcsub                      10    const options(*nopass)

