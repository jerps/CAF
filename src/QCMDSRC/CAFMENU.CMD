
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
                                                                             +
     CAF - Menu                                                              +
                                                                             +
*/

             CMD        PROMPT('CAF - Menu')

             PARM       KWD(MODE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*DISPLAY) VALUES(*DISPLAY *UPDATE) +
                          PROMPT('Mode')
             PARM       KWD(SPCBHVR) TYPE(*CHAR) LEN(10) +
                          CHOICE('VWX') PROMPT('Special behavior +
                          codes')

