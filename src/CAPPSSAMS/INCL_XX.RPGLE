
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_XX)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_XX


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module XX: Miscellaneous

       // Do NOT include INCL_XX explicitly; use INCL_API instead.
       // The artifacts contained in module XX are not categorized yet
       // and therefore susceptible of being moved to another module.


      /include CAPPSSAMS,INCL_DEFS


       // ----- Prototypes

       // IsGrpSpecial - Is Group Special
       // Return *on if "group" is special, e.g. "*ADMIN", else return *off.
     d IsGrpSpecial    pr              n   extproc('IsGrpSpecial')
     d   group                             const like(TAM_GROUP)

       // GetSpGrpText - Get Special Group Text
       // Return the built-in descriptive text for special group "group.
       // Return blanks if "group" is not special.
     d GetSpGrpText    pr                  like(TAM_TEXT)
     d                                     extproc('GetSpGrpText')
     d   group                             const like(TAM_GROUP)

