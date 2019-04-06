
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
                                                                             +
     CAF Source To Streamfile                                                +
                                                                             +
*/

             CMD        PROMPT('CAF Source To Streamfile')
             PARM       KWD(CAFLIB) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          SPCVAL((*DFT *DFT)) MIN(0) PROMPT('CAF +
                          library')
             PARM       KWD(STMFATH) TYPE(*CHAR) LEN(100) DFT(*SAME) +
                          PROMPT('Streamfile path')

