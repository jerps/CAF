
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
                                                                             +
     CAF - Menu Groups: Work with                                            +
                                                                             +
*/

             CMD        PROMPT('CAF - Menu Groups: Work with')

             PARM       KWD(MODE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*DISPLAY) VALUES(*DISPLAY *EDIT +
                          *SELECT) MIN(0) PROMPT('Mode')
             PARM       KWD(SPCBHVR) TYPE(*CHAR) LEN(10) MIN(0) +
                          CHOICE('AIJKVWX') PROMPT('Special +
                          behavior codes')

