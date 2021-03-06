
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_DQ)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_DQ


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module DQ: Database Queries

       // This module is supposed to encapsulate all "business logic" needed
       // to retrieve data from the database associated with this subsystem.

       // Each procedure in this module queries the subsystem's database in
       // in some way, but doesn't change anything and has no side effects
       // (unless explicitly documented).

       // A procedure with a name that begins with "Qds_" fills a data structure
       // with related data items, if successful. The data struct. to be filled
       // is always given with the first parameter "data", and it is defined
       // within one of the include (INCL_*) sources. If the data structure is
       // not shared between procedures (which is most common) it is usually
       // defined together with the procedure's prototype (i.e. in the same
       // source), and has the same name as the procedure which fills it,
       // appended with "$". All shared data structures should be defined in
       // include source "INCL_DEFS".

       // All "Qds" procedures in this module must have a name that starts
       // with "Qds_.._", where .. is the subsystem id.

       // Each "Qds" procedure returns a 2-digit return code indicating success
       // or failure. Return code 0 indicates that the procedure executed
       // without issues. A return code less than 0 indicates a severe error
       // and the contents of the data structure should be ignored. A return
       // code greater than zero means there were some issues, and maybe some
       // data items could not be retrieved. See each procedure's documentation
       // for details.

       // The first three subfields in every "Qds" data structure must be the
       // return code ("rc", ZONED!) which is also returned by the procedure,
       // an (error)message ("msg") which may be blank, and an array with field
       // length 10 and 7 elements ("dbf") which may specify up to 7 database
       // fields and/or (logical) attribute names related to the message. For
       // convenience, use procedures "CAPPBASE/SetQdsDs*" to fill the data
       // structure. The third character of the message (or message id) indi-
       // cates the severity of the message. If the return code is less than
       // zero then "msg" should always contain a fatal message (i.e. the third
       // character must be an "F").

       // The (error)messages are contained in module AM of this service-
       // program, and retrieved with procedure "GetAMsg.." (.. is the two-
       // character subsystem code). These messages all start with a 4-digit
       // number which identifies each message within the module. A message in
       // "DspMsgList" can have up to 130 characters. The actual messages that
       // are returned by "GetAMsg.." have a 7-character id. The first 2 is
       // the subsystem id. The third indicates the severity of the message
       // which is "F" for fatal, "W" for warning and "I" for info. The last
       // 4 characters of the message id consists of the 4 digits with which
       // the message is identified within the module.

       // The following return codes apply to all "Qds" procedures:
       //   -99 (ABF1900) : Error reading data items.
       //    00           : Ok.


      /include CAPPSSAMS,INCL_DEFS


       // ----- Prototypes

       // IsGrpMember - Is Group Member
       // Return *on if "member" is a member of at least one of the
       // non-blank groups "group0" through "group9", else return *off.
       // If "isgroup" is *on then "member" is a group, else "member" is
       // a user-id.
       // A member (group or user-id) is considered to be a member of a
       // group if:
       // - A record in this table exists for that member and group, or
       //   one of the group's successors (i.e. subgroups).
       // - And, the groups along the shortest path from the group, it's
       //   direct successor, the next successor, etc, until the first group
       //   with the member is reached, must all exist in table CAPPSSAMF3
       //   and must be active (MENUGACT).
     d IsGrpMember     pr              n   extproc('IsGrpMember')
     d   member                            const like(TAM_MBRN)
     d   isgroup                       n   const
     d   group0                            const like(TAM_GROUP)
     d   group1                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group2                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group3                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group4                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group5                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group6                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group7                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group8                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group9                            const like(TAM_GROUP)
     d                                           options(*nopass)

       // GroupExists - Group Exists
       // Return *on if "group" exists in the database, else return *off.
       // Always return *on if "group" is special.
     d GroupExists     pr              n   extproc('GroupExists')
     d   group                             const like(TAM_GROUP)

       // GetGrpText - Get Group Text
       // Return the descriptive text of "group", if it exists.
       // Return blanks if it does not exist.
       // Return the built-in text if "group" is special.
     d GetGrpText      pr                  like(TAM_TEXT)
     d                                     extproc('GetGrpText')
     d   group                             const like(TAM_GROUP)

       // IsGrpActive - Is Group Active
       // Return *on if "group" exists in the database and is set
       // to active (MENUGACT = "Y'), else return *off.
       // Always return *on if "group" is special.
     d IsGrpActive     pr              n   extproc('IsGrpActive')
     d   group                             const like(TAM_GROUP)

       // RtvSuperGrps - Retrieve Super Group
       // Retrieve all direct and indirect supergroups (predecessors)
       // of "group".
       // Return the number of supergroups found.
       // Parameter "supergroups" will point to an array of group
       // names (with length equal to field MENUGROUP), in no
       // particular order, containing all supergroups of "group",
       // without duplicates.
       // The memory needed for the array is allocated by the
       // procedure and should be released (deallocated) if it's
       // not needed anymore.
       // Parameter "supergroups" will be *null if 0 is returned.
       // If "active" is given and it's *on then only the active
       // groups are retrieved.
     d RtvSuperGroups  pr            10i 0 extproc('RtvSuperGroups')
     d   group                             const like(TAM_GROUP)
     d   supergroups                   *
     d   active                        n   const options(*nopass)

       // IsGroupUsed - Is Group Used
       // Return one of the following texts to indicate whether a group
       // is used:
       // - '' (blank) : the group is not used;
       // - 'group GROUPNAME' : the group is used as a member in group GROUPNAME;
       // - 'page 999',
       // - 'option XX, page 999',
       // - 'the menu'.
     d IsGroupUsed     pr            30    extproc('IsGroupUsed')
     d   group                             const like(TAM_GROUP)

       // Qds_AM_GroupAll - Group (All Data)
       // Retrieve all data items related to a menu group (CAPPSSAMF3).
       // If the return code is greater than 0 then some data items
       // could not be retrieved and are set to blank or zero.
       // Return codes (and associated message id's if applicable):
       //   -11 (AMF2551) : Group not found.
       //    11 (AMW2552) : Group has more than "CNumGrpMembers" members.
       //                   -> Not retrieved: the rest of the members
     dQds_AM_GroupAll$...
     d                 ds                  qualified inz
         // Return code.
     d   rc                           2  0
         // (Error)message.
     d   msg                        200
         // Database fields.
     d   dbf                         12    dim(7)
         // Group name.
     d   group                             like(TAM_GROUP)
         // Group description.
     d   gtext                             like(TAM_TEXT)
         // Group active?
     d   gact                              like(TAM_ACTIVE)
         // Group member names.
     d   gmembers_n                        like(TAM_MBRN) dim(CNumGrpMembers)
         // Group member types.
     d   gmembers_t                        like(TAM_MBRT) dim(CNumGrpMembers)
         // Number of group members that were read into arrays "gmembers_n"
         // and "gmembers_t" (max."CNumGrpMembers"), i.e. the index of the
         // last non-blank element in "gmembers_n", which is 0 if no members
         // were read.
     d   gmembers#                   10i 0
         // Number of group members in the database, which could be greater
         // than "CNumGrpMembers".
     d   dbgmembers                  10i 0
     dQds_AM_GroupAll  pr             2  0 extproc('Qds_AM_GroupAll')
     d   data                                    likeds(Qds_AM_GroupAll$)
     d   group                             const like(TAM_GROUP)

