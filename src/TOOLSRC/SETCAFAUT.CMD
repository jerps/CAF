
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
                                                                             +
     Set CAF Authorities                                                     +
                                                                             +
     This command sets several authorities of the objecs in a CAF            +
     library. It will perform the following steps in sequence.               +
                                                                             +
       NOTES:                                                                +
                                                                             +
       > Specify *SAME to skip the respective step.                          +
                                                                             +
       > Be sure to have *ALLOBJ special authority when using this command.  +
                                                                             +
       > Default value *DFT for CAFLIB specifies the CAF library currently   +
         in the library list.                                                +
                                                                             +
     1. OWNER                                                                +
        Set the owner of the library and all objects inside. Specify         +
        *NO for INCLMN to skip the menu file and menu data area objects      +
        (CAPPSSAMF* and CAPPSSAMA*). Specify *ONLY to set the owner of       +
        *only* the menu file and menu data area objects. Specify *NO         +
        for INCLSF to skip the source PF's. Specify *ONLY to set the         +
        owner of *only* the source PF's.                                     +
                                                                             +
     2. PUBAUTNPL, PUBAUTPL, INCLMN, INCLSF                                  +
        Revoke *ALL public authority and then set public authority to        +
        *ALL, *CHANGE, *USE or *EXCLUDE for every object that is >not<       +
        a PF or LF (PUBAUTNPL), and/or for every PF/LF (PUBAUTPL).           +
        Specify *NO for INCLMN to skip the menu file and menu data area      +
        objects (CAPPSSAMF* and CAPPSSAMA*). Specify *ONLY to revoke &       +
        set public authority for *only* the menu file and menu data area     +
        objects. Specify *NO for INCLSF to skip the source PF's. Specify     +
        *ONLY to revoke & set authority for *only* the source PF's.          +
                                                                             +
     3. USRAUTNPL, USRAUTPL, INCLMN, INCLSF                                  +
        Grant (*GRT) or revoke (*RVK) authority to/from a user profile       +
        for every object that is >not< a PF or LF (USRAUTNPL), and/or for    +
        every PF/LF (USRAUTPL). Specify *NO for INCLMN to skip the menu      +
        file and menu data area objects (CAPPSSAMF* and CAPPSSAMA*).         +
        Specify *ONLY to grant or revoke authority for *only* the menu       +
        file and menu data area objects. Specify *NO for INCLSF to skip      +
        the source PF's. Specify *ONLY to grant or revoke authority for      +
        *only* the source PF's.                                              +
                                                                             +
     4. AUTLNPL, AUTLPL, INCLMN, INCLSF                                      +
        Grant (*GRT) or revoke (*RVK) an authorization list for every        +
        object that is >not< a PF or LF (AUTLNPL), and/or for every PF/LF    +
        (AUTLPL). Specify *NO for INCLMN to skip the menu file and menu      +
        data area objects (CAPPSSAMF* and CAPPSSAMA*). Specify *ONLY to      +
        grant or revoke an authorization list for *only* the menu file       +
        and menu data area objects. Specify *NO for INCLSF to skip the       +
        source PF's. Specify *ONLY to grant or revoke an authorization       +
        list for *only* the source PF's.                                     +
                                                                             +
     5. MNUADMAUT                                                            +
        Grant (*GRT) or revoke (*RVK) *CHANGE authority for the menu file    +
        and menu data area objects (CAPPSSAMF* and CAPPSSAMA*) to a user     +
        profile. The user profile name is added to (*GRT) or removed from    +
        (*RVK) the *ADMIN menu group.                                        +
                                                                             +
*/

             CMD        PROMPT('CAF - Set Authorities')
             PARM       KWD(CAFLIB) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          SPCVAL((*DFT *DFT)) MIN(0) PROMPT('CAF +
                          library')
             PARM       KWD(OWNER) TYPE(*NAME) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME *SAME)) MIN(0) +
                          CHOICE('*SAME, user profile') PROMPT('Owner')
             PARM       KWD(PUBAUTNPL) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*SAME) VALUES(*SAME +
                          *CHANGE *USE *EXCLUDE) PROMPT('Public +
                          auth. non-PF/LF')
             PARM       KWD(PUBAUTPL) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SAME) VALUES(*SAME *ALL *CHANGE *USE +
                          *EXCLUDE) PROMPT('Public auth. PF/LF')
             PARM       KWD(USRAUTNPL) TYPE(QUSRAUT) DFT(*SAME) +
                          SNGVAL((*SAME)) PROMPT('User auth. +
                          non-PF/LF')
             PARM       KWD(USRAUTPL) TYPE(QUSRAUT) DFT(*SAME) +
                          SNGVAL((*SAME)) PROMPT('User auth. PF/LF')
             PARM       KWD(AUTLNPL) TYPE(QGRTRVKAL) DFT(*SAME) +
                          SNGVAL((*SAME)) PROMPT('Auth. list +
                          non-PF/LF')
             PARM       KWD(AUTLPL) TYPE(QGRTRVKAL) DFT(*SAME) +
                          SNGVAL((*SAME)) PROMPT('Auth. list PF/LF')
             PARM       KWD(INCLMN) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO *ONLY) +
                          PROMPT('Include menu')
             PARM       KWD(INCLSF) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO *ONLY) +
                          PROMPT('Include source PF')
             PARM       KWD(MNUADMAUT) TYPE(QGRTRVKMA) DFT(*SAME) +
                          SNGVAL((*SAME)) PROMPT('Menu adm. *CHANGE +
                          auth.')

 QGRTRVKAL:  QUAL       TYPE(*NAME) LEN(10) MIN(1) CHOICE('*SAME, +
                          auth. list')
             QUAL       TYPE(*CHAR) LEN(10) RSTD(*YES) VALUES(*GRT +
                          *RVK) MIN(1) PROMPT('Grant or Revoke')
 QGRTRVKMA:  QUAL       TYPE(*NAME) LEN(10) MIN(1) CHOICE('*SAME, +
                          user profile')
             QUAL       TYPE(*CHAR) LEN(10) RSTD(*YES) VALUES(*GRT +
                          *RVK) MIN(1) PROMPT('Grant or Revoke')
 QUSRAUT:    QUAL       TYPE(*NAME) LEN(10) MIN(1) CHOICE('*SAME, +
                          user profile')
             QUAL       TYPE(*CHAR) LEN(10) RSTD(*YES) VALUES(*ALL +
                          *CHANGE *USE *EXCLUDE) MIN(1) +
                          PROMPT('Authorization')
             QUAL       TYPE(*CHAR) LEN(10) RSTD(*YES) VALUES(*GRT +
                          *RVK) MIN(1) PROMPT('Grant or Revoke')

             DEP        CTL(&INCLMN *EQ *ONLY) PARM((&INCLMN *NE +
                          &INCLSF))

