
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
     Specify *SAME to skip the respective step.                              +
                                                                             +
     1. The owner of the library and all objects in it can be set            +
        to a new one.                                                        +
                                                                             +
     2. An authorization list can be specified for all non-file              +
        objects and/or PF/LF file objects. If *SAME is not specified         +
        then specify *GRT to grant or *RVK to revoke the authorization       +
        lists for the objects. Specify *NO for INCLMDAUT to skip the         +
        menu file and data area objects (CAPPSSAMF* and CAPPSSAMD*).         +
        Specify *ONLY for INCLMDAUT to *only* process the menu file          +
        and data area objects. Specify *YES for INCLSPFAUT to include        +
        the source PF's. Specify *ONLY to *only* process te source PF's.     +
                                                                             +
     3. Public authority of all non-file objects and/or PF/LF file           +
        objects can be set to *USE, *EXCLUDE or *AUTL. If set then all       +
        public authority is first revoked. Specify *NO for INCLMDAUT         +
        to skip the menu file and data area objects (CAPPSSAMF* and          +
        CAPPSSAMD*). Specify *ONLY for INCLMDAUT to *only* process           +
        the menu file and data area objects. Specify *YES for INCLSPFAUT     +
        to include the source PF's. Specify *ONLY to *only* process the      +
        source PF's.                                                         +
                                                                             +
     4. A user profile name can be given which has the role of the           +
        menu administrator. If *SAME is not specified then specify           +
        *GRT to grant or *RVK to revoke *CHANGE authorization for            +
        the menu file and data area objects (CAPPSSAMF* and CAPPSSAMD*).     +
        Also, the user profile name is added to (*GRT) or removed from       +
        (*RVK) the *ADMIN menu group.                                        +
                                                                             +
     Be sure to have *ALLOBJ special authority when using this command.      +
                                                                             +
*/

             CMD        PROMPT('CAF - Set Authorities')
             PARM       KWD(CAFLIB) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          SPCVAL((*DFT *DFT)) MIN(0) PROMPT('CAF +
                          library')
             PARM       KWD(OWNER) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          CHOICE('*SAME, user profile') PROMPT('Owner')
             PARM       KWD(AUTLNF) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          CHOICE('*SAME, aut list') +
                          PROMPT('Non-file aut list')
             PARM       KWD(AUTLNFGR) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*GRT) VALUES(*GRT *RVK) +
                          PROMPT('Non-file aut list GRT/RVK')
             PARM       KWD(AUTLPFLF) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          CHOICE('*SAME, aut list') PROMPT('PF/LF +
                          aut list')
             PARM       KWD(AUTLPFLFGR) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*GRT) VALUES(*GRT *RVK) +
                          PROMPT('PF/LF aut list GRT/RVK')
             PARM       KWD(PUBAUTNF) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SAME) VALUES(*SAME *USE *EXCLUDE +
                          *AUTL) PROMPT('Public aut non-file')
             PARM       KWD(PUBAUTPFLF) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*SAME) VALUES(*SAME *USE +
                          *EXCLUDE *AUTL) PROMPT('Public aut PF/LF')
             PARM       KWD(INCLMDAUT) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*YES) VALUES(*YES *NO +
                          *ONLY) PROMPT('Include menu data aut')
             PARM       KWD(INCLSPFAUT) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*NO) VALUES(*YES *NO +
                          *ONLY) PROMPT('Include source PF aut')
             PARM       KWD(MNUADM) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          CHOICE('*SAME, user profile') +
                          PROMPT('Menu adm. *CHANGE aut')
             PARM       KWD(MNUADMGR) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*GRT) VALUES(*GRT *RVK) PROMPT('Menu +
                          adm. *CHANGE aut GRT/RVK')

