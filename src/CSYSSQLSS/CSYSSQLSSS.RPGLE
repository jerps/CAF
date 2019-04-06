
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module SS for *SRVPGM CSYSSQLS

       // Service Program: Common System Services / SQL Support
       // Module         : Stmt Storage
       //                  Provides functionality to manage stored SQL statements


      /DEFINE CSYSSQLS_MODULE
      /DEFINE CSYSSQLS_CSYSSQLSSS

      /include CSYSSQLSS,INCL__MODH


     fCSYSSQLSF1if   e           k disk    usropn


      /include CSYSSQLSS,INCL_SS

      /include CSYSSQLSS,INCL__SS

      /include CSYSSQLSS,INCL__MODD


       // ----- Implementation


     p SqlsRtvStmt     b                   export
     d SqlsRtvStmt     pi         30000    varying
     d   sid                               const like(TSQLS_ID)
     d   all                           n   const options(*nopass)

     d ss              s                   like(SqlsRtvStmt)
     d of              s               n

      /free

       ss = '';

       of = %open(CSYSSQLSF1);
       if not of;
         open CSYSSQLSF1;
       endif;

       setll (sid) CSYSSQLSF1;
       reade (sid) CSYSSQLSF1;
       dow not %eof;
         if        %parms > 1
               and all
            or     SQLSLINE <> ''
               and (   %len(%triml(SQLSLINE)) < 2
                    or %subst(%triml(SQLSLINE):1:2) <> '//');
           if %len(ss) + %len(SQLSLINE) > 30000;
             ss = '';
             leave;
           endif;
           ss = ss + SQLSLINE;
         endif;
         reade (sid) CSYSSQLSF1;
       enddo;

       if not of;
         close CSYSSQLSF1;
       endif;

       return ss;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModSS       b                   export
     dI_RlsModSS       pi

      /free

       close(e) *ALL;

       return;

      /end-free
     p                 e

