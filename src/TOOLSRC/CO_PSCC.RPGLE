
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Process Source Compile Commands

       // Parameter 1: IN - Source type:
       //                     RPG
       //                     RPGLE
       //                     other: not supported; exit
       //           2: IN - Source library
       //           3: IN - Source file
       //           4: IN - Source member
       //           5: IN - Command selector
       //                     Selects the commands in the source to be
       //                     processed with QCMDEXC. Each source line
       //                     can contain one command to process. A cmd can
       //                     not continue on the next line. The line must
       //                     be a comment. For type RPG positions 7-9
       //                     must contain "*$X". For type RPGLE the line
       //                     must start with any number of blanks followed
       //                     by "//$X". The rest of the line contains the
       //                     command to be executed. The X denotes the
       //                     command selector, which can be one of the
       //                     following:
       //                       B: "before" commands
       //                       A: "after" commands


      /include QINCSRC,PGM_HEAD2


     fSOURCE    if   f  200        disk    extfile('QTEMP/COPSCCSRC')
     f                                     usropn


     d Main            pr                  extpgm('CO_PSCC')
     d   srctype                     10    const
     d   srclib                      10    const
     d   srcfile                     10    const
     d   srcmbr                      10    const
     d   cmdsel                       1    const

     d ExecCmd         pr
     d   cmd                       5000    const


     d Main            pi
     d   srctype                     10    const
     d   srclib                      10    const
     d   srcfile                     10    const
     d   srcmbr                      10    const
     d   cmdsel                       1    const

     d srcl            ds           200
     d cmd             s            200
     d f               s               n
     d i               s             10i 0

      /free

       *inlR = *on;

       if     srctype <> 'RPG'
          and srctype <> 'RPGLE';
         return;
       endif;

       monitor;
         ExecCmd('DLTF FILE(QTEMP/COPSCCSRC)');
       on-error;
       endmon;

       ExecCmd('CRTPF FILE(QTEMP/COPSCCSRC) RCDLEN(200)');

       ExecCmd(
         'CPYF ' +
           'FROMFILE(' + %trim(srclib) + '/' + %trim(srcfile) + ') ' +
           'TOFILE(QTEMP/COPSCCSRC) ' +
           'FROMMBR(' + %trim(srcmbr) + ') ' +
           'MBROPT(*REPLACE) ' +
           'FMTOPT(*CVTSRC)');

       open SOURCE;

       read SOURCE srcl;
       dow not %eof;

         f = *off;

         select;
         when     srctype = 'RPG'
              and %subst(srcl:7:2) = '*$'
              and %subst(srcl:9:1) = cmdsel;
           f = *on;
           srcl = %subst(srcl:10);
         when srctype = 'RPGLE'
              and %subst(srcl:8:3) = '//$'
              and %subst(srcl:11:1) = cmdsel;
           i = %check(' ':srcl);
           if     i > 0
              and %subst(srcl:i:3) = '//$'
              and %subst(srcl:i+3:1) = cmdsel;
             f = *on;
             srcl = %subst(srcl:i+4);
           endif;
         endsl;

         if f and srcl <> '';
           ExecCmd(srcl);
         endif;

         read SOURCE srcl;
       enddo;

       close SOURCE;

       monitor;
         ExecCmd('DLTF FILE(QTEMP/COPSCCSRC)');
       on-error;
       endmon;

       return;

      /end-free


     p ExecCmd         b
     d ExecCmd         pi
     d   cmd                       5000    const

     d CallQCMDEXC     pr                  extpgm('QCMDEXC')
     d   cmd                       5000    const
     d   cmdlen                      15  5 const

      /free

       CallQCMDEXC(%trim(cmd):%len(%trim(cmd)));

      /end-free
     p                 e

