
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
                                                                             +
     Copy CAF Data                                                           +
                                                                             +
     This command copies all data contained in physical files and            +
     data areas from one CAF library (source) to another (target),           +
     replacing the data in the target library.                               +
                                                                             +
     The following data is copied:                                           +
                                                                             +
     * Data area's                                                           +
       CAPPSSAMA0                                                            +
                                                                             +
     * Physical files                                                        +
       CSYSBASEF0                                                            +
       CSYSBASEF1                                                            +
       CSYSBASEF2                                                            +
       CSYSSQLSF1                                                            +
       CAPPSSAMF1                                                            +
       CAPPSSAMF2                                                            +
       CAPPSSAMF3                                                            +
       CAPPSSAMF4                                                            +
                                                                             +
*/

             CMD        PROMPT('CAF - Copy Data')
             PARM       KWD(SLIB) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          REL(*NE &TLIB) SPCVAL((*DFT *DFT)) MIN(0) +
                          PROMPT('Source library')
             PARM       KWD(TLIB) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          REL(*NE &SLIB) SPCVAL((*DFT *DFT)) MIN(0) +
                          PROMPT('Target library')


