
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL__DQ)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL__DQ


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module DQ: Database Queries

       // Internal


       // ----- Prototypes

       // DetectGroupCycle - Detect Group Cycle
       // Return *on if at least one cycle is detected in the graphs where
       // "group" is a supergroup of a non-blank element in "subgroups",
       // all direct and indirect predecessors (supergroups) of "group",
       // and all direct and indirect successors (subgroups) of the element
       // in "subgroups".
       // Return *off if no cycle was detected.
       // If a cycle is detected, parameter ""cyclegrp" contains the group
       // that was last visited. Parameter "cyclepath" contains (part of)
       // the path of group names of the cycle. The path is in the following
       // format: g>g>g... where g is a group name.
     dI_DetectGroupCycle...
     d                 pr              n   extproc('I_DetectGroupCycle')
     d   group                             const like(TAM_GROUP)
     d   subgroups                         const like(TAM_MBRN)
     d                                           dim(CNumGrpMembers)
     d   cyclegrp                                like(TAM_GROUP)
     d   cyclepath                   80

       // I_RlsModDQ - Release Module DQ
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this module. If it's not called then
       // these resources are automatically released when the activation
       // group in which the module has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     dI_RlsModDQ       pr                  extproc('I_RlsModDQ')

