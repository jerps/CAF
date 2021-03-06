
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSSQLS_INCL_SS)
      /EOF
      /ENDIF
      /DEFINE CSYSSQLS_INCL_SS


       // INCLUDE: *SRVPGM CSYSSQLS

       // Module SS: Statement Storage


       // Provides functionality to manage stored SQL statements.
       // The SQL statements are stored in file CSYSSQLSF1.


      /include CSYSSQLSS,INCL_DEFS


       // SqlsRtvStmt - Retrieve Statement
       // Return the SQL statement stored in file CSYSSQLSF1, which is
       // identified with "sid". Read field SQLSLINE and append it to the
       // the result one or more times. Return an empty (length 0) result
       // if the statement could not be retrieved.
       // By default, all lines (SQLSLINE) in the statement where the first
       // two non-blank characters are "//", or which are completely blank,
       // are ignored (i.e. not included in the result). If parameter "all"
       // is *on then all lines are returned.
       // Beware that no more than 30000 characters can be retrieved with
       // this procedure. If the statement to retrieve is longer than 30000
       // characters then nothing ('') is returned.
     d SqlsRtvStmt     pr         30000    varying
     d                                     extproc('SqlsRtvStmt')
     d   sid                               const like(TSQLS_ID)
     d   all                           n   const options(*nopass)

