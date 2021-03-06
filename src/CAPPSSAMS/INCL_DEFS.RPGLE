
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_DEFS)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_DEFS


       // INCLUDE: *SRVPGM CAPPSSAM

       // Definitions


       // ----- Prerequisite Service Program Definitions

      /include CAPPBASES,INCL_DEFS
      /include CSYSBASES,INCL_DEFS


       // ----- Constants

       // Special (built-in) groups
     dCSgAdmin         c                   '*ADMIN'
     dCSgAll           c                   '*ALL'
     dCSgNone          c                   '*NONE'

       // Group inverse character
     dCCharGrpInv      c                   '!'

       // Special behavior codes.
       // Each constant starting with "CMsb" specifies a special behavior
       // that can be specified for a menu, a page and/or an option.
       // - Confirm perform option.
     dCMsbConfPO       c                   'C'
       // - Use command handler program CAPPSSAMCH.
     dCMsbUseCH        c                   'H'
       // - Perform command sequence 1-5.
     dCMsbPCS1         c                   '1'
     dCMsbPCS2         c                   '2'
     dCMsbPCS3         c                   '3'
     dCMsbPCS4         c                   '4'
     dCMsbPCS5         c                   '5'

       // All special behavior codes that are supported for
       // an option, a page or the menu.
     dCMssbOption      c                   'CH12345'
     dCMssbPage        c                   'CH12345'
     dCMssbMenu        c                   'CH12345'

       // Number of pages that can be defined for the menu.
     dCNumPages        c                   999
       // Number of slots on a page (3 strips).
     dCNumSlots        c                   45
       // Number of slots on a vertical strip.
     dCNumVSlots       c                   15
       // Number of groups that can be specified for an option,
       // a page or the menu.
     dCNumGroups       c                   9
       // Number of members that can be specified for a group.
     dCNumGrpMembers   c                   200

       // Each constant below ("CEf..*" where .. is the subsystem id)
       // defines a (database) field or (logical) attribute name which
       // can be associated with a message that is produced within
       // this service program (e.g. with procedure "AddToDspMsgList"
       // or "SetQdsDs" in CAPPBASE).
     dCEfAMGROUP       c                   'AMGROUP'
     dCEfAMTEXT        c                   'AMTEXT'
     dCEfAMACTIVE      c                   'AMACTIVE'
     dCEfAMMBRT        c                   'AMMBRT'
     dCEfAMMBRN        c                   'AMMBRN'
     dCEfAMMGROUP      c                   'AMMGROUP'
     dCEfAMMCOMMAND    c                   'AMMCOMMAND'
     dCEfAMMSPECB      c                   'AMMSPECB'
     dCEfAMPGROUP      c                   'AMPGROUP'
     dCEfAMPCOMMAND    c                   'AMPCOMMAND'
     dCEfAMPSPECB      c                   'AMPSPECB'
     dCEfAMOGROUP      c                   'AMOGROUP'
     dCEfAMOCOMMAND    c                   'AMOCOMMAND'
     dCEfAMOSPECB      c                   'AMOSPECB'
     dCEfAMOTEXT       c                   'AMOTEXT'
     dCEfAMOCHOICE     c                   'AMOCHOICE'


       // ----- Public Record Formats

       // This section defines PUBLIC record formats that are relevant
       // for this subsystem as external data structures.

       // Private record formats should be defined in member INCL__MODD.

       // Each format's name is equal to the physical file name, prefixed
       // with "Erf".

       // Each external data structure that defines a database record format
       // is conditioned with a condition-name that begins with "ERF_", which
       // is followed by the physical file name. This ensures that the same
       // external record format is only defined once.

      /IF NOT DEFINED(ERF_CAPPSSAMFR)
      /DEFINE ERF_CAPPSSAMFR
     dErfCAPPSSAMFR  e ds                  extname(CAPPSSAMFR)
      /ENDIF


       // ----- Data Structures

