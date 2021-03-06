
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL__MODD)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL__MODD


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module Definitions


      /include CAPPSSAMS,INCL_DEFS


       // ----- Private Record Formats


       // ----- Data Structures

       // Program Status Information
     d PSI            sds                  qualified
         // Main procedure name.
     d   procname        *PROC
         // Program statuscode.
     d   status          *STATUS
         // Previous program statuscode.
     d   pstatus              16     20  0
         // RPG routine.
     d   routine         *ROUTINE
         // Number of parameters passed.
     d   parms           *PARMS
         // Exception id.
     d   excid                40     46
         // Program library.
     d   pgmlib               81     90
         // Message text.
     d   msgtext              91    170
         // Exception id that caused RNX9001.
     d   excidrnx9001        171    174
         // Full name of file of last file operation.
     d   filename            175    184
         // Date (fmt *DATE with 4-digit year) the job entered the system.
     d   jobdate             191    198
         // First 2 digits (century) of the 4-digit year of the job date.
     d   jobcentury          199    200  0
         // Truncated name of file of last file operation.
     d   filename8           201    208
         // Status info on last file used.
     d   statinfo            209    243
         // Job name.
     d   jobname             244    253
         // Job user profile name (user profile which started the job).
     d   jobuser             254    263
         // Job number.
     d   jobnumber           264    269  0
         // Date (fmt UDATE) the program started running in the system.
     d   pgmdate             270    275  0
         // Date (fmt UDATE) of the program running (current system date).
     d   curpgmdate          276    281  0
         // Time (fmt hhmmss) of the program running (current system time).
     d   curpgmtime          282    287  0
         // Date (fmt UDATE) the program was compiled.
     d   compiledate         288    293
         // Time (fmt hhmmss) the program was compiled.
     d   compiletime         294    299
         // Level of the compiler.
     d   compilelvl          300    303
         // Source file name.
     d   srcfname            304    313
         // Source library name.
     d   srclibname          314    323
         // Source file member name.
     d   srcfmbrname         324    333
         // Name of program containing *PROC.
     d   pgmname             334    343
         // Name of module containing *PROC.
     d   modname             344    353
         // Current user (could be different from job user profile name).
     d   curuser             358    367

