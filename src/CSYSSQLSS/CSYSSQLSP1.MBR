
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CSYSSQLSP1

       // Service Program: Common System Services / SQL Support
       // Program        : Edit SQL Statement


       // Parameters:

       //   1 I  (20)    : The ID of the (new) SQL statement.


       // NOTE: The record-length of file SQLSTMT, and the specified record
       //       length in the CRTPF command must be equal to the length of
       //       field CSYSSQLSF1.SQLSLINE.


     h bnddir(
     h             'CSYSSQLS'
     h            :'CSYSBASE'
     h       )

      /include QINCSRC,DPGM_HEAD


     fCSYSSQLSF1uf a e           k disk
     fSQLSTMT   uf a f   70        disk    usropn extfile('QTEMP/CSYSSQLSP1')


     d Main            pr                  extpgm('CSYSSQLSP1')
     d   @sqlsid                           const like(SQLSID)


      /include CSYSSQLSS,INCL_API
      /include CSYSBASES,INCL_API


     d TRec            ds                  qualified inz
     d   f                                 like(SQLSLINE)


     d Main            pi
     d   @sqlsid                           const like(SQLSID)

     d m               s             10i 0
     d n               s             10i 0
     d f               s               n
     d errmsg          s            200

      /free

       *inlR = *on;

       errmsg = '';

       dou 0=0;

       if @sqlsid = '';
         errmsg = 'SQL statement ID is mandatory.';
         leave;
       endif;

       // Create temporary file.
       monitor;
         ExecCmd('DLTF QTEMP/CSYSSQLSP1');
       on-error;
       endmon;
       monitor;
         ExecCmd('CRTPF FILE(QTEMP/CSYSSQLSP1) RCDLEN(70) SIZE(*NOMAX)');
       on-error;
         errmsg = 'Could not create temporary file CSYSSQLSP1 in QTEMP';
         leave;
       endmon;

       open SQLSTMT;

       DataBlockClear(0);
       DataBlockClear(1);

       // Read SQL stmt into temporary file.
       n = 0;
       f = *off;
       setll (@sqlsid) CSYSSQLSF1;
       reade (@sqlsid) CSYSSQLSF1;
       dow not %eof;
         if f or SQLSLINE <> '';
           f = *on;
           n = n + 1;
           DataBlockAppend(0:%addr(SQLSLINE):%size(SQLSLINE));
           TRec.f = SQLSLINE;
           write SQLSTMT TRec;
         endif;
         reade (@sqlsid) CSYSSQLSF1;
       enddo;

       // Fill temporary file up to 999 lines.
       SQLSLINE = '';
       for m = n + 1 to 999;
         DataBlockAppend(0:%addr(SQLSLINE):%size(SQLSLINE));
         TRec.f = SQLSLINE;
         write SQLSTMT TRec;
       endfor;

       close SQLSTMT;

       // Edit temporary file with cmd EDTF.
       monitor;
         ExecCmd('EDTF FILE(QTEMP/CSYSSQLSP1)');
       on-error;
         errmsg = 'Error editing SQL statement with command EDTF.';
         leave;
       endmon;

       open SQLSTMT;

       // Check whether the contents in the temporary file did change.
       n = 0;
       m = 0; // recno of last non-blank record
       setll *start SQLSTMT;
       read SQLSTMT TRec;
       dow not %eof;
         SQLSLINE = TRec.f;
         n = n + 1;
         if SQLSLINE <> '';
           m = n;
         endif;
         DataBlockAppend(1:%addr(SQLSLINE):%size(SQLSLINE));
         read SQLSTMT TRec;
       enddo;

       if DataBlockComp(0:1) <> 0;

         // The contents of the temporary file has been changed.
         // Replace SQL stmt in CSYSSQLSF1 with contents in temporary file.

         setll (@sqlsid) CSYSSQLSF1;
         reade (@sqlsid) CSYSSQLSF1;
         dow not %eof;
           delete SQLSREC;
           reade (@sqlsid) CSYSSQLSF1;
         enddo;
         n = 0;
         f = *off;
         setll *start SQLSTMT;
         read SQLSTMT TRec;
         dow     not %eof
             and n < m
             and n < 999;
           n = n + 1;
           if f or TRec.f <> '';
             f = *on;
             SQLSID = @sqlsid;
             SQLSLINENO = n;
             SQLSLINE = TRec.f;
             write SQLSREC;
           endif;
           read SQLSTMT TRec;
         enddo;

       endif;

       enddo;

       if %open(SQLSTMT);
         close(e) SQLSTMT;
       endif;
       monitor;
         ExecCmd('DLTF QTEMP/CSYSSQLSP1');
       on-error;
       endmon;

       if errmsg <> '';
         SndPgmMsg('CPF9897':'QCPFMSG':'*ESCAPE':errmsg);
       endif;

       return;

      /free

