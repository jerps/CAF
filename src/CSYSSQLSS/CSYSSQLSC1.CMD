
/*                                                                           +
     (c) 2019 John Erps                                                      +
     This software is licensed under the MIT license (see LICENSE)           +
                                                                             +
                                                                             +
     Service Program: Common System Services / SQL Support                   +
     Command:         Edit SQL Statement                                     +
                      Calls program CSYSSQLSP1                               +
                                                                             +
*/

             CMD        PROMPT('Edit SQL Statement')

             PARM       KWD(ID) TYPE(*CHAR) LEN(20) MIN(1) PROMPT('ID')

