
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CSYSSQLSP0


       // Service Program: Common System Services / SQL Support
       // Program        : Load Initial Data


      /include QINCSRC,PGM_HEAD1


     fCSYSSQLSF1if a e           k disk


     d Main            pr                  extpgm('CSYSSQLSP0')
     d   inif1                        1    const

     d SqlStmts        s             90    ctdata dim(100)


     d Main            pi
     d   inif1                        1    const

     d i               s             10i 0
     d lineno          s             10i 0
     d sid             s                   like(SQLSID) inz(*allx'00')

      /free

       *inlR = *on;

       if inif1 = '1';
         // Add SQL Statements
         for i = 1 to %elem(SqlStmts);
           clear *all SQLSREC;
           SQLSID = %subst(SqlStmts(i):1:%len(SQLSID));
           if SQLSID <> '';
             if SQLSID = sid;
               lineno = lineno + 1;
             else;
               lineno = 1;
               sid = SQLSID;
             endif;
             SQLSLINENO = lineno;
             SQLSLINE   = %subst(SqlStmts(i):%len(SQLSID)+1);
             write SQLSREC;
           endif;
         endfor;
       endif;

       return;

      /end-free


** SqlStmts
CSYS-000            // Select All SQL Statement ID's
CSYS-000
CSYS-000              SELECT SQLSID
CSYS-000                FROM CSYSSQLSF1
CSYS-000            GROUP BY SQLSID
CSYS-000            ORDER BY SQLSID


CSYS-001            // Select All SQL Statement ID's With First Line And Line Count
CSYS-001
CSYS-001              SELECT A.SQLSID, A.SQLSLINE, COUNT(*)
CSYS-001                FROM CSYSSQLSF1 A, CSYSSQLSF1 B
CSYS-001               WHERE A.SQLSLINENO = 1
CSYS-001                 AND A.SQLSID = B.SQLSID
CSYS-001                 AND A.SQLSID >= ?
CSYS-001            GROUP BY A.SQLSID, A.SQLSLINENO, A.SQLSLINE
CSYS-001            ORDER BY A.SQLSID
