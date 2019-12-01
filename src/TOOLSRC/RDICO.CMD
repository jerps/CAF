
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
*/

             CMD

             PARM       KWD(SRCFILE) TYPE(SRCFILE) MIN(1) +
                          PROMPT('Source file')
             PARM       KWD(SRCMBR) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Source member')
             PARM       KWD(TGTLIB) TYPE(*NAME) LEN(10) DFT(*SRCLIB) +
                          SPCVAL((*SRCLIB *SRCLIB)) MIN(0) +
                          PROMPT('Target library')
             PARM       KWD(TGTOBJTYPE) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*DEFAULT) VALUES(*DEFAULT +
                          *MODULE) MIN(0) PROMPT('Target object type')
             PARM       KWD(ACTGRP) TYPE(*NAME) LEN(10) +
                          DFT(*DEFAULT) SPCVAL((*DEFAULT *DEFAULT) +
                          (*STGMDL *STGMDL) (*NEW *NEW) (*CALLER +
                          *CALLER)) MIN(0) PROMPT('Activation group')
             PARM       KWD(TGTRLS) TYPE(*NAME) LEN(10) +
                          DFT(*CURRENT) SPCVAL((*CURRENT *CURRENT) +
                          (*PRV *PRV)) MIN(0) PROMPT('Target release')
             PARM       KWD(INCDBGSRC) TYPE(*CHAR) LEN(10) +
                          RSTD(*YES) DFT(*YES) VALUES(*YES *NO) +
                          MIN(0) PROMPT('Include source for debug')
             PARM       KWD(PARM1) TYPE(*CHAR) LEN(10) MIN(0) +
                          PROMPT('Extra parameter 1')
             PARM       KWD(PARM2) TYPE(*CHAR) LEN(10) MIN(0) +
                          PROMPT('Extra parameter 2')
             PARM       KWD(PARM3) TYPE(*CHAR) LEN(10) MIN(0) +
                          PROMPT('Extra parameter 3')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(10) DFT(*EVENTF) +
                          PROMPT('Option')

 SRCFILE:    QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL +
                          *LIBL)) PROMPT('Library')

