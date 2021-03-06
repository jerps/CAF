
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_DC)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_DC


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module DC: Database Commands


       // This module is supposed to encapsulate all "business logic"
       // needed to update data in the database associated with the
       // subsystem.

       // Each public procedure in this module implements a "command" and
       // has a name which starts with "DC_.._", where .. is the two-character
       // subsystem id.

       // A "command" is complete set of operations which changes the
       // database in the subsystem in some way by adding, updating and/or
       // deleting records.

       // The changes one command makes to the database should together form
       // one logical unit that *could* be executed as one transaction.
       // Transaction demarcation - i.e. deciding where a transaction begins
       // and ends - is controlled by the application (i.e. the "client" or
       // program using this module) and not this module. Thus, this module
       // should NEVER begin or end a transaction.

       // Usually, the first parameter of each procedure in this module is
       // named "ctype" with the command type, which can be "*ADD", "*UPDATE",
       // or "*DELETE".

       // The second parameter is typically named "data" and is a data structure
       // containing the database (key) values. It is defined within one of the
       // include (INCL_*) sources. If the data structure is not shared between
       // procedures (which is most common) it is usually defined together with
       // the procedure's prototype (i.e. in the same source), and has the same
       // name as the procedure. All shared data structures should be defined
       // in include source "INCL_DEFS".

       // The subfield names in data structure "data" should be ALL CAPS.

       // For *DELETE, only the key values are relevant.

       // For *ADD or *UPDATE, after the command (the procedure) has been
       // executed successfully, parameter "data" and other parameters with
       // values that are written to the database must contain the same values
       // as what was actually written to the database, which could differ
       // from the original values. E.g., a database field could be assigned
       // a default value or a value could be normalized first (e.g. removing
       // leading blanks) before it is written to the database. Thus, client
       // programs should be aware that the database values passed to the
       // command are not necessarily the same values as in the database.

       // Each command returns a 2-digit return code indicating success or
       // failure. Return code 0 indicates that the command executed without
       // issues. A return code less than 0 indicates a severe error and that
       // the command has failed, i.e. no changes were made to the database.
       // A return code greater than zero means there were some issues, but
       // the command did execute and changes were made to the database.
       // See each command's documentation for details.
       // In general, return codes -30 to -59 indicate a validation error,
       // i.e. not a technical error but a logical/business error (e.g.
       // "client does not exist"). Return codes 30 to 59 indicate a valida-
       // tion message, i.e. not an error but a logical/business issue (e.g.
       // "client reaches credit limit").

       // The following return codes are the same for all commands.
       //   - 1 : Unknown command type.
       //   - 2 : Unsupported command type.
       //   -30 : Validation error(s).
       //   -31 : Record already exist (*ADD).
       //   -32 : Record does not exist (*UPDATE, *DELETE).
       //    .  : Validation error(s).
       //   -59 : "
       //   -99 : Unspecified, severe error.
       //     0 : Ok; command has been executed without issues.
       //    30 : Validation message(s).
       //    31 : "
       //    .  : "
       //    .  : "
       //    59 : "

       // If a command fails and returns a value less than zero, it *should*
       // not have changed anything in the database in any way. The command
       // *could* have been executed within a transaction, or not. In the
       // latter case, any changes are not rolled back. To be safe, ensure
       // that each command only applies changes to the database when it
       // executes successfully, when it returns a value greater than or
       // equal to zero.

       // Each command should document it's possible return values, but only
       // the ones that are specific, not the ones documented above. The
       // return codes above are generic and apply to all procedures. Each
       // procedure *could* return one of these generic return codes.

       // Some commands may support all command types, other ones only a sub-
       // set (e.g. only "*ADD" and "DELETE"). If a command is not supported,
       // the command should return -2;

       // Most commands first do some validation before applying any changes
       // to ensure data integrity and completeness. This may result in 1 or
       // more (error)messages, if issues were encountered. An errormessage
       // describes a severe problem. Other messages describe anything else,
       // such as an inconsistency or incompleteness that has been detected,
       // or simply a remark. One or more error (i.e. fatal) messages means
       // that the command could not be executed in which case it must return
       // a value between -59 and -30 to indicate that the validation step
       // resulted in one or more errormessages. Return code -30 is a generic
       // return code for this. Use return codes -31 to -59 to indicate a
       // more specific error condition, depending on the command. If the
       // validation did not detect any severe errors but it produced some
       // non-fatal (informational) messages, then a value between 30 and 59
       // must be returned. If there where no issues or remarks at all then
       // value 0 must be returned.

       // All validation messages that are produced by a command must be
       // added to array "DspMsgList", which is defined in and exported from
       // *SRVPGM CAPPBASE. Client programs using this module expects to find
       // one or more new messages in "DspMsgLists", if a value between -59
       // and -30, or between 30 and 59 is returned. If the returnvalue is
       // outside this range the client program assumes (or *should* assume)
       // that no messages were added to "DspMsgList" by the command.

       // Returnvalues -30 thru -59 and 30 thru 59 indicate there are
       // messages available which can be displayed on a screen or otherwise
       // presented to a user. All validation messages that are produced by a
       // command must be added to array "DspMsgList". This can be done using
       // procedure "CAPPBASE/AddToDspMsgList". Commands should only add new
       // messages to "DspMsgList", but must not do anything else with array
       // "DspMsgList". For example, clearing this array and other clean-up
       // and/or management is the responsibility of the client program and
       // should be of no concern here.

       // Whenever possible, each new validation message that is added to the
       // list should be associated with max. 7 database field names, so that
       // client programs know which database fields are causing the issues.
       // Each field name can be max. 10 characters long. These names must be
       // put into the last 70 characters of each associated data field (which
       // has length 100). The first field name is put into positions 31-40,
       // the second into positions 41-50, etc. Positions 1-30 are reserved for
       // other uses. Client programs expect that positions 31-100 of associated
       // data fields contains these field names, or that it is *BLANK if the
       // message could not be coupled with field names. E.g., screen programs
       // may choose to highlight the fields on the screen that are associated
       // with these field names. Convenience procedure "CAPPBASE/AddDCVMsg"
       // can be used to add a message together with max. 7 field names.

       // The validation messages are contained in module AM of this service-
       // program, and retrieved with procedure "GetAMsg.." (.. is the two-
       // character subsystem code). These messages all start with a 4-digit
       // number which identifies each message within the module. A message in
       // "DspMsgList" can have up to 130 characters. The actual messages that
       // are returned by "GetAMsg.." have a 7-character id. The first 2 is
       // the subsystem id.. The third indicates the severity of the message
       // which is "F" for fatal, "W" for warning and "I" for info. The last
       // 4 characters of the message id consists of the 4 digits with which
       // the message is identified within the module.

       // IMPORTANT!
       // When one ore more fatal messages are produced by a command, it MUST
       // always return -59 thru -30. A message is fatal if the third character
       // of it's id is an "F".


      /include CAPPSSAMS,INCL_DEFS


       // ----- Prototypes

       // DC_AM_Group - Db Cmd: Group
       // Add, update or delete a menu group.
       // If ctype is *ADD or *UPDATE then parameters "members_n" and
       // "members_i" must be both given to add/update the members of
       // the group. Otherwise only the group record is added/updated.
       // The non-blank elements in members_n contain the member names
       // and their corresponding elements in "members_t" specify their
       // types (0 or 1). Type 0 specifies a group and type 1 specifies
       // a user. When updating the existing members are first deleted
       // from the database. if ctype is *DELETE then "members_n" and
       // "members_t" are ignored.
       // Updating the database is synchronized by locking/releasing
       // data area CAPPSSAMA0. Thus only one program can add, update
       // or delete a group or changing the menu at the same time.
       // Note that a maximum of "CNumGrpMembers" can be specified.
     dDC_AM_Group$     ds                  qualified inz
     d   GROUP                             like(TAM_GROUP)
     d   TEXT                              like(TAM_TEXT)
     d   ACTIVE                            like(TAM_ACTIVE)
     dDC_AM_Group      pr             2  0 extproc('DC_AM_Group')
     d   ctype                       10    const
     d   data                                    likeds(DC_AM_Group$)
     d   members_n                         like(TAM_MBRN)   dim(CNumGrpMembers)
     d                                     options(*nopass)
     d   members_t                         like(TAM_MBRT)   dim(CNumGrpMembers)
     d                                     options(*nopass)

