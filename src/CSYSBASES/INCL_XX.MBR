
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_XX)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_XX


       // INCLUDE: *SRVPGM CSYSBASE

       // Module XX: miscellaneous


       // Do NOT include INCL_XX explicitly; use INCL_API instead.
       // The artifacts contained in module XX are not categorized yet
       // and therefore susceptible of being moved to another module.


      /include CSYSBASES,INCL_DEFS


       // ----- Prototypes

       // RtvSysName - Retrieve System Name
       // Return the system name. Return blanks if not successful.
     d RtvSysName      pr             8    extproc('RtvSysName')

       // GetSysBaseValue - Get Sysbase Value
       // Return the SysBase value for "key".
       // Return blanks if not found.
     d GetSysBaseValue...
     d                 pr           100    extproc('GetSysBaseValue')
     d   key                         10    const

       // RtvInitWorkDir - Retrieve Initial Working Directory
       // Return the initial working directory for the current user.
       // Return blanks if not available (e.g. no authority).
     d RtvInitWorkDir  pr           200    extproc('RtvInitWorkDir')

       // MaxInt - Maximum Integer
       // Return the maximum integer given with parameters "int*".
     d MaxInt          pr            20i 0 extproc('MaxInt')
     d   int01                       20i 0 const
     d   int02                       20i 0 const
     d   int03                       20i 0 const options(*nopass)
     d   int04                       20i 0 const options(*nopass)
     d   int05                       20i 0 const options(*nopass)
     d   int06                       20i 0 const options(*nopass)
     d   int07                       20i 0 const options(*nopass)
     d   int08                       20i 0 const options(*nopass)
     d   int09                       20i 0 const options(*nopass)
     d   int10                       20i 0 const options(*nopass)
     d   int11                       20i 0 const options(*nopass)
     d   int12                       20i 0 const options(*nopass)
     d   int13                       20i 0 const options(*nopass)
     d   int14                       20i 0 const options(*nopass)
     d   int15                       20i 0 const options(*nopass)
     d   int16                       20i 0 const options(*nopass)
     d   int17                       20i 0 const options(*nopass)
     d   int18                       20i 0 const options(*nopass)
     d   int19                       20i 0 const options(*nopass)
     d   int20                       20i 0 const options(*nopass)

       // MinInt - Minimum Integer
       // Return the minimum integer given with parameters "int*".
     d MinInt          pr            20i 0 extproc('MinInt')
     d   int01                       20i 0 const
     d   int02                       20i 0 const
     d   int03                       20i 0 const options(*nopass)
     d   int04                       20i 0 const options(*nopass)
     d   int05                       20i 0 const options(*nopass)
     d   int06                       20i 0 const options(*nopass)
     d   int07                       20i 0 const options(*nopass)
     d   int08                       20i 0 const options(*nopass)
     d   int09                       20i 0 const options(*nopass)
     d   int10                       20i 0 const options(*nopass)
     d   int11                       20i 0 const options(*nopass)
     d   int12                       20i 0 const options(*nopass)
     d   int13                       20i 0 const options(*nopass)
     d   int14                       20i 0 const options(*nopass)
     d   int15                       20i 0 const options(*nopass)
     d   int16                       20i 0 const options(*nopass)
     d   int17                       20i 0 const options(*nopass)
     d   int18                       20i 0 const options(*nopass)
     d   int19                       20i 0 const options(*nopass)
     d   int20                       20i 0 const options(*nopass)

       // CondValChar - Conditional Value (Character)
       // Return the value of character field "val1" if "cond" is true,
       // else return the value of "val2".
     d CondValChar     pr          1000    varying
     d                                     extproc('CondValChar')
     d   cond                          n   const
     d   val1                      1000    const varying
     d   val2                      1000    const varying

       // CondValInt - Conditional Value (Integer)
       // Return the value of integer field "int1" if "cond" is true,
       // else return the value of "int2".
     d CondValInt      pr            20i 0 extproc('CondValInt')
     d   cond                          n   const
     d   int1                        20i 0 const
     d   int2                        20i 0 const

       // CondValDec - Conditional Value (Decimal)
       // Return the value of decimal field "val1" if "cond" is true,
       // else return the value of "val2".
     d CondValDec      pr            30  9 extproc('CondValDec')
     d   cond                          n   const
     d   val1                        30  9 const
     d   val2                        30  9 const

       // SortBytes - Sort Bytes
       // Sort one or more consecutive blocks of bytes (an array) in memory.
       // The first block starts at address "first". The number of consecu-
       // tive blocks to sort is given with "num". The size (in bytes) of
       // each block is given with "bsize". An optional comparator can be
       // given with parameter "comp". This comparator is a procedure which
       // must return an integer (-1, 0 or 1) and it must have two pointer
       // parameters. The parameters point to two blocks which are compared
       // using this procedure. If the first block of bytes is considered
       // "less" than the second block the procedure must return -1. If the
       // first block of bytes is considered "greater" than the second block
       // the procedure must return 1. If both blocks are considered equal
       // the procedure must return 0. Any other return value gives unpredic-
       // table results.
       // The comparator must be defined like (keyword "value" is mandatory).
       //   d Comparator      pr            10i 0
       //   d   value1                        *   value
       //   d   value2                        *   value
       // If the comparator is not given then a default comparator is used.
       // The default comparator simply compares two blocks of bytes as a
       // whole, which results in the blocks being sorted in ascending order
       // or, if option "*INVERSE" is used, in descending order.
       // If "bsize" is greater than 32767 and the default comparator is used
       // then only the first 32767 bytes of the two blocks are compared.
       // Calling this procedure with "num" or "bsize" being less than 1 has
       // no effect.
       // Optional parameter "option" can be one of the following:
       //   *INVERSE : Inverse the comparator, i.e. if the comparator returns
       //              -1 then this is interpreted as "greater than", etc.
     d SortBytes       pr                  extproc('SortBytes')
     d   first                         *   const
     d   num                         10i 0 const
     d   bsize                       10i 0 const
     d   comp                          *   const options(*omit:*nopass) procptr
     d   option                      10    const options(*nopass)

       // RtvObjText - Retrieve Object Text
       // Retrieve the text description of the object identified with
       // "name", "type" and "lib". Return blanks if the object is not
       // found, not accessible, or if some error occurred.
       // Parameter "lib" may contain "*CURLIB" or "*LIBL" as special
       // values. If "lib" is not given, "*LIBL" is assumed.
     d RtvObjText      pr            50    extproc('RtvObjText')
     d   name                        10    const
     d   type                        10    const
     d   lib                         10    const options(*nopass)

       // RtvUsrPrfGrps - Retrieve User Profile Groups
       // Retrieve the group profile and up to 15 supplemental groups
       // for user profile "user". Return the number of group profiles
       // that where retrieved with parameter "num". Return an array
       // array of 16 10-character elements. The first element contains
       // the group profile and the rest contain the supplemental
       // groups. Return a blank array with "num" having value 0 if
       // an error occurred or if "user" has no group profile and has
       // and has no supplemental groups.
     d RtvUsrPrfGrps   pr            10    dim(16) extproc('RtvUsrPrfGrps')
     d   user                        10    const
     d   num                         10i 0

       // IsSrcPF - Is Source Physical File
       // Return *on if the file identified with "name" and "lib"
       // is a source physical file, else return *off.
       // Return *off if some error occurred.
       // Parameter "lib" may contain "*CURLIB" or "*LIBL" as special
       // values. If "lib" is not given, "*LIBL" is assumed.
     d IsSrcPF         pr              n   extproc('IsSrcPF')
     d   name                        10    const
     d   lib                         10    const options(*nopass)

       // ExecCmd - Execute Command
       // Execute the OS/400 command string in parameter "cmd".
     d ExecCmd         pr                  extproc('ExecCmd')
     d   cmd                       5000    const

       // ExecCmdCE - Execute Command and Catch Exception
       // Execute the OS/400 command string in parameter "cmd" and return
       // *on (with blank "errmsg") if the command executed successfully.
       // Return *off with "errmsg" set to an error message if an
       // exception is generated.
     d ExecCmdCE       pr              n   extproc('ExecCmdCE')
     d   errmsg                     200
     d   cmd                       5000    const

       // PromptCmd - Prompt Command
       // Prompt the command string in parameter "cmd" and return the
       // (changed) command string with parameter "chgcmd". Return *on
       // if there were no problems.
       // The accepted command syntax is the same as when entering ILE
       // CL program statements in SEU (member type CLLE). Prompts include
       // the command label and comment. Variable names are allowed.
       // Return *off with "errmsg" set to an error message if an
       // exception is generated. Parameter "chgcmd" should be ignored
       // if *off is returned.
     d PromptCmd       pr              n   extproc('PromptCmd')
     d   errmsg                     200
     d   cmd                       5000    const
     d   chgcmd                   30000

       // RtvMsgfText - Retrieve Messagefile Text
       // Retrieve the complete message text (i.e. includes replacement data)
       // of a pre-defined message in a messagefile. Parameters "repldata" and
       // "msgfile" are optional. If "repldata" is not given then blanks will
       // be used as the replacement data. If "msgfile" is not given then the
       // default messagefile, "CDftMsgf", is assumed.
     d RtvMsgfText     pr           500    extproc('RtvMsgfText')
     d                                     varying
     d   msgid                        7    const
     d   repldata                   500    const options(*nopass)
     d   msgfile                     10    const options(*nopass)

       // DspStatMsg - Display Status Message
     d DspStatMsg      pr                  extproc('DspStatMsg')
     d   msg                        150    const

       // SndPgmMsg - Send Program Message
       // Parameters:
       //   "msgtype"   : *COMP,   *DIAG,   *ESCAPE  ,*INFO    ,*INQ
       //                 *NOTIFY, *RQS,    *STATUS
       //                 default = *INFO
       //   "msgdata"   : default = *BLANKS (length = 0)
       //   "libname"   : default = *LIBL
       //   "csentry"   : *, *CTLBDY,  *EXT
       //                 default = *CTLBDY
       //   "cscounter" : default = 1
     d SndPgmMsg       pr                  extproc('SndPgmMsg')
     d   msgid                        7    const
     d   filename                    10    const
     d   msgtype                     10    const options(*nopass:*omit)
     d   msgdata                    500    const options(*nopass:*omit)
     d   libname                     10    const options(*nopass:*omit)
     d   csentry                     10    const options(*nopass:*omit)
     d   cscounter                   10i 0 const options(*nopass:*omit)

       // DataBlockAppend - Data Block: Append
       // Append a copy of the bytes (the data) pointed to by "data"
       // to the block of bytes identified with "id", which may be
       // empty (zero bytes) if this is the first time "id" is used.
       // The size of the data to copy and append is given in bytes
       // with parameter "size".
       // Nothing happens if "id" is less than 0, or "size" is less
       // than 1.
     d DataBlockAppend...
     d                 pr                  extproc('DataBlockAppend')
     d   id                           1  0 const
     d   data                          *   const
     d   size                        10i 0 const

       // DataBlockClear - Data Block: Clear
       // Clear (release) the data block identified with "id".
       // If "id" is not given then all data blocks are cleared.
       // Nothing happens if "id" is given and is less than 0.
     d DataBlockClear  pr                  extproc('DataBlockClear')
     d   id                           1  0 const options(*nopass)

       // DataBlockComp - Data Block: Compare
       // Compare data blocks "id1" or "id2". Return -1 if data
       // block "id1" is less than data block "id2". Return 1 if
       // data block "id1" is greater than data block "id2". Return
       // 0 if both data blocks are equal.
       // Return 0 if "id1" or "id2" is less than 0.
       // If the two data blocks are unequal in size, the smaller
       // block is considered to be padded with x'00'.
     d DataBlockComp   pr            10i 0 extproc('DataBlockComp')
     d   id1                          1  0 const
     d   id2                          1  0 const

       // GetBuffldId - Get Bufferfield with Id
       // Search the buffer pointed to by "buf" and return the field that
       // starts with "id", or return *BLANKS if there is no such field.
       // Parameter "buf" points to a buffer consisting of 2 or more fields
       // which have the same length and are laid out consecutively in the
       // buffer. The first field is not searched because it specifies the
       // length of each field in the buffer, and the number of fields
       // following the first one. Positions 1-3 in the first field must
       // contain exactly 3 digits which specify the length of each field
       // in the buffer. Positions 4-7 in the first field must contain
       // exactly 4 digits which specify the number of fields following
       // the first field (i.e. the total number of fields minus 1).
     d GetBuffldId     pr           999    extproc('GetBuffldId')
     d   buf                           *   const
     d   id                          20    const varying

       // CErrNoInt - C Errno as Integer
       // Return the C "errno" variable as an integer.
     d CErrNoInt       pr            10i 0 extproc('CErrNoInt')

       // CErrNoText - C Errno as Text
       // Return the C "errno" variable as text.
     d CErrNoText      pr           200    extproc('CErrNoText')

       // CStrCrt - C-style String Create
       // Return a pointer to a new C-style (null terminated) string,
       // created from "text".
     d CStrCrt         pr              *   extproc('CStrCrt')
     d   string                        *   const options(*string)

       // CStrBldInit - C-style String Builder: Init
       // This procedure must be called first before building a C-style
       // (null terminated) string by calling procedure "CStrBldAppend"
       // one or more times.
       // Parameter "chsize" (chunk size) is the number of bytes that is
       // allocated when more memory is needed. If not given or less than
       // 10 it defaults to 200.
       // Return a pointer to the new string with length 0 (i.e. just the
       // null terminator).
       // Call "CStrBldAppend" to append characters to this string. Do not
       // deallocate the string while appending.
       // When this procedure is called a new string is created and the
       // previous one is simply forgotten (not deallocated). So make
       // sure to save the current string's pointer, or deallocate it,
       // before calling this procedure.
     d CStrBldInit     pr              *   extproc('CStrBldInit')
     d   chsize                      10i 0 const options(*nopass)

       // CStrBldAppend - C-style String Builder: Append
       // Append "string" to the string that was created before with
       // "CStrBldAppend" and return it's pointer. The returned pointer
       // is different than previous calls of "CStrBldInit"/"CStrBldAppend"
       // if the allocated memory has been extended.
       // If "slen" is given it contains the length of the string after
       // appending "string".
       // A string can not be longer than "CMaxCStringLen". If appending
       // "string" would result in exceeding this length then nothing is
       // appended and the procedure simply returns the pointer. Parameter
       // "slen" can be used to check this as it won't change in this case.
       // Storage is allocated in chunks with size "chsize" ("CStrBldInit").
       // When the string is deallocated use "CStrBldInit" to build a new
       // string.
     d CStrBldAppend   pr              *   extproc('CStrBldAppend')
     d   string                        *   const options(*string)
     d   slen                        10i 0       options(*nopass)

