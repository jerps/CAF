
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_MS)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_MS


       // INCLUDE: *SRVPGM CAPPBASE

       // Module MS: Message Support


       // This module defines and exports "DspMsg", "DspMsgList" and procedures
       // to work with (application) messages.

       // Field "DspMsg" is 130 characters long and stores one message.
       // Interactive (screen) programs use this field to store the message
       // that is to be displayed on the message line (usually line 22/25).

       // Array "DspMsgList" stores up to 99 (error)messages (130 chars).
       // Interactive (screen) programs display these messages in a window
       // when the user presses F22. This array is mostly used to store
       // validation messages. Use procedure "AddToDspMsgList" to add a
       // message to this array. Procedure "AssocDspMsgData" can be used to
       // associate a data field (100 chars) with a message. With "AddDCVMsg"
       // a message can be added to "DspMsgList" together with up to 7
       // field/attribute names which are stored in the data field associated
       // with the message. Use procedure "GetAssocDspMsgData" or "GetDCVFlds"
       // to retrieve the associated data or field/attribute names, resp.


      /include CAPPBASES,INCL_DEFS


       // ----- Prototypes

       // IsAMsgFatal   - Is Application Message Fatal
       // IsAMsgWarning - Is Application Message Warning
       // IsAMsgInfo    - Is Application Message Info
       // Return *on if "msg" is a fatal/warning/info message, else return
       // *off.
       // The message severity is determined by the third character of the
       // message text which is "CAmsFatal", "CAmsWarning" or "CAmsInfo".
       // Be sure to pass at least three characters to "msg".
     d IsAMsgFatal     pr              n   extproc('IsAMsgFatal')
     d   msg                          3    options(*varsize)
     d IsAMsgWarning   pr              n   extproc('IsAMsgWarning')
     d   msg                          3    options(*varsize)
     d IsAMsgInfo      pr              n   extproc('IsAMsgInfo')
     d   msg                          3    options(*varsize)

       // SetAMsgFatal   - Set Application Message Fatal
       // SetAMsgWarning - Set Application Message Warning
       // SetAMsgInfo    - Set Application Message Info
       // Set "msg" to be a fatal/warning/info message, i.e. set the third
       // character of "msg" to "CAmsFatal", "CAmsWarning" or "CAmsInfo".
       // Be sure to pass at least three characters to "msg".
     d SetAMsgFatal    pr                  extproc('SetAMsgFatal')
     d   msg                          3    options(*varsize)
     d SetAMsgWarning  pr                  extproc('SetAMsgWarning')
     d   msg                          3    options(*varsize)
     d SetAMsgInfo     pr                  extproc('SetAMsgInfo')
     d   msg                          3    options(*varsize)

       // ClrDspMsgs - Clear Display Messages
       // Clear the messages (and associated data) in "DspMsg" and
       // "DspMsgList", which are defined in the *MODULE.
     d ClrDspMsgs      pr                  extproc('ClrDspMsgs')

       // AddToDspMsgList - Add To "DspMsgList"
       // Put "msg" into the first non-blank element of array "DspMsgList",
       // which is defined in the *MODULE. Return the element index if
       // successful, else return 0 if there is no non-blank element in the
       // array. If "data" is given, associate the new message with it. If
       // not, the new message has no (i.e. blank) associated data.
       // If "msg" is blank then do nothing and simply return the result of
       // "GetDspMsgListCount".
     d AddToDspMsgList...
     d                 pr             5i 0 extproc('AddToDspMsgList')
     d   msg                        130    const
     d   data                       100    const options(*nopass)

       // DropDspMsgs - Drop Display Messages
       // Move all messages from "DspMsg" up to "DspMsgList(n)" down to
       // "DspMsg" and up. Nothing happens if "DspMsg" (the first message)
       // is not blank. If "DspMsg" is blank then it is set to the first
       // non-blank element in "DspMsgList" (which is then cleared). All
       // messages up are moved accordingly. Associated data is moved to-
       // gether with the messages.
     d DropDspMsgs     pr                  extproc('DropDspMsgs')

       // PopDspMsgs - Pop Display Messages
       // Remove the first message (either "DspMsg" or "DspMsgList(1)")
       // from the list and move all other messages one position down.
       // Thus, "DspMsg" is replaced with "DspMsgList(1)", "DspMsgList(1)"
       // is replaced with "DspMsgList(2)", etc, until the last message
       // in "DspMsgList", i.e. the element in "DspMsgList" (if any) just
       // before the first non-blank element (the rest is ignored). This
       // last message becomes blank. Nothing happens if "DspMsg" and
       // "DspMsgList(1)" are both blank. Associated data is moved together
       // with the messages.
     d PopDspMsgs      pr                  extproc('PopDspMsgs')

       // PushDspMsgs - Push Display Messages
       // If "DspMsg" is blank then set it to the value of parameter "msg".
       // If it's not blank then first move all messages from "DspMsg" to the
       // one just before the first blank element in "DspMsgList" one position
       // up, and then set "DspMsg" to the value of "msg".
       // Parameter "msg" is optional; if not given it's value is considered to
       // be blank.
       // If messages are moved:
       //   - if "DspMsgList(n)" is the first blank element then it is set to
       //     "DspMsgList(n-1)", etc, until "DspMsgList(1)" which is set to
       //     "DspMsg";
       //   - if "DspMsgList(1)" is blank then only "DspMsg" is moved up
       //     (i.e. "DspMsgList(1)" is set to "DspMsg" and "DspMsg" is set
       //     to "msg");
       //   - associated data is moved together with the messages;
       //   - if all messages in "DspMsgList" are moved up until the last
       //     element then this last message is removed from "DspMsgList"
       //     (i.e. "DspMsgList(last)" is set to "DspMsgList(last-1)").
     d PushDspMsgs     pr                  extproc('PushDspMsgs')
     d   msg                        130    const options(*nopass)

       // AssocDspMsgData - Associate Display Message Data
       // Associate "data" with the display message identified with "msgno".
       // If "msgno" is 0, "data" is associated with "DspMsg", else it is
       // associated with "DspMsgList(msgno)".
     d AssocDspMsgData...
     d                 pr                  extproc('AssocDspMsgData')
     d   msgno                        5i 0 const
     d   data                       100    const

       // GetAssocDspMsgData - Get Associated Display Message Data
       // Return the "data" associated with the display message identified
       // with "msgno". If "msgno" is 0, the "data" associated with "DspMsg"
       // is returned, else the "data" associated with "DspMsgList(msgno)"
       // is returned.
     d GetAssocDspMsgData...
     d                 pr           100    extproc('GetAssocDspMsgData')
     d   msgno                        5i 0 const

       // GetDspMsgListCount - Get "DspMsgList" Count
       // Return the number of messages in "DspMsgList". This is the index
       // of the element in "DspMsgList" just before the first blank element.
       // Return 0 if "DspMsgList(1)" is blank, i.e. there are no messages.
       // Return 99 if "DspMsgList" has no empty element, i.e. it contains
       // the maximum number of messages.
     d GetDspMsgListCount...
     d                 pr             5i 0 extproc('GetDspMsgListCount')

       // AddDCVMsg - Add Db Command Validation Message (to "DspMsgList")
       // Like "AddToDspMsgList", but instead of one field "data" a
       // maximum of 7 different field/attribute names can be given.
       // These names are concatenated to form one "data" field. The first
       // name is put into pos. 17-28 of "data", the second in pos. 29-40,
       // etc. Ignore blank field names.
     d AddDCVMsg       pr             5i 0 extproc('AddDCVMsg')
     d   msg                        130    const
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

       // AddDCVMsg2 - Add Db Command Validation Message (to "DspMsgList")
       // Like "AddDCVMsg", but instead the field/attribute names are
       // passed with array "flds".
     d AddDCVMsg2      pr             5i 0 extproc('AddDCVMsg2')
     d   msg                        130    const
     d   flds                        12    const dim(7) options(*nopass)

       // AddDCVMsgQdsDs - Add Db Command Validation Message (using "Qds" ds)
       // Like "AddDCVMsg", but instead the message and field/attribute
       // names are taken from the "msg" and "dbf" subfields of the "Qds"
       // data structure provided with "qds". Additional field/attribute
       // names can be provided with parameters "fld1".."fld7". The number
       // of field/attribute names that can be associated with a message
       // can not exceed 7.
       // See procedure "SetQdsDs" in service program CAPPBASE for more
       // info about the "Qds" data structure and it's format.
     d AddDCVMsgQdsDs  pr             5i 0 extproc('AddDCVMsgQdsDs')
     d   qds                      30000          options(*varsize)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

       // GetDCVFlds - Get Db Command Validation Fields.
       // Return the field/attribute names associated with the display
       // message identified with "msgno", that were added with "AddDCVMsg",
       // with parameter "flds".
       // These names are taken from the "data" field associated with the
       // message. It is assumed that the message was added with "AddDCVMsg".
       // Return the number of names, i.e. the number of non-blank entries
       // in "flds". If 0 then they are all blank.
       // Parameter "msgno" must be greater than 0. If not then return 0
       // (with "flds" all blank).
     d GetDCVFlds      pr             5i 0 extproc('GetDCVFlds')
     d   msgno                        5i 0 const
     d   flds                        12          dim(7)

