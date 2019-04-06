
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module CI for *SRVPGM CSYSSQLS

       // Service Program: Common System Services / SQL Support
       // Module         : Call Interface
       //                  Provides a simplified API for the SQL CLI.


       // Currently this implementation only supports 1 connection
       // and up to 99 cursors. The connection always connects with
       // the *LOCAL database.


      /DEFINE CSYSSQLS_MODULE
      /DEFINE CSYSSQLS_CSYSSQLSCI

      /include CSYSSQLSS,INCL__MODH


      /include CSYSSQLSS,INCL_CI
      /include CSYSBASES,INCL_TU

      /include CSYSSQLSS,INCL__CI

      /include CSYSSQLSS,INCL__MODD


       // ----- SQL CLI API Defs

       // General purpose constants
     d SQL_FALSE       c                   0
     d SQL_TRUE        c                   1
     d SQL_NULL_DATA   c                   -1
     d SQL_NTS         c                   -3
     d SQL_SQLSTATE_SIZE...
     d                 c                   5
     d SQL_MAX_MESSAGE_LENGTH...
     d                 c                   512
     d SQL_MAX_OPTION_STRING_LENGTH...
     d                 c                   128

       // Templates for SQL data types
     d SQLSMALLINT     s              5i 0 based(Template)
     d SQLUSMALLINT    s              5u 0 based(Template)
     d SQLUINTEGER     s             10u 0 based(Template)
     d SQLDOUBLE       s              8f   based(Template)
     d SQLREAL         s              4f   based(Template)
     d SQLINTEGER      s             10i 0 based(Template)
     d SQLHENV         s             10i 0 based(Template)
     d SQLHDBC         s             10i 0 based(Template)
     d SQLHSTMT        s             10i 0 based(Template)
     d SQLHDESC        s             10i 0 based(Template)
     d SQLHANDLE       s             10i 0 based(Template)
     d SQLRETURN       s                   like(SQLINTEGER) based(Template)
     d SFLOAT          s              4f   based(Template)
     d SQLPOINTER      s               *   based(Template)
     d SQLHWND         s               *   based(Template)

       // Null values
     d SQL_NULL_HENV   c                   0
     d SQL_NULL_HDBC   c                   0
     d SQL_NULL_HSTMT  c                   0


      // Return values
     d SQL_SUCCESS     c                   0
     d SQL_SUCCESS_WITH_INFO...
     d                 c                   1
     d SQL_NO_DATA_FOUND...
     d                 c                   100
     d SQL_NEED_DATA...
     d                 c                   99
     d SQL_NO_DATA...
     d                 c                   100
     d SQL_ERROR       c                   -1
     d SQL_INVALID_HANDLE...
     d                 c                   -2
     d SQL_STILL_EXECUTING...
     d                 c                   2

       // Values for SQLFreeStmt
     d SQL_CLOSE       c                   0
     d SQL_DROP        c                   1
     d SQL_UNBIND      c                   2
     d SQL_RESET_PARAMS...
     d                 c                   3

       // Environment attributes
     d SQL_ATTR_OUTPUT_NTS...
     d                 c                   10001
     d SQL_ATTR_SYS_NAMING...
     d                 c                   10002
     d SQL_ATTR_DEFAULT_LIB...
     d                 c                   10003
     d SQL_ATTR_SERVER_MODE...
     d                 c                   10004
     d SQL_ATTR_JOB_SORT_SEQUENCE...
     d                 c                   10005
     d SQL_ATTR_ENVHNDL_COUNTER...
     d                 c                   10009
     d SQL_ATTR_ESCAPE_CHAR...
     d                 c                   10010

       // Environment/Connection attributes
     d SQL_ATTR_DATE_FMT...
     d                 c                   10020
     d SQL_ATTR_DATE_SEP...
     d                 c                   10021
     d SQL_ATTR_TIME_FMT...
     d                 c                   10022
     d SQL_ATTR_TIME_SEP...
     d                 c                   10023
     d SQL_ATTR_DECIMAL_SEP...
     d                 c                   10024

       // Environment/Connection values
     d SQL_FMT_ISO     c                   1
     d SQL_FMT_USA     c                   2
     d SQL_FMT_EUR     c                   3
     d SQL_FMT_JIS     c                   4
     d SQL_FMT_MDY     c                   5
     d SQL_FMT_DMY     c                   6
     d SQL_FMT_YMD     c                   7
     d SQL_FMT_JUL     c                   8
     d SQL_FMT_HMS     c                   9
     d SQL_FMT_JOB     c                   10
     d SQL_SEP_SLASH   c                   1
     d SQL_SEP_DASH    c                   2
     d SQL_SEP_PERIOD  c                   3
     d SQL_SEP_COMMA   c                   4
     d SQL_SEP_BLANK   c                   5
     d SQL_SEP_COLON   c                   6
     d SQL_SEP_JOB     c                   7

       // Connection attributes
     d SQL_ATTR_AUTOCOMMIT...
     d                 c                   10003
     d SQL_ATTR_COMMIT...
     d                 c                   0
     d SQL_ATTR_DBC_DEFAULT_LIB...
     d                 c                   10005
     d SQL_ATTR_DBC_SYS_NAMING...
     d                 c                   10004
     d SQL_ATTR_EXTENDED_COL_INFO...
     d                 c                   10019
     d SQL_SAVEPOINT_NAME...
     d                 c                   10028
     d SQL_2ND_LEVEL_TEXT...
     d                 c                   10027

       // Statement attributes
     d SQL_ATTR_APP_ROW_DESC...
     d                 c                   10010
     d SQL_ATTR_APP_PARAM_DESC...
     d                 c                   10011
     d SQL_ATTR_IMP_ROW_DESC...
     d                 c                   10012
     d SQL_ATTR_IMP_PARAM_DESC...
     d                 c                   10013
     d SQL_ATTR_FOR_FETCH_ONLY...
     d                 c                   10014
     d SQL_ATTR_CONCURRENCY...
     d                 c                   10014
     d SQL_ATTR_CURSOR_SCROLLABLE...
     d                 c                   10015
     d SQL_ATTR_ROWSET_SIZE...
     d                 c                   10016

       // Codes used in FetchScroll
     d SQL_FETCH_NEXT...
     d                 c                   1
     d SQL_FETCH_FIRST...
     d                 c                   2
     d SQL_FETCH_LAST...
     d                 c                   3
     d SQL_FETCH_PRIOR...
     d                 c                   4
     d SQL_FETCH_ABSOLUTE...
     d                 c                   5
     d SQL_FETCH_RELATIVE...
     d                 c                   6

       // SQL_ATTR_COMMIT values:
     d SQL_TXN_NO_COMMIT...
     d                 c                   1
     d SQL_TXN_READ_UNCOMMITTED...
     d                 c                   2
     d SQL_TXN_READ_COMMITTED...
     d                 c                   3
     d SQL_TXN_REPEATABLE_READ...
     d                 c                   4
     d SQL_TXN_SERIALIZABLE...
     d                 c                   5

       // SqlAllocEnv(): Allocate an environment for SQL and return
       //                an environment handle
       //
       //        phenv = (output) environment handle
       //
       // Returns SQL_SUCCESS or SQL_ERROR
     d SqlAllocEnv     pr                  extproc('SQLAllocEnv')
     d                                     like(SQLRETURN)
     d   phenv                             like(SQLHENV)

       // SqlAllocConnect(): Allocate a connection handle
       //
       //     henv = (input) environment to allocate in
       //    phdbc = (output) new connection handle
       //
       // Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
     d SqlAllocConnect...
     d                 pr                  extproc('SQLAllocConnect')
     d                                     like(SQLRETURN)
     d   henv                              like(SQLHENV) value
     d   phdbc                             like(SQLHDBC)

       // SqlAllocStmt(): Allocate a new SQL statement handle
       //
       //    hdbc = (input) handle to database connection
       //  phstmt = (output) new statement handle
       //
       // Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
     d SqlAllocStmt    pr                  extproc('SQLAllocStmt')
     d                                     like(SQLRETURN)
     d    hdbc                             like(SQLHDBC) value
     d    phstmt                           like(SQLHSTMT)

       // SqlBindCol(): Bind column to application variable
       //
       //      hstmt = (input) statement handle
       //       icol = (input) column number to bind
       //     fCType = (input) application data type for column
       //   rgbValue = (output) pointer to variable where data is placed
       // cbValueMax = (input) max size of variable (in bytes or DBCS chars))
       //   pcbValue = (output) number of bytes returned
       //
       // Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
     d SqlBindCol      pr                  extproc('SQLBindCol')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    icol                             like(SQLSMALLINT) value
     d    fCType                           like(SQLSMALLINT) value
     d    rgbValue                         like(SQLPOINTER) value
     d    cbValueMax                       like(SQLINTEGER) value
     d    pcbValue                     *   value

       // SqlBindParam(): Bind Parameter
       //
       //      hstmt = (input) statement handle
       //       ipar = (input) parameter marker number to bind
       //     fCType = (input) application data type for the parameter
       //   fSqlType = (input) SQL data type for the parameter
       // cbParamDef = (input) precision of corresponding param marker
       //    ibScale = (input) scale of parm marker (decimal places)
       //   rgbValue = (i/o)   pointer to variable for data
       //                        or SQL_NULL_DATA if no data.
       //   pcbValue = (input) length of data, or SQL_NTS, or zero
       //                        or *OMIT if no data
       //
       // Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
     d SqlBindParam    pr                  extproc('SQLBindParam')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    ipar                             like(SQLSMALLINT) value
     d    fCType                           like(SQLSMALLINT) value
     d    fSqlType                         like(SQLSMALLINT) value
     d    cbParamDef                       like(SQLINTEGER) value
     d    ibScale                          like(SQLSMALLINT) value
     d    rgbValue                         like(SQLPOINTER) value
     d    pcbValue                     *   value

       // SqlConnect(): Connect to a data source
       //
       //       hdbc = (input) connection handle
       //      szDSN = (input) Data source name to connect to
       //      cbDSN = (input) length of szDSN parameter
       //      szUID = (input) Autorization name (UserID)
       //      cbUID = (input) Length of szUID parameter
       //  szAuthStr = (input) Autorization name (UserID)
       //  cbAuthStr = (input) Length of szUID parameter
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlConnect      pr                  extproc('SQLConnect')
     d                                     like(SQLRETURN)
     d    hdbc                             like(SQLHDBC) value
     d    szDSN                        *   value options(*string)
     d    cbDSN                            like(SQLSMALLINT) value
     d    szUID                        *   value options(*string)
     d    cbUID                            like(SQLSMALLINT) value
     d    szAuthStr                    *   value options(*string)
     d    cbAuthStr                        like(SQLSMALLINT) value

       // SqlDisconnect(): Disconnect from a data source
       //
       //  hdbc = (input) database connection handle to disconnect
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlDisconnect   pr                  extproc('SQLDisconnect')
     d                                     like(SQLRETURN)
     d    hdbc                             like(SQLHDBC) value

       //  SqlExecDirect(): Execute an SQL Statement Directly
       //
       //     hstmt = (input) handle of SQL Statement
       //  szSqlStr = (input) SQL statement to execute
       //  cbSqlStr = (input) length of SQL statement
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
       //         SQL_NO_DATA_FOUND
     d SqlExecDirect...
     d                 pr                  extproc('SQLExecDirect')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    szSqlStr                     *   value options(*string)
     d    cbSqlStr                         like(SQLINTEGER) value

       // SqlExecute(): Execute a prepared statement
       //
       //     hstmt = (input) handle of prepared SQL Statement
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
       //         SQL_NO_DATA_FOUND
     d SqlExecute      pr                  extproc('SQLExecute')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value

       // SqlFetch(): Fetch next row from result set
       //
       //     hstmt = (input) statement handle
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
       //         SQL_NO_DATA_FOUND  (also indicates end of result set)
     d SqlFetch        pr                  extproc('SQLFetch')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value

       // SqlFetchScroll(): Fetch next row from result set with
       //                   scrollable cursor
       //
       //     hstmt = (input) statement handle
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
       //         SQL_NO_DATA_FOUND  (also indicates end of result set)
     d SqlFetchScroll  pr                  extproc('SQLFetchScroll')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    fOrient                          like(SQLSMALLINT) value
     d    fOffset                          like(SQLINTEGER) value

       // SqlFreeConnect(): Free SQL connection handle
       //
       //     hdbc = (input) handle of data source connection
       //                   that has already been disconnected
       //                   by SQLDisconnect()
       //
       // Returns SQL_SUCCESS,
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlFreeConnect  pr                  extproc('SQLFreeConnect')
     d                                     like(SQLRETURN)
     d    hdbc                             like(SQLHDBC) value

       // SqlFreeEnv(): Free Environment Handle
       //              (SqlFreeConnect needs to be called first)
       //
       //     henv = (input) environment handle to free up
       //
       // Returns SQL_SUCCESS,
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlFreeEnv      pr                  extproc('SQLFreeEnv')
     d                                     like(SQLRETURN)
     d    henv                             like(SQLHENV) value

       // SqlFreeStmt(): Free or Reset an SQL Statement Handle
       //
       //    hstmt = (input) statement handle to free or reset
       //  fOption = (input) option to perform, the values are:
       //              SQL_CLOSE  = Close a cursor
       //              SQL_DROP   = Drop a statement handle/free resources
       //              SQL_UNBIND = unbind columns from variables
       //              SQL_RESET_PARAMS = Reset parameters
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlFreeStmt     pr                  extproc('SQLFreeStmt')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    fOption                          like(SQLSMALLINT) value

       // SqlGetCol(): Gets a column from a fetched row
       //
       //     hstmt  = (input) statement handle of fetch
       //      icol  = (input) column number to get
       //    fCType  = (input) application (not database) data type
       //                      of column identified by icol
       //                      (SQL_CHAR, SQL_VARCHAR, etc...)
       //   rgbValue = (input) pointer to memory (variable) where the
       //                      retrieved column data will be stored
       // cbValueMax = (input) maximum size of data to return
       //                        for DECIMAL or NUMERIC, this is
       //                        (precision * 256) + scale.
       //                        For anything else, it's bytes.
       //   pcbValue = (output) size of data available in database
       //                        or, amount remaining if fetching in pieces
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
       //         SQL_NO_DATA_FOUND (also indicates end of result set)
     d SqlGetCol       pr                  extproc('SQLGetCol')
     d                                     like(SQLRETURN)
     d   hstmt                             like(SQLHSTMT) value
     d   icol                              like(SQLSMALLINT) value
     d   fCType                            like(SQLSMALLINT) value
     d   rgbValue                          like(SQLPOINTER) value
     d   cbValueMax                        like(SQLINTEGER) value
     d   pcbValue                          like(SQLINTEGER) options(*omit)

       // SQLPrepare(): Prepare an SQL statement to be executed
       //               one or more times.
       //
       //    hstmt = (input) statement handle to prepare into
       // szSqlStr = (input) SQL Statement to prepare
       // cbSqlStr = (input) length of SQL statement
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlPrepare      pr                  extproc('SQLPrepare')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    szSqlStr                     *   value options(*string)
     d    cbSqlStr                         like(SQLINTEGER) value

       // SqlSetEnvAttr(): Set environment attribute
       //
       //    henv = (input) environment handle to set attribute of
       //   fAttr = (input) attribute to set
       //  vParam = (input) pointer to attribute value
       //    sLen = (input) length of attribute value
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlSetEnvAttr   pr                  extproc('SQLSetEnvAttr')
     d                                     like(SQLRETURN)
     d    henv                             like(SQLHDBC) value
     d    fAttr                            like(SQLINTEGER) value
     d    vParam                           like(SQLINTEGER) const
     d    sLen                             like(SQLINTEGER) value

       // SqlSetConnectAttr(): Set connection attribute
       //
       //    hdbc = (input) connection handle to set attribute of
       //   fAttr = (input) attribute to set
       //  vParam = (input) pointer to attribute value
       //    sLen = (input) length of attribute value
       //
       // Returns SQL_SUCCESS,
       //         SQL_SUCCESS_WITH_INFO
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlSetConnectAttr...
     d                 pr                  extproc('SQLSetConnectAttr')
     d                                     like(SQLRETURN)
     d    hdbc                             like(SQLHDBC) value
     d    fAttr                            like(SQLINTEGER) value
     d    vParam                           like(SQLINTEGER) const
     d    sLen                             like(SQLINTEGER) value

       // SqlSetStmtAttr(): Set statement attribute
       //
       //   hstmt = (input) statement handle to set attribute of
       //   fAttr = (input) attribute to set
       //  vParam = (input) pointer to new attribute value
       //    sLen = (input) length of new attribute value
       //
       // Returns SQL_SUCCESS,
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlSetStmtAttr...
     d                 pr                  extproc('SQLSetStmtAttr')
     d                                     like(SQLRETURN)
     d    hstmt                            like(SQLHSTMT) value
     d    fAttr                            like(SQLINTEGER) value
     d    vParam                           like(SQLINTEGER) const
     d    sLen                             like(SQLINTEGER) value

       // SqlError(): Retrieve Error Information
       //
       //        henv = (input) environment handle
       //        hdbc = (input) database connection handle
       //                       (or SQL_NULL_HDBC)
       //       hstmt = (input) statement handle (or SQL_NULL_HSTMT)
       //  szSqlState = (output) SQL State (null-terminated)
       // pfNativeErr = (output) Native error code
       //  szErrorMsg = (output) Message text of error message
       // cbErrMsgMax = (input) max size of szErrorMsg parameter
       // pcbErrorMsg = (output) total bytes available for err msg.
       //
       // Returns SQL_SUCCESS,
       //         SQL_NO_DATA_FOUND
       //         SQL_ERROR
       //         SQL_INVALID_HANDLE
     d SqlError        pr                  extproc('SQLError')
     d                                     like(SQLRETURN)
     d   henv                              like(SQLHENV) value
     d   hdbc                              like(SQLHDBC) value
     d   hstmt                             like(SQLHSTMT) value
     d   szSqlState                   6    options(*omit)
     d   pfNativeErr                       like(SQLINTEGER)
     d                                     options(*omit)
     d   szErrorMsg                 513    options(*varsize: *omit)
     d   cbErrMsgMax                       like(SQLSMALLINT) value
     d   pcbErrorMsg                       like(SQLSMALLINT)
     d                                     options(*omit)


       // ----- Global Defs

       // Global Satuscode
     d GStatus         s              3  0 inz(0)

       // SQL CLI Error structure
     d CliErr          ds                  qualified inz
     d   SQLSTATE                     5
     d   SQLCODE                           like(SQLINTEGER)
     d   msg                        512

       // Environment structure.
     d E_              ds                  qualified inz
         // Is set to *on if the environment has been initialized and
         // allocated successfully.
     d   allocated                     n
         // Handle.
     d   h                                 like(SQLHENV)

       // Connection arrays (index 1 = the default connection).
       // Each array holds a specific attribute for connection n.
       // C_allocated: is set to *on if the connection has been initialized
       // and allocated successfully.
     d C_allocated     s               n   inz dim(CSqlsMaxConn)
       // C_h: handle.
     d C_h             s                   like(SQLHDBC)
     d                                     inz dim(CSqlsMaxConn)
       // C_connrtn: returnvalue of last "SqlSetConnectAttr" or "SqlConnect"
       // operation.
     d C_connrtn       s                   like(SQLRETURN)
     d                                     inz(SQL_INVALID_HANDLE)
     d                                     dim(CSqlsMaxConn)

       // Statement arrays.
       // Each array holds a specific attribute for statement n.
       // S_allocated: is set to *on if the statement has been initialized
       // and allocated successfully.
     d S_allocated     s               n   inz dim(CSqlsMaxCurs)
       // S_h: handle.
     d S_h             s                   like(SQLHSTMT)
     d                                     inz dim(CSqlsMaxCurs)
       // S_conn: index into arrays C_* to the connection in which this
       // statement has been allocated.
     d S_conn          s             10i 0 inz dim(CSqlsMaxCurs)
       // S_colstat: a status indicator for each result set column.
       // If position n has value:
       //   'B': column n is bound, but not fetched yet.
       //   'V': column n is bound and fetched; no special indication.
       //   'X': column n is bound and fetched; value is NULL.
       //   'S': column n is bound and fetched; value is a NTS.
     d S_colstat       s            999    inz dim(CSqlsMaxCurs)

       // Field with 999 deferred output parameter subfields for
       // SqlFetch (pcbValue), for max. 999 columns.
     d PcbField        s           3996


       // ----- Local Prototypes

       // Return *on if connection "conn" has been allocated and is
       // connected, else return *off.
     dL_ConnIsActive   pr              n
     d  conn                          5i 0 const

       // Check if connection "conn" has been allocated and is connected.
       // If not, try to allocate and connect the connection, and try to
       // allocate a new statement if optional parameter "allocstmt" is
       // given and is *on.
       // Return -1 in case of an error, else return 0 if no new statement
       // was allocated or the new statement's (cursor) id.
     dL_CheckConn      pr             5i 0
     d  conn                          5i 0 const
     d  allocstmt                      n   const options(*nopass)

       // Close connection "conn" and all it's allocated statements.
       // Free all resources associated with the connection and it's
       // statements. Return *on if successful, else return *off.
       // Return *on if "conn" is already closed.
     dL_CloseConn      pr              n
     d  conn                          5i 0 const

       // Free all resources for statement "st". Return *on if
       // successful, else return *off.
       // Return *on if "st" is already freed.
     dL_FreeStmt       pr              n
     d  st                            5i 0 const

       // Check if the environment has been allocated. If not, try to
       // allocate the environment. Return *on if the environment has
       // been allocated successfully, else return *off.
     dL_CheckEnv       pr              n

       // Fill data structure "CliErr" with CLI error information.
       // Return *on if successful. If not successful, do not change
       // "CliErr" and return *off.
     dL_CliErr         pr              n
     d  henv                               like(SQLHENV) const
     d  hdbc                               like(SQLHDBC) const
     d  hstmt                              like(SQLHSTMT) const


       // ----- Implementation


     p SqlsStatus      b                   export
     d SqlsStatus      pi             3  0

      /free

       return GStatus;

      /end-free
     p                 e


     p SqlsDBExec      b                   export
     d SqlsDBExec      pi             5i 0
     d   conn                         5i 0 const options(*omit)
     d   stmt                          *   const options(*string)
     d   p01data                       *   const options(*nopass)
     d   p01stype                     5i 0 const options(*nopass:*omit)
     d   p01atype                     5i 0 const options(*nopass:*omit)
     d   p01len                      10i 0 const options(*nopass:*omit)
     d   p01scale                     5i 0 const options(*nopass:*omit)
     d   p02data                       *   const options(*nopass)
     d   p02stype                     5i 0 const options(*nopass:*omit)
     d   p02atype                     5i 0 const options(*nopass:*omit)
     d   p02len                      10i 0 const options(*nopass:*omit)
     d   p02scale                     5i 0 const options(*nopass:*omit)
     d   p03data                       *   const options(*nopass)
     d   p03stype                     5i 0 const options(*nopass:*omit)
     d   p03atype                     5i 0 const options(*nopass:*omit)
     d   p03len                      10i 0 const options(*nopass:*omit)
     d   p03scale                     5i 0 const options(*nopass:*omit)
     d   p04data                       *   const options(*nopass)
     d   p04stype                     5i 0 const options(*nopass:*omit)
     d   p04atype                     5i 0 const options(*nopass:*omit)
     d   p04len                      10i 0 const options(*nopass:*omit)
     d   p04scale                     5i 0 const options(*nopass:*omit)
     d   p05data                       *   const options(*nopass)
     d   p05stype                     5i 0 const options(*nopass:*omit)
     d   p05atype                     5i 0 const options(*nopass:*omit)
     d   p05len                      10i 0 const options(*nopass:*omit)
     d   p05scale                     5i 0 const options(*nopass:*omit)
     d   p06data                       *   const options(*nopass)
     d   p06stype                     5i 0 const options(*nopass:*omit)
     d   p06atype                     5i 0 const options(*nopass:*omit)
     d   p06len                      10i 0 const options(*nopass:*omit)
     d   p06scale                     5i 0 const options(*nopass:*omit)
     d   p07data                       *   const options(*nopass)
     d   p07stype                     5i 0 const options(*nopass:*omit)
     d   p07atype                     5i 0 const options(*nopass:*omit)
     d   p07len                      10i 0 const options(*nopass:*omit)
     d   p07scale                     5i 0 const options(*nopass:*omit)
     d   p08data                       *   const options(*nopass)
     d   p08stype                     5i 0 const options(*nopass:*omit)
     d   p08atype                     5i 0 const options(*nopass:*omit)
     d   p08len                      10i 0 const options(*nopass:*omit)
     d   p08scale                     5i 0 const options(*nopass:*omit)
     d   p09data                       *   const options(*nopass)
     d   p09stype                     5i 0 const options(*nopass:*omit)
     d   p09atype                     5i 0 const options(*nopass:*omit)
     d   p09len                      10i 0 const options(*nopass:*omit)
     d   p09scale                     5i 0 const options(*nopass:*omit)
     d   p10data                       *   const options(*nopass)
     d   p10stype                     5i 0 const options(*nopass:*omit)
     d   p10atype                     5i 0 const options(*nopass:*omit)
     d   p10len                      10i 0 const options(*nopass:*omit)
     d   p10scale                     5i 0 const options(*nopass:*omit)
     d   p11data                       *   const options(*nopass)
     d   p11stype                     5i 0 const options(*nopass:*omit)
     d   p11atype                     5i 0 const options(*nopass:*omit)
     d   p11len                      10i 0 const options(*nopass:*omit)
     d   p11scale                     5i 0 const options(*nopass:*omit)
     d   p12data                       *   const options(*nopass)
     d   p12stype                     5i 0 const options(*nopass:*omit)
     d   p12atype                     5i 0 const options(*nopass:*omit)
     d   p12len                      10i 0 const options(*nopass:*omit)
     d   p12scale                     5i 0 const options(*nopass:*omit)
     d   p13data                       *   const options(*nopass)
     d   p13stype                     5i 0 const options(*nopass:*omit)
     d   p13atype                     5i 0 const options(*nopass:*omit)
     d   p13len                      10i 0 const options(*nopass:*omit)
     d   p13scale                     5i 0 const options(*nopass:*omit)
     d   p14data                       *   const options(*nopass)
     d   p14stype                     5i 0 const options(*nopass:*omit)
     d   p14atype                     5i 0 const options(*nopass:*omit)
     d   p14len                      10i 0 const options(*nopass:*omit)
     d   p14scale                     5i 0 const options(*nopass:*omit)
     d   p15data                       *   const options(*nopass)
     d   p15stype                     5i 0 const options(*nopass:*omit)
     d   p15atype                     5i 0 const options(*nopass:*omit)
     d   p15len                      10i 0 const options(*nopass:*omit)
     d   p15scale                     5i 0 const options(*nopass:*omit)
     d   p16data                       *   const options(*nopass)
     d   p16stype                     5i 0 const options(*nopass:*omit)
     d   p16atype                     5i 0 const options(*nopass:*omit)
     d   p16len                      10i 0 const options(*nopass:*omit)
     d   p16scale                     5i 0 const options(*nopass:*omit)
     d   p17data                       *   const options(*nopass)
     d   p17stype                     5i 0 const options(*nopass:*omit)
     d   p17atype                     5i 0 const options(*nopass:*omit)
     d   p17len                      10i 0 const options(*nopass:*omit)
     d   p17scale                     5i 0 const options(*nopass:*omit)
     d   p18data                       *   const options(*nopass)
     d   p18stype                     5i 0 const options(*nopass:*omit)
     d   p18atype                     5i 0 const options(*nopass:*omit)
     d   p18len                      10i 0 const options(*nopass:*omit)
     d   p18scale                     5i 0 const options(*nopass:*omit)
     d   p19data                       *   const options(*nopass)
     d   p19stype                     5i 0 const options(*nopass:*omit)
     d   p19atype                     5i 0 const options(*nopass:*omit)
     d   p19len                      10i 0 const options(*nopass:*omit)
     d   p19scale                     5i 0 const options(*nopass:*omit)
     d   p20data                       *   const options(*nopass)
     d   p20stype                     5i 0 const options(*nopass:*omit)
     d   p20atype                     5i 0 const options(*nopass:*omit)
     d   p20len                      10i 0 const options(*nopass:*omit)
     d   p20scale                     5i 0 const options(*nopass:*omit)
     d   p21data                       *   const options(*nopass)
     d   p21stype                     5i 0 const options(*nopass:*omit)
     d   p21atype                     5i 0 const options(*nopass:*omit)
     d   p21len                      10i 0 const options(*nopass:*omit)
     d   p21scale                     5i 0 const options(*nopass:*omit)
     d   p22data                       *   const options(*nopass)
     d   p22stype                     5i 0 const options(*nopass:*omit)
     d   p22atype                     5i 0 const options(*nopass:*omit)
     d   p22len                      10i 0 const options(*nopass:*omit)
     d   p22scale                     5i 0 const options(*nopass:*omit)
     d   p23data                       *   const options(*nopass)
     d   p23stype                     5i 0 const options(*nopass:*omit)
     d   p23atype                     5i 0 const options(*nopass:*omit)
     d   p23len                      10i 0 const options(*nopass:*omit)
     d   p23scale                     5i 0 const options(*nopass:*omit)
     d   p24data                       *   const options(*nopass)
     d   p24stype                     5i 0 const options(*nopass:*omit)
     d   p24atype                     5i 0 const options(*nopass:*omit)
     d   p24len                      10i 0 const options(*nopass:*omit)
     d   p24scale                     5i 0 const options(*nopass:*omit)
     d   p25data                       *   const options(*nopass)
     d   p25stype                     5i 0 const options(*nopass:*omit)
     d   p25atype                     5i 0 const options(*nopass:*omit)
     d   p25len                      10i 0 const options(*nopass:*omit)
     d   p25scale                     5i 0 const options(*nopass:*omit)
     d   p26data                       *   const options(*nopass)
     d   p26stype                     5i 0 const options(*nopass:*omit)
     d   p26atype                     5i 0 const options(*nopass:*omit)
     d   p26len                      10i 0 const options(*nopass:*omit)
     d   p26scale                     5i 0 const options(*nopass:*omit)
     d   p27data                       *   const options(*nopass)
     d   p27stype                     5i 0 const options(*nopass:*omit)
     d   p27atype                     5i 0 const options(*nopass:*omit)
     d   p27len                      10i 0 const options(*nopass:*omit)
     d   p27scale                     5i 0 const options(*nopass:*omit)
     d   p28data                       *   const options(*nopass)
     d   p28stype                     5i 0 const options(*nopass:*omit)
     d   p28atype                     5i 0 const options(*nopass:*omit)
     d   p28len                      10i 0 const options(*nopass:*omit)
     d   p28scale                     5i 0 const options(*nopass:*omit)
     d   p29data                       *   const options(*nopass)
     d   p29stype                     5i 0 const options(*nopass:*omit)
     d   p29atype                     5i 0 const options(*nopass:*omit)
     d   p29len                      10i 0 const options(*nopass:*omit)
     d   p29scale                     5i 0 const options(*nopass:*omit)
     d   p30data                       *   const options(*nopass)
     d   p30stype                     5i 0 const options(*nopass:*omit)
     d   p30atype                     5i 0 const options(*nopass:*omit)
     d   p30len                      10i 0 const options(*nopass:*omit)
     d   p30scale                     5i 0 const options(*nopass:*omit)
     d   p31data                       *   const options(*nopass)
     d   p31stype                     5i 0 const options(*nopass:*omit)
     d   p31atype                     5i 0 const options(*nopass:*omit)
     d   p31len                      10i 0 const options(*nopass:*omit)
     d   p31scale                     5i 0 const options(*nopass:*omit)
     d   p32data                       *   const options(*nopass)
     d   p32stype                     5i 0 const options(*nopass:*omit)
     d   p32atype                     5i 0 const options(*nopass:*omit)
     d   p32len                      10i 0 const options(*nopass:*omit)
     d   p32scale                     5i 0 const options(*nopass:*omit)
     d   p33data                       *   const options(*nopass)
     d   p33stype                     5i 0 const options(*nopass:*omit)
     d   p33atype                     5i 0 const options(*nopass:*omit)
     d   p33len                      10i 0 const options(*nopass:*omit)
     d   p33scale                     5i 0 const options(*nopass:*omit)
     d   p34data                       *   const options(*nopass)
     d   p34stype                     5i 0 const options(*nopass:*omit)
     d   p34atype                     5i 0 const options(*nopass:*omit)
     d   p34len                      10i 0 const options(*nopass:*omit)
     d   p34scale                     5i 0 const options(*nopass:*omit)
     d   p35data                       *   const options(*nopass)
     d   p35stype                     5i 0 const options(*nopass:*omit)
     d   p35atype                     5i 0 const options(*nopass:*omit)
     d   p35len                      10i 0 const options(*nopass:*omit)
     d   p35scale                     5i 0 const options(*nopass:*omit)
     d   p36data                       *   const options(*nopass)
     d   p36stype                     5i 0 const options(*nopass:*omit)
     d   p36atype                     5i 0 const options(*nopass:*omit)
     d   p36len                      10i 0 const options(*nopass:*omit)
     d   p36scale                     5i 0 const options(*nopass:*omit)
     d   p37data                       *   const options(*nopass)
     d   p37stype                     5i 0 const options(*nopass:*omit)
     d   p37atype                     5i 0 const options(*nopass:*omit)
     d   p37len                      10i 0 const options(*nopass:*omit)
     d   p37scale                     5i 0 const options(*nopass:*omit)
     d   p38data                       *   const options(*nopass)
     d   p38stype                     5i 0 const options(*nopass:*omit)
     d   p38atype                     5i 0 const options(*nopass:*omit)
     d   p38len                      10i 0 const options(*nopass:*omit)
     d   p38scale                     5i 0 const options(*nopass:*omit)
     d   p39data                       *   const options(*nopass)
     d   p39stype                     5i 0 const options(*nopass:*omit)
     d   p39atype                     5i 0 const options(*nopass:*omit)
     d   p39len                      10i 0 const options(*nopass:*omit)
     d   p39scale                     5i 0 const options(*nopass:*omit)
     d   p40data                       *   const options(*nopass)
     d   p40stype                     5i 0 const options(*nopass:*omit)
     d   p40atype                     5i 0 const options(*nopass:*omit)
     d   p40len                      10i 0 const options(*nopass:*omit)
     d   p40scale                     5i 0 const options(*nopass:*omit)
     d   p41data                       *   const options(*nopass)
     d   p41stype                     5i 0 const options(*nopass:*omit)
     d   p41atype                     5i 0 const options(*nopass:*omit)
     d   p41len                      10i 0 const options(*nopass:*omit)
     d   p41scale                     5i 0 const options(*nopass:*omit)
     d   p42data                       *   const options(*nopass)
     d   p42stype                     5i 0 const options(*nopass:*omit)
     d   p42atype                     5i 0 const options(*nopass:*omit)
     d   p42len                      10i 0 const options(*nopass:*omit)
     d   p42scale                     5i 0 const options(*nopass:*omit)
     d   p43data                       *   const options(*nopass)
     d   p43stype                     5i 0 const options(*nopass:*omit)
     d   p43atype                     5i 0 const options(*nopass:*omit)
     d   p43len                      10i 0 const options(*nopass:*omit)
     d   p43scale                     5i 0 const options(*nopass:*omit)
     d   p44data                       *   const options(*nopass)
     d   p44stype                     5i 0 const options(*nopass:*omit)
     d   p44atype                     5i 0 const options(*nopass:*omit)
     d   p44len                      10i 0 const options(*nopass:*omit)
     d   p44scale                     5i 0 const options(*nopass:*omit)
     d   p45data                       *   const options(*nopass)
     d   p45stype                     5i 0 const options(*nopass:*omit)
     d   p45atype                     5i 0 const options(*nopass:*omit)
     d   p45len                      10i 0 const options(*nopass:*omit)
     d   p45scale                     5i 0 const options(*nopass:*omit)
     d   p46data                       *   const options(*nopass)
     d   p46stype                     5i 0 const options(*nopass:*omit)
     d   p46atype                     5i 0 const options(*nopass:*omit)
     d   p46len                      10i 0 const options(*nopass:*omit)
     d   p46scale                     5i 0 const options(*nopass:*omit)
     d   p47data                       *   const options(*nopass)
     d   p47stype                     5i 0 const options(*nopass:*omit)
     d   p47atype                     5i 0 const options(*nopass:*omit)
     d   p47len                      10i 0 const options(*nopass:*omit)
     d   p47scale                     5i 0 const options(*nopass:*omit)
     d   p48data                       *   const options(*nopass)
     d   p48stype                     5i 0 const options(*nopass:*omit)
     d   p48atype                     5i 0 const options(*nopass:*omit)
     d   p48len                      10i 0 const options(*nopass:*omit)
     d   p48scale                     5i 0 const options(*nopass:*omit)
     d   p49data                       *   const options(*nopass)
     d   p49stype                     5i 0 const options(*nopass:*omit)
     d   p49atype                     5i 0 const options(*nopass:*omit)
     d   p49len                      10i 0 const options(*nopass:*omit)
     d   p49scale                     5i 0 const options(*nopass:*omit)
     d   p50data                       *   const options(*nopass)
     d   p50stype                     5i 0 const options(*nopass:*omit)
     d   p50atype                     5i 0 const options(*nopass:*omit)
     d   p50len                      10i 0 const options(*nopass:*omit)
     d   p50scale                     5i 0 const options(*nopass:*omit)
     d   p51data                       *   const options(*nopass)
     d   p51stype                     5i 0 const options(*nopass:*omit)
     d   p51atype                     5i 0 const options(*nopass:*omit)
     d   p51len                      10i 0 const options(*nopass:*omit)
     d   p51scale                     5i 0 const options(*nopass:*omit)
     d   p52data                       *   const options(*nopass)
     d   p52stype                     5i 0 const options(*nopass:*omit)
     d   p52atype                     5i 0 const options(*nopass:*omit)
     d   p52len                      10i 0 const options(*nopass:*omit)
     d   p52scale                     5i 0 const options(*nopass:*omit)
     d   p53data                       *   const options(*nopass)
     d   p53stype                     5i 0 const options(*nopass:*omit)
     d   p53atype                     5i 0 const options(*nopass:*omit)
     d   p53len                      10i 0 const options(*nopass:*omit)
     d   p53scale                     5i 0 const options(*nopass:*omit)
     d   p54data                       *   const options(*nopass)
     d   p54stype                     5i 0 const options(*nopass:*omit)
     d   p54atype                     5i 0 const options(*nopass:*omit)
     d   p54len                      10i 0 const options(*nopass:*omit)
     d   p54scale                     5i 0 const options(*nopass:*omit)
     d   p55data                       *   const options(*nopass)
     d   p55stype                     5i 0 const options(*nopass:*omit)
     d   p55atype                     5i 0 const options(*nopass:*omit)
     d   p55len                      10i 0 const options(*nopass:*omit)
     d   p55scale                     5i 0 const options(*nopass:*omit)
     d   p56data                       *   const options(*nopass)
     d   p56stype                     5i 0 const options(*nopass:*omit)
     d   p56atype                     5i 0 const options(*nopass:*omit)
     d   p56len                      10i 0 const options(*nopass:*omit)
     d   p56scale                     5i 0 const options(*nopass:*omit)
     d   p57data                       *   const options(*nopass)
     d   p57stype                     5i 0 const options(*nopass:*omit)
     d   p57atype                     5i 0 const options(*nopass:*omit)
     d   p57len                      10i 0 const options(*nopass:*omit)
     d   p57scale                     5i 0 const options(*nopass:*omit)
     d   p58data                       *   const options(*nopass)
     d   p58stype                     5i 0 const options(*nopass:*omit)
     d   p58atype                     5i 0 const options(*nopass:*omit)
     d   p58len                      10i 0 const options(*nopass:*omit)
     d   p58scale                     5i 0 const options(*nopass:*omit)
     d   p59data                       *   const options(*nopass)
     d   p59stype                     5i 0 const options(*nopass:*omit)
     d   p59atype                     5i 0 const options(*nopass:*omit)
     d   p59len                      10i 0 const options(*nopass:*omit)
     d   p59scale                     5i 0 const options(*nopass:*omit)
     d   p60data                       *   const options(*nopass)
     d   p60stype                     5i 0 const options(*nopass:*omit)
     d   p60atype                     5i 0 const options(*nopass:*omit)
     d   p60len                      10i 0 const options(*nopass:*omit)
     d   p60scale                     5i 0 const options(*nopass:*omit)
     d   p61data                       *   const options(*nopass)
     d   p61stype                     5i 0 const options(*nopass:*omit)
     d   p61atype                     5i 0 const options(*nopass:*omit)
     d   p61len                      10i 0 const options(*nopass:*omit)
     d   p61scale                     5i 0 const options(*nopass:*omit)
     d   p62data                       *   const options(*nopass)
     d   p62stype                     5i 0 const options(*nopass:*omit)
     d   p62atype                     5i 0 const options(*nopass:*omit)
     d   p62len                      10i 0 const options(*nopass:*omit)
     d   p62scale                     5i 0 const options(*nopass:*omit)

     d cn              s              5i 0
     d st              s              5i 0
     d pdata           s                   like(p01data)
     d pstype          s                   like(p01stype)
     d patype          s                   like(p01atype)
     d plen            s                   like(p01len)
     d pscale          s                   like(p01scale)
     d pmarker         s              5i 0
     d rtn             s                   like(SQLRETURN)
     d pcbf            s            500
     d pcbv            s             10i 0 based(pcbv@)
     d pgmstatus       s              5  0

      /free

       GStatus = 0;

       if %addr(conn) = *null;
         cn = 1;
       else;
         cn = conn;
       endif;

       if    cn < 1
          or cn > CSqlsMaxConn;
         GStatus = -999;
         return -1;
       endif;

       st = L_CheckConn(cn:*on);
       if st < 1;
         return -1;
       endif;

       if %parms > 2;
         // Bind parameter marker 1.
         exsr initpmparms;
         pdata = p01data;
         if     %parms > 3
            and %addr(p01stype) <> *null;
           pstype = p01stype;
         endif;
         if     %parms > 4
            and %addr(p01atype) <> *null;
           patype = p01atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 5
            and %addr(p01len) <> *null;
           plen = p01len;
         endif;
         if     %parms > 6
            and %addr(p01scale) <> *null;
           pscale = p01scale;
         endif;
         pmarker = 1;
         exsr bindpmarker;
       endif;

       if %parms > 7;
         // Bind parameter marker 2.
         exsr initpmparms;
         pdata = p02data;
         if     %parms > 8
            and %addr(p02stype) <> *null;
           pstype = p02stype;
         endif;
         if     %parms > 9
            and %addr(p02atype) <> *null;
           patype = p02atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 10
            and %addr(p02len) <> *null;
           plen = p02len;
         endif;
         if     %parms > 11
            and %addr(p02scale) <> *null;
           pscale = p02scale;
         endif;
         pmarker = 2;
         exsr bindpmarker;
       endif;

       if %parms > 12;
         // Bind parameter marker 3.
         exsr initpmparms;
         pdata = p03data;
         if     %parms > 13
            and %addr(p03stype) <> *null;
           pstype = p03stype;
         endif;
         if     %parms > 14
            and %addr(p03atype) <> *null;
           patype = p03atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 15
            and %addr(p03len) <> *null;
           plen = p03len;
         endif;
         if     %parms > 16
            and %addr(p03scale) <> *null;
           pscale = p03scale;
         endif;
         pmarker = 3;
         exsr bindpmarker;
       endif;

       if %parms > 17;
         // Bind parameter marker 4.
         exsr initpmparms;
         pdata = p04data;
         if     %parms > 18
            and %addr(p04stype) <> *null;
           pstype = p04stype;
         endif;
         if     %parms > 19
            and %addr(p04atype) <> *null;
           patype = p04atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 20
            and %addr(p04len) <> *null;
           plen = p04len;
         endif;
         if     %parms > 21
            and %addr(p04scale) <> *null;
           pscale = p04scale;
         endif;
         pmarker = 4;
         exsr bindpmarker;
       endif;

       if %parms > 22;
         // Bind parameter marker 5.
         exsr initpmparms;
         pdata = p05data;
         if     %parms > 23
            and %addr(p05stype) <> *null;
           pstype = p05stype;
         endif;
         if     %parms > 24
            and %addr(p05atype) <> *null;
           patype = p05atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 25
            and %addr(p05len) <> *null;
           plen = p05len;
         endif;
         if     %parms > 26
            and %addr(p05scale) <> *null;
           pscale = p05scale;
         endif;
         pmarker = 5;
         exsr bindpmarker;
       endif;

       if %parms > 27;
         // Bind parameter marker 6.
         exsr initpmparms;
         pdata = p06data;
         if     %parms > 28
            and %addr(p06stype) <> *null;
           pstype = p06stype;
         endif;
         if     %parms > 29
            and %addr(p06atype) <> *null;
           patype = p06atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 30
            and %addr(p06len) <> *null;
           plen = p06len;
         endif;
         if     %parms > 31
            and %addr(p06scale) <> *null;
           pscale = p06scale;
         endif;
         pmarker = 6;
         exsr bindpmarker;
       endif;

       if %parms > 32;
         // Bind parameter marker 7.
         exsr initpmparms;
         pdata = p07data;
         if     %parms > 33
            and %addr(p07stype) <> *null;
           pstype = p07stype;
         endif;
         if     %parms > 34
            and %addr(p07atype) <> *null;
           patype = p07atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 35
            and %addr(p07len) <> *null;
           plen = p07len;
         endif;
         if     %parms > 36
            and %addr(p07scale) <> *null;
           pscale = p07scale;
         endif;
         pmarker = 7;
         exsr bindpmarker;
       endif;

       if %parms > 37;
         // Bind parameter marker 8.
         exsr initpmparms;
         pdata = p08data;
         if     %parms > 38
            and %addr(p08stype) <> *null;
           pstype = p08stype;
         endif;
         if     %parms > 39
            and %addr(p08atype) <> *null;
           patype = p08atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 40
            and %addr(p08len) <> *null;
           plen = p08len;
         endif;
         if     %parms > 41
            and %addr(p08scale) <> *null;
           pscale = p08scale;
         endif;
         pmarker = 8;
         exsr bindpmarker;
       endif;

       if %parms > 42;
         // Bind parameter marker 9.
         exsr initpmparms;
         pdata = p09data;
         if     %parms > 43
            and %addr(p09stype) <> *null;
           pstype = p09stype;
         endif;
         if     %parms > 44
            and %addr(p09atype) <> *null;
           patype = p09atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 45
            and %addr(p09len) <> *null;
           plen = p09len;
         endif;
         if     %parms > 46
            and %addr(p09scale) <> *null;
           pscale = p09scale;
         endif;
         pmarker = 9;
         exsr bindpmarker;
       endif;

       if %parms > 47;
         // Bind parameter marker 10.
         exsr initpmparms;
         pdata = p10data;
         if     %parms > 48
            and %addr(p10stype) <> *null;
           pstype = p10stype;
         endif;
         if     %parms > 49
            and %addr(p10atype) <> *null;
           patype = p10atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 50
            and %addr(p10len) <> *null;
           plen = p10len;
         endif;
         if     %parms > 51
            and %addr(p10scale) <> *null;
           pscale = p10scale;
         endif;
         pmarker = 10;
         exsr bindpmarker;
       endif;

       if %parms > 52;
         // Bind parameter marker 11.
         exsr initpmparms;
         pdata = p11data;
         if     %parms > 53
            and %addr(p11stype) <> *null;
           pstype = p11stype;
         endif;
         if     %parms > 54
            and %addr(p11atype) <> *null;
           patype = p11atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 55
            and %addr(p11len) <> *null;
           plen = p11len;
         endif;
         if     %parms > 56
            and %addr(p11scale) <> *null;
           pscale = p11scale;
         endif;
         pmarker = 11;
         exsr bindpmarker;
       endif;

       if %parms > 57;
         // Bind parameter marker 12.
         exsr initpmparms;
         pdata = p12data;
         if     %parms > 58
            and %addr(p12stype) <> *null;
           pstype = p12stype;
         endif;
         if     %parms > 59
            and %addr(p12atype) <> *null;
           patype = p12atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 60
            and %addr(p12len) <> *null;
           plen = p12len;
         endif;
         if     %parms > 61
            and %addr(p12scale) <> *null;
           pscale = p12scale;
         endif;
         pmarker = 12;
         exsr bindpmarker;
       endif;

       if %parms > 62;
         // Bind parameter marker 13.
         exsr initpmparms;
         pdata = p13data;
         if     %parms > 63
            and %addr(p13stype) <> *null;
           pstype = p13stype;
         endif;
         if     %parms > 64
            and %addr(p13atype) <> *null;
           patype = p13atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 65
            and %addr(p13len) <> *null;
           plen = p13len;
         endif;
         if     %parms > 66
            and %addr(p13scale) <> *null;
           pscale = p13scale;
         endif;
         pmarker = 13;
         exsr bindpmarker;
       endif;

       if %parms > 67;
         // Bind parameter marker 14.
         exsr initpmparms;
         pdata = p14data;
         if     %parms > 68
            and %addr(p14stype) <> *null;
           pstype = p14stype;
         endif;
         if     %parms > 69
            and %addr(p14atype) <> *null;
           patype = p14atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 70
            and %addr(p14len) <> *null;
           plen = p14len;
         endif;
         if     %parms > 71
            and %addr(p14scale) <> *null;
           pscale = p14scale;
         endif;
         pmarker = 14;
         exsr bindpmarker;
       endif;

       if %parms > 72;
         // Bind parameter marker 15.
         exsr initpmparms;
         pdata = p15data;
         if     %parms > 73
            and %addr(p15stype) <> *null;
           pstype = p15stype;
         endif;
         if     %parms > 74
            and %addr(p15atype) <> *null;
           patype = p15atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 75
            and %addr(p15len) <> *null;
           plen = p15len;
         endif;
         if     %parms > 76
            and %addr(p15scale) <> *null;
           pscale = p15scale;
         endif;
         pmarker = 15;
         exsr bindpmarker;
       endif;

       if %parms > 77;
         // Bind parameter marker 16.
         exsr initpmparms;
         pdata = p16data;
         if     %parms > 78
            and %addr(p16stype) <> *null;
           pstype = p16stype;
         endif;
         if     %parms > 79
            and %addr(p16atype) <> *null;
           patype = p16atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 80
            and %addr(p16len) <> *null;
           plen = p16len;
         endif;
         if     %parms > 81
            and %addr(p16scale) <> *null;
           pscale = p16scale;
         endif;
         pmarker = 16;
         exsr bindpmarker;
       endif;

       if %parms > 82;
         // Bind parameter marker 17.
         exsr initpmparms;
         pdata = p17data;
         if     %parms > 83
            and %addr(p17stype) <> *null;
           pstype = p17stype;
         endif;
         if     %parms > 84
            and %addr(p17atype) <> *null;
           patype = p17atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 85
            and %addr(p17len) <> *null;
           plen = p17len;
         endif;
         if     %parms > 86
            and %addr(p17scale) <> *null;
           pscale = p17scale;
         endif;
         pmarker = 17;
         exsr bindpmarker;
       endif;

       if %parms > 87;
         // Bind parameter marker 18.
         exsr initpmparms;
         pdata = p18data;
         if     %parms > 88
            and %addr(p18stype) <> *null;
           pstype = p18stype;
         endif;
         if     %parms > 89
            and %addr(p18atype) <> *null;
           patype = p18atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 90
            and %addr(p18len) <> *null;
           plen = p18len;
         endif;
         if     %parms > 91
            and %addr(p18scale) <> *null;
           pscale = p18scale;
         endif;
         pmarker = 18;
         exsr bindpmarker;
       endif;

       if %parms > 92;
         // Bind parameter marker 19.
         exsr initpmparms;
         pdata = p19data;
         if     %parms > 93
            and %addr(p19stype) <> *null;
           pstype = p19stype;
         endif;
         if     %parms > 94
            and %addr(p19atype) <> *null;
           patype = p19atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 95
            and %addr(p19len) <> *null;
           plen = p19len;
         endif;
         if     %parms > 96
            and %addr(p19scale) <> *null;
           pscale = p19scale;
         endif;
         pmarker = 19;
         exsr bindpmarker;
       endif;

       if %parms > 97;
         // Bind parameter marker 20.
         exsr initpmparms;
         pdata = p20data;
         if     %parms > 98
            and %addr(p20stype) <> *null;
           pstype = p20stype;
         endif;
         if     %parms > 99
            and %addr(p20atype) <> *null;
           patype = p20atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 100
            and %addr(p20len) <> *null;
           plen = p20len;
         endif;
         if     %parms > 101
            and %addr(p20scale) <> *null;
           pscale = p20scale;
         endif;
         pmarker = 20;
         exsr bindpmarker;
       endif;

       if %parms > 102;
         // Bind parameter marker 21.
         exsr initpmparms;
         pdata = p21data;
         if     %parms > 103
            and %addr(p21stype) <> *null;
           pstype = p21stype;
         endif;
         if     %parms > 104
            and %addr(p21atype) <> *null;
           patype = p21atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 105
            and %addr(p21len) <> *null;
           plen = p21len;
         endif;
         if     %parms > 106
            and %addr(p21scale) <> *null;
           pscale = p21scale;
         endif;
         pmarker = 21;
         exsr bindpmarker;
       endif;

       if %parms > 107;
         // Bind parameter marker 22.
         exsr initpmparms;
         pdata = p22data;
         if     %parms > 108
            and %addr(p22stype) <> *null;
           pstype = p22stype;
         endif;
         if     %parms > 109
            and %addr(p22atype) <> *null;
           patype = p22atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 110
            and %addr(p22len) <> *null;
           plen = p22len;
         endif;
         if     %parms > 111
            and %addr(p22scale) <> *null;
           pscale = p22scale;
         endif;
         pmarker = 22;
         exsr bindpmarker;
       endif;

       if %parms > 112;
         // Bind parameter marker 23.
         exsr initpmparms;
         pdata = p23data;
         if     %parms > 113
            and %addr(p23stype) <> *null;
           pstype = p23stype;
         endif;
         if     %parms > 114
            and %addr(p23atype) <> *null;
           patype = p23atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 115
            and %addr(p23len) <> *null;
           plen = p23len;
         endif;
         if     %parms > 116
            and %addr(p23scale) <> *null;
           pscale = p23scale;
         endif;
         pmarker = 23;
         exsr bindpmarker;
       endif;

       if %parms > 117;
         // Bind parameter marker 24.
         exsr initpmparms;
         pdata = p24data;
         if     %parms > 118
            and %addr(p24stype) <> *null;
           pstype = p24stype;
         endif;
         if     %parms > 119
            and %addr(p24atype) <> *null;
           patype = p24atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 120
            and %addr(p24len) <> *null;
           plen = p24len;
         endif;
         if     %parms > 121
            and %addr(p24scale) <> *null;
           pscale = p24scale;
         endif;
         pmarker = 24;
         exsr bindpmarker;
       endif;

       if %parms > 122;
         // Bind parameter marker 25.
         exsr initpmparms;
         pdata = p25data;
         if     %parms > 123
            and %addr(p25stype) <> *null;
           pstype = p25stype;
         endif;
         if     %parms > 124
            and %addr(p25atype) <> *null;
           patype = p25atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 125
            and %addr(p25len) <> *null;
           plen = p25len;
         endif;
         if     %parms > 126
            and %addr(p25scale) <> *null;
           pscale = p25scale;
         endif;
         pmarker = 25;
         exsr bindpmarker;
       endif;

       if %parms > 127;
         // Bind parameter marker 26.
         exsr initpmparms;
         pdata = p26data;
         if     %parms > 128
            and %addr(p26stype) <> *null;
           pstype = p26stype;
         endif;
         if     %parms > 129
            and %addr(p26atype) <> *null;
           patype = p26atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 130
            and %addr(p26len) <> *null;
           plen = p26len;
         endif;
         if     %parms > 131
            and %addr(p26scale) <> *null;
           pscale = p26scale;
         endif;
         pmarker = 26;
         exsr bindpmarker;
       endif;

       if %parms > 132;
         // Bind parameter marker 27.
         exsr initpmparms;
         pdata = p27data;
         if     %parms > 133
            and %addr(p27stype) <> *null;
           pstype = p27stype;
         endif;
         if     %parms > 134
            and %addr(p27atype) <> *null;
           patype = p27atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 135
            and %addr(p27len) <> *null;
           plen = p27len;
         endif;
         if     %parms > 136
            and %addr(p27scale) <> *null;
           pscale = p27scale;
         endif;
         pmarker = 27;
         exsr bindpmarker;
       endif;

       if %parms > 137;
         // Bind parameter marker 28.
         exsr initpmparms;
         pdata = p28data;
         if     %parms > 138
            and %addr(p28stype) <> *null;
           pstype = p28stype;
         endif;
         if     %parms > 139
            and %addr(p28atype) <> *null;
           patype = p28atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 140
            and %addr(p28len) <> *null;
           plen = p28len;
         endif;
         if     %parms > 141
            and %addr(p28scale) <> *null;
           pscale = p28scale;
         endif;
         pmarker = 28;
         exsr bindpmarker;
       endif;

       if %parms > 142;
         // Bind parameter marker 29.
         exsr initpmparms;
         pdata = p29data;
         if     %parms > 143
            and %addr(p29stype) <> *null;
           pstype = p29stype;
         endif;
         if     %parms > 144
            and %addr(p29atype) <> *null;
           patype = p29atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 145
            and %addr(p29len) <> *null;
           plen = p29len;
         endif;
         if     %parms > 146
            and %addr(p29scale) <> *null;
           pscale = p29scale;
         endif;
         pmarker = 29;
         exsr bindpmarker;
       endif;

       if %parms > 147;
         // Bind parameter marker 30.
         exsr initpmparms;
         pdata = p30data;
         if     %parms > 148
            and %addr(p30stype) <> *null;
           pstype = p30stype;
         endif;
         if     %parms > 149
            and %addr(p30atype) <> *null;
           patype = p30atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 150
            and %addr(p30len) <> *null;
           plen = p30len;
         endif;
         if     %parms > 151
            and %addr(p30scale) <> *null;
           pscale = p30scale;
         endif;
         pmarker = 30;
         exsr bindpmarker;
       endif;

       if %parms > 152;
         // Bind parameter marker 31.
         exsr initpmparms;
         pdata = p31data;
         if     %parms > 153
            and %addr(p31stype) <> *null;
           pstype = p31stype;
         endif;
         if     %parms > 154
            and %addr(p31atype) <> *null;
           patype = p31atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 155
            and %addr(p31len) <> *null;
           plen = p31len;
         endif;
         if     %parms > 156
            and %addr(p31scale) <> *null;
           pscale = p31scale;
         endif;
         pmarker = 31;
         exsr bindpmarker;
       endif;

       if %parms > 157;
         // Bind parameter marker 32.
         exsr initpmparms;
         pdata = p32data;
         if     %parms > 158
            and %addr(p32stype) <> *null;
           pstype = p32stype;
         endif;
         if     %parms > 159
            and %addr(p32atype) <> *null;
           patype = p32atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 160
            and %addr(p32len) <> *null;
           plen = p32len;
         endif;
         if     %parms > 161
            and %addr(p32scale) <> *null;
           pscale = p32scale;
         endif;
         pmarker = 32;
         exsr bindpmarker;
       endif;

       if %parms > 162;
         // Bind parameter marker 33.
         exsr initpmparms;
         pdata = p33data;
         if     %parms > 163
            and %addr(p33stype) <> *null;
           pstype = p33stype;
         endif;
         if     %parms > 164
            and %addr(p33atype) <> *null;
           patype = p33atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 165
            and %addr(p33len) <> *null;
           plen = p33len;
         endif;
         if     %parms > 166
            and %addr(p33scale) <> *null;
           pscale = p33scale;
         endif;
         pmarker = 33;
         exsr bindpmarker;
       endif;

       if %parms > 167;
         // Bind parameter marker 34.
         exsr initpmparms;
         pdata = p34data;
         if     %parms > 168
            and %addr(p34stype) <> *null;
           pstype = p34stype;
         endif;
         if     %parms > 169
            and %addr(p34atype) <> *null;
           patype = p34atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 170
            and %addr(p34len) <> *null;
           plen = p34len;
         endif;
         if     %parms > 171
            and %addr(p34scale) <> *null;
           pscale = p34scale;
         endif;
         pmarker = 34;
         exsr bindpmarker;
       endif;

       if %parms > 172;
         // Bind parameter marker 35.
         exsr initpmparms;
         pdata = p35data;
         if     %parms > 173
            and %addr(p35stype) <> *null;
           pstype = p35stype;
         endif;
         if     %parms > 174
            and %addr(p35atype) <> *null;
           patype = p35atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 175
            and %addr(p35len) <> *null;
           plen = p35len;
         endif;
         if     %parms > 176
            and %addr(p35scale) <> *null;
           pscale = p35scale;
         endif;
         pmarker = 35;
         exsr bindpmarker;
       endif;

       if %parms > 177;
         // Bind parameter marker 36.
         exsr initpmparms;
         pdata = p36data;
         if     %parms > 178
            and %addr(p36stype) <> *null;
           pstype = p36stype;
         endif;
         if     %parms > 179
            and %addr(p36atype) <> *null;
           patype = p36atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 180
            and %addr(p36len) <> *null;
           plen = p36len;
         endif;
         if     %parms > 181
            and %addr(p36scale) <> *null;
           pscale = p36scale;
         endif;
         pmarker = 36;
         exsr bindpmarker;
       endif;

       if %parms > 182;
         // Bind parameter marker 37.
         exsr initpmparms;
         pdata = p37data;
         if     %parms > 183
            and %addr(p37stype) <> *null;
           pstype = p37stype;
         endif;
         if     %parms > 184
            and %addr(p37atype) <> *null;
           patype = p37atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 185
            and %addr(p37len) <> *null;
           plen = p37len;
         endif;
         if     %parms > 186
            and %addr(p37scale) <> *null;
           pscale = p37scale;
         endif;
         pmarker = 37;
         exsr bindpmarker;
       endif;

       if %parms > 187;
         // Bind parameter marker 38.
         exsr initpmparms;
         pdata = p38data;
         if     %parms > 188
            and %addr(p38stype) <> *null;
           pstype = p38stype;
         endif;
         if     %parms > 189
            and %addr(p38atype) <> *null;
           patype = p38atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 190
            and %addr(p38len) <> *null;
           plen = p38len;
         endif;
         if     %parms > 191
            and %addr(p38scale) <> *null;
           pscale = p38scale;
         endif;
         pmarker = 38;
         exsr bindpmarker;
       endif;

       if %parms > 192;
         // Bind parameter marker 39.
         exsr initpmparms;
         pdata = p39data;
         if     %parms > 193
            and %addr(p39stype) <> *null;
           pstype = p39stype;
         endif;
         if     %parms > 194
            and %addr(p39atype) <> *null;
           patype = p39atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 195
            and %addr(p39len) <> *null;
           plen = p39len;
         endif;
         if     %parms > 196
            and %addr(p39scale) <> *null;
           pscale = p39scale;
         endif;
         pmarker = 39;
         exsr bindpmarker;
       endif;

       if %parms > 197;
         // Bind parameter marker 40.
         exsr initpmparms;
         pdata = p40data;
         if     %parms > 198
            and %addr(p40stype) <> *null;
           pstype = p40stype;
         endif;
         if     %parms > 199
            and %addr(p40atype) <> *null;
           patype = p40atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 200
            and %addr(p40len) <> *null;
           plen = p40len;
         endif;
         if     %parms > 201
            and %addr(p40scale) <> *null;
           pscale = p40scale;
         endif;
         pmarker = 40;
         exsr bindpmarker;
       endif;

       if %parms > 202;
         // Bind parameter marker 41.
         exsr initpmparms;
         pdata = p41data;
         if     %parms > 203
            and %addr(p41stype) <> *null;
           pstype = p41stype;
         endif;
         if     %parms > 204
            and %addr(p41atype) <> *null;
           patype = p41atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 205
            and %addr(p41len) <> *null;
           plen = p41len;
         endif;
         if     %parms > 206
            and %addr(p41scale) <> *null;
           pscale = p41scale;
         endif;
         pmarker = 41;
         exsr bindpmarker;
       endif;

       if %parms > 207;
         // Bind parameter marker 42.
         exsr initpmparms;
         pdata = p42data;
         if     %parms > 208
            and %addr(p42stype) <> *null;
           pstype = p42stype;
         endif;
         if     %parms > 209
            and %addr(p42atype) <> *null;
           patype = p42atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 210
            and %addr(p42len) <> *null;
           plen = p42len;
         endif;
         if     %parms > 211
            and %addr(p42scale) <> *null;
           pscale = p42scale;
         endif;
         pmarker = 42;
         exsr bindpmarker;
       endif;

       if %parms > 212;
         // Bind parameter marker 43.
         exsr initpmparms;
         pdata = p43data;
         if     %parms > 213
            and %addr(p43stype) <> *null;
           pstype = p43stype;
         endif;
         if     %parms > 214
            and %addr(p43atype) <> *null;
           patype = p43atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 215
            and %addr(p43len) <> *null;
           plen = p43len;
         endif;
         if     %parms > 216
            and %addr(p43scale) <> *null;
           pscale = p43scale;
         endif;
         pmarker = 43;
         exsr bindpmarker;
       endif;

       if %parms > 217;
         // Bind parameter marker 44.
         exsr initpmparms;
         pdata = p44data;
         if     %parms > 218
            and %addr(p44stype) <> *null;
           pstype = p44stype;
         endif;
         if     %parms > 219
            and %addr(p44atype) <> *null;
           patype = p44atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 220
            and %addr(p44len) <> *null;
           plen = p44len;
         endif;
         if     %parms > 221
            and %addr(p44scale) <> *null;
           pscale = p44scale;
         endif;
         pmarker = 44;
         exsr bindpmarker;
       endif;

       if %parms > 222;
         // Bind parameter marker 45.
         exsr initpmparms;
         pdata = p45data;
         if     %parms > 223
            and %addr(p45stype) <> *null;
           pstype = p45stype;
         endif;
         if     %parms > 224
            and %addr(p45atype) <> *null;
           patype = p45atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 225
            and %addr(p45len) <> *null;
           plen = p45len;
         endif;
         if     %parms > 226
            and %addr(p45scale) <> *null;
           pscale = p45scale;
         endif;
         pmarker = 45;
         exsr bindpmarker;
       endif;

       if %parms > 227;
         // Bind parameter marker 46.
         exsr initpmparms;
         pdata = p46data;
         if     %parms > 228
            and %addr(p46stype) <> *null;
           pstype = p46stype;
         endif;
         if     %parms > 229
            and %addr(p46atype) <> *null;
           patype = p46atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 230
            and %addr(p46len) <> *null;
           plen = p46len;
         endif;
         if     %parms > 231
            and %addr(p46scale) <> *null;
           pscale = p46scale;
         endif;
         pmarker = 46;
         exsr bindpmarker;
       endif;

       if %parms > 232;
         // Bind parameter marker 47.
         exsr initpmparms;
         pdata = p47data;
         if     %parms > 233
            and %addr(p47stype) <> *null;
           pstype = p47stype;
         endif;
         if     %parms > 234
            and %addr(p47atype) <> *null;
           patype = p47atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 235
            and %addr(p47len) <> *null;
           plen = p47len;
         endif;
         if     %parms > 236
            and %addr(p47scale) <> *null;
           pscale = p47scale;
         endif;
         pmarker = 47;
         exsr bindpmarker;
       endif;

       if %parms > 237;
         // Bind parameter marker 48.
         exsr initpmparms;
         pdata = p48data;
         if     %parms > 238
            and %addr(p48stype) <> *null;
           pstype = p48stype;
         endif;
         if     %parms > 239
            and %addr(p48atype) <> *null;
           patype = p48atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 240
            and %addr(p48len) <> *null;
           plen = p48len;
         endif;
         if     %parms > 241
            and %addr(p48scale) <> *null;
           pscale = p48scale;
         endif;
         pmarker = 48;
         exsr bindpmarker;
       endif;

       if %parms > 242;
         // Bind parameter marker 49.
         exsr initpmparms;
         pdata = p49data;
         if     %parms > 243
            and %addr(p49stype) <> *null;
           pstype = p49stype;
         endif;
         if     %parms > 244
            and %addr(p49atype) <> *null;
           patype = p49atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 245
            and %addr(p49len) <> *null;
           plen = p49len;
         endif;
         if     %parms > 246
            and %addr(p49scale) <> *null;
           pscale = p49scale;
         endif;
         pmarker = 49;
         exsr bindpmarker;
       endif;

       if %parms > 247;
         // Bind parameter marker 50.
         exsr initpmparms;
         pdata = p50data;
         if     %parms > 248
            and %addr(p50stype) <> *null;
           pstype = p50stype;
         endif;
         if     %parms > 249
            and %addr(p50atype) <> *null;
           patype = p50atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 250
            and %addr(p50len) <> *null;
           plen = p50len;
         endif;
         if     %parms > 251
            and %addr(p50scale) <> *null;
           pscale = p50scale;
         endif;
         pmarker = 50;
         exsr bindpmarker;
       endif;

       if %parms > 252;
         // Bind parameter marker 51.
         exsr initpmparms;
         pdata = p51data;
         if     %parms > 253
            and %addr(p51stype) <> *null;
           pstype = p51stype;
         endif;
         if     %parms > 254
            and %addr(p51atype) <> *null;
           patype = p51atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 255
            and %addr(p51len) <> *null;
           plen = p51len;
         endif;
         if     %parms > 256
            and %addr(p51scale) <> *null;
           pscale = p51scale;
         endif;
         pmarker = 51;
         exsr bindpmarker;
       endif;

       if %parms > 257;
         // Bind parameter marker 52.
         exsr initpmparms;
         pdata = p52data;
         if     %parms > 258
            and %addr(p52stype) <> *null;
           pstype = p52stype;
         endif;
         if     %parms > 259
            and %addr(p52atype) <> *null;
           patype = p52atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 260
            and %addr(p52len) <> *null;
           plen = p52len;
         endif;
         if     %parms > 261
            and %addr(p52scale) <> *null;
           pscale = p52scale;
         endif;
         pmarker = 52;
         exsr bindpmarker;
       endif;

       if %parms > 262;
         // Bind parameter marker 53.
         exsr initpmparms;
         pdata = p53data;
         if     %parms > 263
            and %addr(p53stype) <> *null;
           pstype = p53stype;
         endif;
         if     %parms > 264
            and %addr(p53atype) <> *null;
           patype = p53atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 265
            and %addr(p53len) <> *null;
           plen = p53len;
         endif;
         if     %parms > 266
            and %addr(p53scale) <> *null;
           pscale = p53scale;
         endif;
         pmarker = 53;
         exsr bindpmarker;
       endif;

       if %parms > 267;
         // Bind parameter marker 54.
         exsr initpmparms;
         pdata = p54data;
         if     %parms > 268
            and %addr(p54stype) <> *null;
           pstype = p54stype;
         endif;
         if     %parms > 269
            and %addr(p54atype) <> *null;
           patype = p54atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 270
            and %addr(p54len) <> *null;
           plen = p54len;
         endif;
         if     %parms > 271
            and %addr(p54scale) <> *null;
           pscale = p54scale;
         endif;
         pmarker = 54;
         exsr bindpmarker;
       endif;

       if %parms > 272;
         // Bind parameter marker 55.
         exsr initpmparms;
         pdata = p55data;
         if     %parms > 273
            and %addr(p55stype) <> *null;
           pstype = p55stype;
         endif;
         if     %parms > 274
            and %addr(p55atype) <> *null;
           patype = p55atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 275
            and %addr(p55len) <> *null;
           plen = p55len;
         endif;
         if     %parms > 276
            and %addr(p55scale) <> *null;
           pscale = p55scale;
         endif;
         pmarker = 55;
         exsr bindpmarker;
       endif;

       if %parms > 277;
         // Bind parameter marker 56.
         exsr initpmparms;
         pdata = p56data;
         if     %parms > 278
            and %addr(p56stype) <> *null;
           pstype = p56stype;
         endif;
         if     %parms > 279
            and %addr(p56atype) <> *null;
           patype = p56atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 280
            and %addr(p56len) <> *null;
           plen = p56len;
         endif;
         if     %parms > 281
            and %addr(p56scale) <> *null;
           pscale = p56scale;
         endif;
         pmarker = 56;
         exsr bindpmarker;
       endif;

       if %parms > 282;
         // Bind parameter marker 57.
         exsr initpmparms;
         pdata = p57data;
         if     %parms > 283
            and %addr(p57stype) <> *null;
           pstype = p57stype;
         endif;
         if     %parms > 284
            and %addr(p57atype) <> *null;
           patype = p57atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 285
            and %addr(p57len) <> *null;
           plen = p57len;
         endif;
         if     %parms > 286
            and %addr(p57scale) <> *null;
           pscale = p57scale;
         endif;
         pmarker = 57;
         exsr bindpmarker;
       endif;

       if %parms > 287;
         // Bind parameter marker 58.
         exsr initpmparms;
         pdata = p58data;
         if     %parms > 288
            and %addr(p58stype) <> *null;
           pstype = p58stype;
         endif;
         if     %parms > 289
            and %addr(p58atype) <> *null;
           patype = p58atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 290
            and %addr(p58len) <> *null;
           plen = p58len;
         endif;
         if     %parms > 291
            and %addr(p58scale) <> *null;
           pscale = p58scale;
         endif;
         pmarker = 58;
         exsr bindpmarker;
       endif;

       if %parms > 292;
         // Bind parameter marker 59.
         exsr initpmparms;
         pdata = p59data;
         if     %parms > 293
            and %addr(p59stype) <> *null;
           pstype = p59stype;
         endif;
         if     %parms > 294
            and %addr(p59atype) <> *null;
           patype = p59atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 295
            and %addr(p59len) <> *null;
           plen = p59len;
         endif;
         if     %parms > 296
            and %addr(p59scale) <> *null;
           pscale = p59scale;
         endif;
         pmarker = 59;
         exsr bindpmarker;
       endif;

       if %parms > 297;
         // Bind parameter marker 60.
         exsr initpmparms;
         pdata = p60data;
         if     %parms > 298
            and %addr(p60stype) <> *null;
           pstype = p60stype;
         endif;
         if     %parms > 299
            and %addr(p60atype) <> *null;
           patype = p60atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 300
            and %addr(p60len) <> *null;
           plen = p60len;
         endif;
         if     %parms > 301
            and %addr(p60scale) <> *null;
           pscale = p60scale;
         endif;
         pmarker = 60;
         exsr bindpmarker;
       endif;

       if %parms > 302;
         // Bind parameter marker 61.
         exsr initpmparms;
         pdata = p61data;
         if     %parms > 303
            and %addr(p61stype) <> *null;
           pstype = p61stype;
         endif;
         if     %parms > 304
            and %addr(p61atype) <> *null;
           patype = p61atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 305
            and %addr(p61len) <> *null;
           plen = p61len;
         endif;
         if     %parms > 306
            and %addr(p61scale) <> *null;
           pscale = p61scale;
         endif;
         pmarker = 61;
         exsr bindpmarker;
       endif;

       if %parms > 307;
         // Bind parameter marker 62.
         exsr initpmparms;
         pdata = p62data;
         if     %parms > 308
            and %addr(p62stype) <> *null;
           pstype = p62stype;
         endif;
         if     %parms > 309
            and %addr(p62atype) <> *null;
           patype = p62atype;
         else;
           patype = pstype;
         endif;
         if     %parms > 310
            and %addr(p62len) <> *null;
           plen = p62len;
         endif;
         if     %parms > 311
            and %addr(p62scale) <> *null;
           pscale = p62scale;
         endif;
         pmarker = 62;
         exsr bindpmarker;
       endif;

       rtn = SqlExecDirect(S_h(st):stmt:SQL_NTS);

       if    rtn = SQL_SUCCESS
          or rtn = SQL_SUCCESS_WITH_INFO;
         return st;
       endif;

       GStatus = -999;
       exsr error;

       begsr error;
         L_FreeStmt(st);
         return -1;
       endsr;

       begsr initpmparms;
         pdata  = *null;
         patype = SQL_CHAR;
         pstype = patype;
         plen   = 5;
         pscale = 0;
       endsr;

       begsr bindpmarker;
         if plen < 1;
           plen = 1;
         endif;
         pcbv@ = %addr(pcbf) + (pmarker - 1) * 4;
         pcbv = 0;
         if pdata = *null;
           pcbv = SQL_NULL_DATA;
         elseif    patype = SQL_CHAR
                or patype = SQL_BLOB
                or patype = SQL_CLOB
                or patype = SQL_DBCLOB;
           pcbv = plen;
         endif;
         rtn = SqlBindParam( S_h(st)
                 : pmarker
                 : patype : pstype
                 : plen : pscale
                 : pdata : pcbv@);
         if     rtn <> SQL_SUCCESS
            and rtn <> SQL_SUCCESS_WITH_INFO;
           GStatus = -401;
           exsr error;
         endif;
       endsr;

      /end-free
     p                 e


     p SqlsBindCols    b                   export
     d SqlsBindCols    pi              n
     d   handle                       5i 0 const
     d   c01col                       5i 0 const
     d   c01data                       *   const
     d   c01atype                     5i 0 const options(*nopass:*omit)
     d   c01len                      10i 0 const options(*nopass:*omit)
     d   c01scale                     5i 0 const options(*nopass:*omit)
     d   c02col                       5i 0 const options(*nopass)
     d   c02data                       *   const options(*nopass)
     d   c02atype                     5i 0 const options(*nopass:*omit)
     d   c02len                      10i 0 const options(*nopass:*omit)
     d   c02scale                     5i 0 const options(*nopass:*omit)
     d   c03col                       5i 0 const options(*nopass)
     d   c03data                       *   const options(*nopass)
     d   c03atype                     5i 0 const options(*nopass:*omit)
     d   c03len                      10i 0 const options(*nopass:*omit)
     d   c03scale                     5i 0 const options(*nopass:*omit)
     d   c04col                       5i 0 const options(*nopass)
     d   c04data                       *   const options(*nopass)
     d   c04atype                     5i 0 const options(*nopass:*omit)
     d   c04len                      10i 0 const options(*nopass:*omit)
     d   c04scale                     5i 0 const options(*nopass:*omit)
     d   c05col                       5i 0 const options(*nopass)
     d   c05data                       *   const options(*nopass)
     d   c05atype                     5i 0 const options(*nopass:*omit)
     d   c05len                      10i 0 const options(*nopass:*omit)
     d   c05scale                     5i 0 const options(*nopass:*omit)
     d   c06col                       5i 0 const options(*nopass)
     d   c06data                       *   const options(*nopass)
     d   c06atype                     5i 0 const options(*nopass:*omit)
     d   c06len                      10i 0 const options(*nopass:*omit)
     d   c06scale                     5i 0 const options(*nopass:*omit)
     d   c07col                       5i 0 const options(*nopass)
     d   c07data                       *   const options(*nopass)
     d   c07atype                     5i 0 const options(*nopass:*omit)
     d   c07len                      10i 0 const options(*nopass:*omit)
     d   c07scale                     5i 0 const options(*nopass:*omit)
     d   c08col                       5i 0 const options(*nopass)
     d   c08data                       *   const options(*nopass)
     d   c08atype                     5i 0 const options(*nopass:*omit)
     d   c08len                      10i 0 const options(*nopass:*omit)
     d   c08scale                     5i 0 const options(*nopass:*omit)
     d   c09col                       5i 0 const options(*nopass)
     d   c09data                       *   const options(*nopass)
     d   c09atype                     5i 0 const options(*nopass:*omit)
     d   c09len                      10i 0 const options(*nopass:*omit)
     d   c09scale                     5i 0 const options(*nopass:*omit)
     d   c10col                       5i 0 const options(*nopass)
     d   c10data                       *   const options(*nopass)
     d   c10atype                     5i 0 const options(*nopass:*omit)
     d   c10len                      10i 0 const options(*nopass:*omit)
     d   c10scale                     5i 0 const options(*nopass:*omit)
     d   c11col                       5i 0 const options(*nopass)
     d   c11data                       *   const options(*nopass)
     d   c11atype                     5i 0 const options(*nopass:*omit)
     d   c11len                      10i 0 const options(*nopass:*omit)
     d   c11scale                     5i 0 const options(*nopass:*omit)
     d   c12col                       5i 0 const options(*nopass)
     d   c12data                       *   const options(*nopass)
     d   c12atype                     5i 0 const options(*nopass:*omit)
     d   c12len                      10i 0 const options(*nopass:*omit)
     d   c12scale                     5i 0 const options(*nopass:*omit)
     d   c13col                       5i 0 const options(*nopass)
     d   c13data                       *   const options(*nopass)
     d   c13atype                     5i 0 const options(*nopass:*omit)
     d   c13len                      10i 0 const options(*nopass:*omit)
     d   c13scale                     5i 0 const options(*nopass:*omit)
     d   c14col                       5i 0 const options(*nopass)
     d   c14data                       *   const options(*nopass)
     d   c14atype                     5i 0 const options(*nopass:*omit)
     d   c14len                      10i 0 const options(*nopass:*omit)
     d   c14scale                     5i 0 const options(*nopass:*omit)
     d   c15col                       5i 0 const options(*nopass)
     d   c15data                       *   const options(*nopass)
     d   c15atype                     5i 0 const options(*nopass:*omit)
     d   c15len                      10i 0 const options(*nopass:*omit)
     d   c15scale                     5i 0 const options(*nopass:*omit)
     d   c16col                       5i 0 const options(*nopass)
     d   c16data                       *   const options(*nopass)
     d   c16atype                     5i 0 const options(*nopass:*omit)
     d   c16len                      10i 0 const options(*nopass:*omit)
     d   c16scale                     5i 0 const options(*nopass:*omit)
     d   c17col                       5i 0 const options(*nopass)
     d   c17data                       *   const options(*nopass)
     d   c17atype                     5i 0 const options(*nopass:*omit)
     d   c17len                      10i 0 const options(*nopass:*omit)
     d   c17scale                     5i 0 const options(*nopass:*omit)
     d   c18col                       5i 0 const options(*nopass)
     d   c18data                       *   const options(*nopass)
     d   c18atype                     5i 0 const options(*nopass:*omit)
     d   c18len                      10i 0 const options(*nopass:*omit)
     d   c18scale                     5i 0 const options(*nopass:*omit)
     d   c19col                       5i 0 const options(*nopass)
     d   c19data                       *   const options(*nopass)
     d   c19atype                     5i 0 const options(*nopass:*omit)
     d   c19len                      10i 0 const options(*nopass:*omit)
     d   c19scale                     5i 0 const options(*nopass:*omit)
     d   c20col                       5i 0 const options(*nopass)
     d   c20data                       *   const options(*nopass)
     d   c20atype                     5i 0 const options(*nopass:*omit)
     d   c20len                      10i 0 const options(*nopass:*omit)
     d   c20scale                     5i 0 const options(*nopass:*omit)
     d   c21col                       5i 0 const options(*nopass)
     d   c21data                       *   const options(*nopass)
     d   c21atype                     5i 0 const options(*nopass:*omit)
     d   c21len                      10i 0 const options(*nopass:*omit)
     d   c21scale                     5i 0 const options(*nopass:*omit)
     d   c22col                       5i 0 const options(*nopass)
     d   c22data                       *   const options(*nopass)
     d   c22atype                     5i 0 const options(*nopass:*omit)
     d   c22len                      10i 0 const options(*nopass:*omit)
     d   c22scale                     5i 0 const options(*nopass:*omit)
     d   c23col                       5i 0 const options(*nopass)
     d   c23data                       *   const options(*nopass)
     d   c23atype                     5i 0 const options(*nopass:*omit)
     d   c23len                      10i 0 const options(*nopass:*omit)
     d   c23scale                     5i 0 const options(*nopass:*omit)
     d   c24col                       5i 0 const options(*nopass)
     d   c24data                       *   const options(*nopass)
     d   c24atype                     5i 0 const options(*nopass:*omit)
     d   c24len                      10i 0 const options(*nopass:*omit)
     d   c24scale                     5i 0 const options(*nopass:*omit)
     d   c25col                       5i 0 const options(*nopass)
     d   c25data                       *   const options(*nopass)
     d   c25atype                     5i 0 const options(*nopass:*omit)
     d   c25len                      10i 0 const options(*nopass:*omit)
     d   c25scale                     5i 0 const options(*nopass:*omit)
     d   c26col                       5i 0 const options(*nopass)
     d   c26data                       *   const options(*nopass)
     d   c26atype                     5i 0 const options(*nopass:*omit)
     d   c26len                      10i 0 const options(*nopass:*omit)
     d   c26scale                     5i 0 const options(*nopass:*omit)
     d   c27col                       5i 0 const options(*nopass)
     d   c27data                       *   const options(*nopass)
     d   c27atype                     5i 0 const options(*nopass:*omit)
     d   c27len                      10i 0 const options(*nopass:*omit)
     d   c27scale                     5i 0 const options(*nopass:*omit)
     d   c28col                       5i 0 const options(*nopass)
     d   c28data                       *   const options(*nopass)
     d   c28atype                     5i 0 const options(*nopass:*omit)
     d   c28len                      10i 0 const options(*nopass:*omit)
     d   c28scale                     5i 0 const options(*nopass:*omit)
     d   c29col                       5i 0 const options(*nopass)
     d   c29data                       *   const options(*nopass)
     d   c29atype                     5i 0 const options(*nopass:*omit)
     d   c29len                      10i 0 const options(*nopass:*omit)
     d   c29scale                     5i 0 const options(*nopass:*omit)
     d   c30col                       5i 0 const options(*nopass)
     d   c30data                       *   const options(*nopass)
     d   c30atype                     5i 0 const options(*nopass:*omit)
     d   c30len                      10i 0 const options(*nopass:*omit)
     d   c30scale                     5i 0 const options(*nopass:*omit)
     d   c31col                       5i 0 const options(*nopass)
     d   c31data                       *   const options(*nopass)
     d   c31atype                     5i 0 const options(*nopass:*omit)
     d   c31len                      10i 0 const options(*nopass:*omit)
     d   c31scale                     5i 0 const options(*nopass:*omit)
     d   c32col                       5i 0 const options(*nopass)
     d   c32data                       *   const options(*nopass)
     d   c32atype                     5i 0 const options(*nopass:*omit)
     d   c32len                      10i 0 const options(*nopass:*omit)
     d   c32scale                     5i 0 const options(*nopass:*omit)
     d   c33col                       5i 0 const options(*nopass)
     d   c33data                       *   const options(*nopass)
     d   c33atype                     5i 0 const options(*nopass:*omit)
     d   c33len                      10i 0 const options(*nopass:*omit)
     d   c33scale                     5i 0 const options(*nopass:*omit)
     d   c34col                       5i 0 const options(*nopass)
     d   c34data                       *   const options(*nopass)
     d   c34atype                     5i 0 const options(*nopass:*omit)
     d   c34len                      10i 0 const options(*nopass:*omit)
     d   c34scale                     5i 0 const options(*nopass:*omit)
     d   c35col                       5i 0 const options(*nopass)
     d   c35data                       *   const options(*nopass)
     d   c35atype                     5i 0 const options(*nopass:*omit)
     d   c35len                      10i 0 const options(*nopass:*omit)
     d   c35scale                     5i 0 const options(*nopass:*omit)
     d   c36col                       5i 0 const options(*nopass)
     d   c36data                       *   const options(*nopass)
     d   c36atype                     5i 0 const options(*nopass:*omit)
     d   c36len                      10i 0 const options(*nopass:*omit)
     d   c36scale                     5i 0 const options(*nopass:*omit)
     d   c37col                       5i 0 const options(*nopass)
     d   c37data                       *   const options(*nopass)
     d   c37atype                     5i 0 const options(*nopass:*omit)
     d   c37len                      10i 0 const options(*nopass:*omit)
     d   c37scale                     5i 0 const options(*nopass:*omit)
     d   c38col                       5i 0 const options(*nopass)
     d   c38data                       *   const options(*nopass)
     d   c38atype                     5i 0 const options(*nopass:*omit)
     d   c38len                      10i 0 const options(*nopass:*omit)
     d   c38scale                     5i 0 const options(*nopass:*omit)
     d   c39col                       5i 0 const options(*nopass)
     d   c39data                       *   const options(*nopass)
     d   c39atype                     5i 0 const options(*nopass:*omit)
     d   c39len                      10i 0 const options(*nopass:*omit)
     d   c39scale                     5i 0 const options(*nopass:*omit)
     d   c40col                       5i 0 const options(*nopass)
     d   c40data                       *   const options(*nopass)
     d   c40atype                     5i 0 const options(*nopass:*omit)
     d   c40len                      10i 0 const options(*nopass:*omit)
     d   c40scale                     5i 0 const options(*nopass:*omit)
     d   c41col                       5i 0 const options(*nopass)
     d   c41data                       *   const options(*nopass)
     d   c41atype                     5i 0 const options(*nopass:*omit)
     d   c41len                      10i 0 const options(*nopass:*omit)
     d   c41scale                     5i 0 const options(*nopass:*omit)
     d   c42col                       5i 0 const options(*nopass)
     d   c42data                       *   const options(*nopass)
     d   c42atype                     5i 0 const options(*nopass:*omit)
     d   c42len                      10i 0 const options(*nopass:*omit)
     d   c42scale                     5i 0 const options(*nopass:*omit)
     d   c43col                       5i 0 const options(*nopass)
     d   c43data                       *   const options(*nopass)
     d   c43atype                     5i 0 const options(*nopass:*omit)
     d   c43len                      10i 0 const options(*nopass:*omit)
     d   c43scale                     5i 0 const options(*nopass:*omit)
     d   c44col                       5i 0 const options(*nopass)
     d   c44data                       *   const options(*nopass)
     d   c44atype                     5i 0 const options(*nopass:*omit)
     d   c44len                      10i 0 const options(*nopass:*omit)
     d   c44scale                     5i 0 const options(*nopass:*omit)
     d   c45col                       5i 0 const options(*nopass)
     d   c45data                       *   const options(*nopass)
     d   c45atype                     5i 0 const options(*nopass:*omit)
     d   c45len                      10i 0 const options(*nopass:*omit)
     d   c45scale                     5i 0 const options(*nopass:*omit)
     d   c46col                       5i 0 const options(*nopass)
     d   c46data                       *   const options(*nopass)
     d   c46atype                     5i 0 const options(*nopass:*omit)
     d   c46len                      10i 0 const options(*nopass:*omit)
     d   c46scale                     5i 0 const options(*nopass:*omit)
     d   c47col                       5i 0 const options(*nopass)
     d   c47data                       *   const options(*nopass)
     d   c47atype                     5i 0 const options(*nopass:*omit)
     d   c47len                      10i 0 const options(*nopass:*omit)
     d   c47scale                     5i 0 const options(*nopass:*omit)
     d   c48col                       5i 0 const options(*nopass)
     d   c48data                       *   const options(*nopass)
     d   c48atype                     5i 0 const options(*nopass:*omit)
     d   c48len                      10i 0 const options(*nopass:*omit)
     d   c48scale                     5i 0 const options(*nopass:*omit)
     d   c49col                       5i 0 const options(*nopass)
     d   c49data                       *   const options(*nopass)
     d   c49atype                     5i 0 const options(*nopass:*omit)
     d   c49len                      10i 0 const options(*nopass:*omit)
     d   c49scale                     5i 0 const options(*nopass:*omit)
     d   c50col                       5i 0 const options(*nopass)
     d   c50data                       *   const options(*nopass)
     d   c50atype                     5i 0 const options(*nopass:*omit)
     d   c50len                      10i 0 const options(*nopass:*omit)
     d   c50scale                     5i 0 const options(*nopass:*omit)
     d   c51col                       5i 0 const options(*nopass)
     d   c51data                       *   const options(*nopass)
     d   c51atype                     5i 0 const options(*nopass:*omit)
     d   c51len                      10i 0 const options(*nopass:*omit)
     d   c51scale                     5i 0 const options(*nopass:*omit)
     d   c52col                       5i 0 const options(*nopass)
     d   c52data                       *   const options(*nopass)
     d   c52atype                     5i 0 const options(*nopass:*omit)
     d   c52len                      10i 0 const options(*nopass:*omit)
     d   c52scale                     5i 0 const options(*nopass:*omit)
     d   c53col                       5i 0 const options(*nopass)
     d   c53data                       *   const options(*nopass)
     d   c53atype                     5i 0 const options(*nopass:*omit)
     d   c53len                      10i 0 const options(*nopass:*omit)
     d   c53scale                     5i 0 const options(*nopass:*omit)
     d   c54col                       5i 0 const options(*nopass)
     d   c54data                       *   const options(*nopass)
     d   c54atype                     5i 0 const options(*nopass:*omit)
     d   c54len                      10i 0 const options(*nopass:*omit)
     d   c54scale                     5i 0 const options(*nopass:*omit)
     d   c55col                       5i 0 const options(*nopass)
     d   c55data                       *   const options(*nopass)
     d   c55atype                     5i 0 const options(*nopass:*omit)
     d   c55len                      10i 0 const options(*nopass:*omit)
     d   c55scale                     5i 0 const options(*nopass:*omit)
     d   c56col                       5i 0 const options(*nopass)
     d   c56data                       *   const options(*nopass)
     d   c56atype                     5i 0 const options(*nopass:*omit)
     d   c56len                      10i 0 const options(*nopass:*omit)
     d   c56scale                     5i 0 const options(*nopass:*omit)
     d   c57col                       5i 0 const options(*nopass)
     d   c57data                       *   const options(*nopass)
     d   c57atype                     5i 0 const options(*nopass:*omit)
     d   c57len                      10i 0 const options(*nopass:*omit)
     d   c57scale                     5i 0 const options(*nopass:*omit)
     d   c58col                       5i 0 const options(*nopass)
     d   c58data                       *   const options(*nopass)
     d   c58atype                     5i 0 const options(*nopass:*omit)
     d   c58len                      10i 0 const options(*nopass:*omit)
     d   c58scale                     5i 0 const options(*nopass:*omit)
     d   c59col                       5i 0 const options(*nopass)
     d   c59data                       *   const options(*nopass)
     d   c59atype                     5i 0 const options(*nopass:*omit)
     d   c59len                      10i 0 const options(*nopass:*omit)
     d   c59scale                     5i 0 const options(*nopass:*omit)
     d   c60col                       5i 0 const options(*nopass)
     d   c60data                       *   const options(*nopass)
     d   c60atype                     5i 0 const options(*nopass:*omit)
     d   c60len                      10i 0 const options(*nopass:*omit)
     d   c60scale                     5i 0 const options(*nopass:*omit)
     d   c61col                       5i 0 const options(*nopass)
     d   c61data                       *   const options(*nopass)
     d   c61atype                     5i 0 const options(*nopass:*omit)
     d   c61len                      10i 0 const options(*nopass:*omit)
     d   c61scale                     5i 0 const options(*nopass:*omit)
     d   c62col                       5i 0 const options(*nopass)
     d   c62data                       *   const options(*nopass)
     d   c62atype                     5i 0 const options(*nopass:*omit)
     d   c62len                      10i 0 const options(*nopass:*omit)
     d   c62scale                     5i 0 const options(*nopass:*omit)

     d st              s              5i 0
     d ccol            s              5i 0
     d cdata           s                   like(c01data)
     d catype          s                   like(c01atype)
     d clen            s                   like(c01len)
     d cscale          s                   like(c01scale)
     d cbv             s             10i 0
     d rtn             s                   like(SQLRETURN)
     d pcba            s               *

      /free

       GStatus = 0;

       st = handle;

       if    st < 1
          or st > CSqlsMaxCurs
          or not S_allocated(st);
         GStatus = -101;
         return *off;
       endif;

       if %parms > 2;
         // Bind/unbind column 1.
         exsr initcparms;
         ccol = c01col;
         if c01data <> *null;
           cdata = c01data;
           if     %parms > 3
              and %addr(c01atype) <> *null;
             catype = c01atype;
           endif;
           if     %parms > 4
              and %addr(c01len) <> *null;
             clen = c01len;
           endif;
           if     %parms > 5
              and %addr(c01scale) <> *null;
             cscale = c01scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 7;
         // Bind/unbind column 2.
         exsr initcparms;
         ccol = c02col;
         if c02data <> *null;
           cdata = c02data;
           if     %parms > 8
              and %addr(c02atype) <> *null;
             catype = c02atype;
           endif;
           if     %parms > 9
              and %addr(c02len) <> *null;
             clen = c02len;
           endif;
           if     %parms > 10
              and %addr(c02scale) <> *null;
             cscale = c02scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 12;
         // Bind/unbind column 3.
         exsr initcparms;
         ccol = c03col;
         if c03data <> *null;
           cdata = c03data;
           if     %parms > 13
              and %addr(c03atype) <> *null;
             catype = c03atype;
           endif;
           if     %parms > 14
              and %addr(c03len) <> *null;
             clen = c03len;
           endif;
           if     %parms > 15
              and %addr(c03scale) <> *null;
             cscale = c03scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 17;
         // Bind/unbind column 4.
         exsr initcparms;
         ccol = c04col;
         if c04data <> *null;
           cdata = c04data;
           if     %parms > 18
              and %addr(c04atype) <> *null;
             catype = c04atype;
           endif;
           if     %parms > 19
              and %addr(c04len) <> *null;
             clen = c04len;
           endif;
           if     %parms > 20
              and %addr(c04scale) <> *null;
             cscale = c04scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 22;
         // Bind/unbind column 5.
         exsr initcparms;
         ccol = c05col;
         if c05data <> *null;
           cdata = c05data;
           if     %parms > 23
              and %addr(c05atype) <> *null;
             catype = c05atype;
           endif;
           if     %parms > 24
              and %addr(c05len) <> *null;
             clen = c05len;
           endif;
           if     %parms > 25
              and %addr(c05scale) <> *null;
             cscale = c05scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 27;
         // Bind/unbind column 6.
         exsr initcparms;
         ccol = c06col;
         if c06data <> *null;
           cdata = c06data;
           if     %parms > 28
              and %addr(c06atype) <> *null;
             catype = c06atype;
           endif;
           if     %parms > 29
              and %addr(c06len) <> *null;
             clen = c06len;
           endif;
           if     %parms > 30
              and %addr(c06scale) <> *null;
             cscale = c06scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 32;
         // Bind/unbind column 7.
         exsr initcparms;
         ccol = c07col;
         if c07data <> *null;
           cdata = c07data;
           if     %parms > 33
              and %addr(c07atype) <> *null;
             catype = c07atype;
           endif;
           if     %parms > 34
              and %addr(c07len) <> *null;
             clen = c07len;
           endif;
           if     %parms > 35
              and %addr(c07scale) <> *null;
             cscale = c07scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 37;
         // Bind/unbind column 8.
         exsr initcparms;
         ccol = c08col;
         if c08data <> *null;
           cdata = c08data;
           if     %parms > 38
              and %addr(c08atype) <> *null;
             catype = c08atype;
           endif;
           if     %parms > 39
              and %addr(c08len) <> *null;
             clen = c08len;
           endif;
           if     %parms > 40
              and %addr(c08scale) <> *null;
             cscale = c08scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 42;
         // Bind/unbind column 9.
         exsr initcparms;
         ccol = c09col;
         if c09data <> *null;
           cdata = c09data;
           if     %parms > 43
              and %addr(c09atype) <> *null;
             catype = c09atype;
           endif;
           if     %parms > 44
              and %addr(c09len) <> *null;
             clen = c09len;
           endif;
           if     %parms > 45
              and %addr(c09scale) <> *null;
             cscale = c09scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 47;
         // Bind/unbind column 10.
         exsr initcparms;
         ccol = c10col;
         if c10data <> *null;
           cdata = c10data;
           if     %parms > 48
              and %addr(c10atype) <> *null;
             catype = c10atype;
           endif;
           if     %parms > 49
              and %addr(c10len) <> *null;
             clen = c10len;
           endif;
           if     %parms > 50
              and %addr(c10scale) <> *null;
             cscale = c10scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 52;
         // Bind/unbind column 11.
         exsr initcparms;
         ccol = c11col;
         if c11data <> *null;
           cdata = c11data;
           if     %parms > 53
              and %addr(c11atype) <> *null;
             catype = c11atype;
           endif;
           if     %parms > 54
              and %addr(c11len) <> *null;
             clen = c11len;
           endif;
           if     %parms > 55
              and %addr(c11scale) <> *null;
             cscale = c11scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 57;
         // Bind/unbind column 12.
         exsr initcparms;
         ccol = c12col;
         if c12data <> *null;
           cdata = c12data;
           if     %parms > 58
              and %addr(c12atype) <> *null;
             catype = c12atype;
           endif;
           if     %parms > 59
              and %addr(c12len) <> *null;
             clen = c12len;
           endif;
           if     %parms > 60
              and %addr(c12scale) <> *null;
             cscale = c12scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 62;
         // Bind/unbind column 13.
         exsr initcparms;
         ccol = c13col;
         if c13data <> *null;
           cdata = c13data;
           if     %parms > 63
              and %addr(c13atype) <> *null;
             catype = c13atype;
           endif;
           if     %parms > 64
              and %addr(c13len) <> *null;
             clen = c13len;
           endif;
           if     %parms > 65
              and %addr(c13scale) <> *null;
             cscale = c13scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 67;
         // Bind/unbind column 14.
         exsr initcparms;
         ccol = c14col;
         if c14data <> *null;
           cdata = c14data;
           if     %parms > 68
              and %addr(c14atype) <> *null;
             catype = c14atype;
           endif;
           if     %parms > 69
              and %addr(c14len) <> *null;
             clen = c14len;
           endif;
           if     %parms > 70
              and %addr(c14scale) <> *null;
             cscale = c14scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 72;
         // Bind/unbind column 15.
         exsr initcparms;
         ccol = c15col;
         if c15data <> *null;
           cdata = c15data;
           if     %parms > 73
              and %addr(c15atype) <> *null;
             catype = c15atype;
           endif;
           if     %parms > 74
              and %addr(c15len) <> *null;
             clen = c15len;
           endif;
           if     %parms > 75
              and %addr(c15scale) <> *null;
             cscale = c15scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 77;
         // Bind/unbind column 16.
         exsr initcparms;
         ccol = c16col;
         if c16data <> *null;
           cdata = c16data;
           if     %parms > 78
              and %addr(c16atype) <> *null;
             catype = c16atype;
           endif;
           if     %parms > 79
              and %addr(c16len) <> *null;
             clen = c16len;
           endif;
           if     %parms > 80
              and %addr(c16scale) <> *null;
             cscale = c16scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 82;
         // Bind/unbind column 17.
         exsr initcparms;
         ccol = c17col;
         if c17data <> *null;
           cdata = c17data;
           if     %parms > 83
              and %addr(c17atype) <> *null;
             catype = c17atype;
           endif;
           if     %parms > 84
              and %addr(c17len) <> *null;
             clen = c17len;
           endif;
           if     %parms > 85
              and %addr(c17scale) <> *null;
             cscale = c17scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 87;
         // Bind/unbind column 18.
         exsr initcparms;
         ccol = c18col;
         if c18data <> *null;
           cdata = c18data;
           if     %parms > 88
              and %addr(c18atype) <> *null;
             catype = c18atype;
           endif;
           if     %parms > 89
              and %addr(c18len) <> *null;
             clen = c18len;
           endif;
           if     %parms > 90
              and %addr(c18scale) <> *null;
             cscale = c18scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 92;
         // Bind/unbind column 19.
         exsr initcparms;
         ccol = c19col;
         if c19data <> *null;
           cdata = c19data;
           if     %parms > 93
              and %addr(c19atype) <> *null;
             catype = c19atype;
           endif;
           if     %parms > 94
              and %addr(c19len) <> *null;
             clen = c19len;
           endif;
           if     %parms > 95
              and %addr(c19scale) <> *null;
             cscale = c19scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 97;
         // Bind/unbind column 20.
         exsr initcparms;
         ccol = c20col;
         if c20data <> *null;
           cdata = c20data;
           if     %parms > 98
              and %addr(c20atype) <> *null;
             catype = c20atype;
           endif;
           if     %parms > 99
              and %addr(c20len) <> *null;
             clen = c20len;
           endif;
           if     %parms > 100
              and %addr(c20scale) <> *null;
             cscale = c20scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 102;
         // Bind/unbind column 21.
         exsr initcparms;
         ccol = c21col;
         if c21data <> *null;
           cdata = c21data;
           if     %parms > 103
              and %addr(c21atype) <> *null;
             catype = c21atype;
           endif;
           if     %parms > 104
              and %addr(c21len) <> *null;
             clen = c21len;
           endif;
           if     %parms > 105
              and %addr(c21scale) <> *null;
             cscale = c21scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 107;
         // Bind/unbind column 22.
         exsr initcparms;
         ccol = c22col;
         if c22data <> *null;
           cdata = c22data;
           if     %parms > 108
              and %addr(c22atype) <> *null;
             catype = c22atype;
           endif;
           if     %parms > 109
              and %addr(c22len) <> *null;
             clen = c22len;
           endif;
           if     %parms > 110
              and %addr(c22scale) <> *null;
             cscale = c22scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 112;
         // Bind/unbind column 23.
         exsr initcparms;
         ccol = c23col;
         if c23data <> *null;
           cdata = c23data;
           if     %parms > 113
              and %addr(c23atype) <> *null;
             catype = c23atype;
           endif;
           if     %parms > 114
              and %addr(c23len) <> *null;
             clen = c23len;
           endif;
           if     %parms > 115
              and %addr(c23scale) <> *null;
             cscale = c23scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 117;
         // Bind/unbind column 24.
         exsr initcparms;
         ccol = c24col;
         if c24data <> *null;
           cdata = c24data;
           if     %parms > 118
              and %addr(c24atype) <> *null;
             catype = c24atype;
           endif;
           if     %parms > 119
              and %addr(c24len) <> *null;
             clen = c24len;
           endif;
           if     %parms > 120
              and %addr(c24scale) <> *null;
             cscale = c24scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 122;
         // Bind/unbind column 25.
         exsr initcparms;
         ccol = c25col;
         if c25data <> *null;
           cdata = c25data;
           if     %parms > 123
              and %addr(c25atype) <> *null;
             catype = c25atype;
           endif;
           if     %parms > 124
              and %addr(c25len) <> *null;
             clen = c25len;
           endif;
           if     %parms > 125
              and %addr(c25scale) <> *null;
             cscale = c25scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 127;
         // Bind/unbind column 26.
         exsr initcparms;
         ccol = c26col;
         if c26data <> *null;
           cdata = c26data;
           if     %parms > 128
              and %addr(c26atype) <> *null;
             catype = c26atype;
           endif;
           if     %parms > 129
              and %addr(c26len) <> *null;
             clen = c26len;
           endif;
           if     %parms > 130
              and %addr(c26scale) <> *null;
             cscale = c26scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 132;
         // Bind/unbind column 27.
         exsr initcparms;
         ccol = c27col;
         if c27data <> *null;
           cdata = c27data;
           if     %parms > 133
              and %addr(c27atype) <> *null;
             catype = c27atype;
           endif;
           if     %parms > 134
              and %addr(c27len) <> *null;
             clen = c27len;
           endif;
           if     %parms > 135
              and %addr(c27scale) <> *null;
             cscale = c27scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 137;
         // Bind/unbind column 28.
         exsr initcparms;
         ccol = c28col;
         if c28data <> *null;
           cdata = c28data;
           if     %parms > 138
              and %addr(c28atype) <> *null;
             catype = c28atype;
           endif;
           if     %parms > 139
              and %addr(c28len) <> *null;
             clen = c28len;
           endif;
           if     %parms > 140
              and %addr(c28scale) <> *null;
             cscale = c28scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 142;
         // Bind/unbind column 29.
         exsr initcparms;
         ccol = c29col;
         if c29data <> *null;
           cdata = c29data;
           if     %parms > 143
              and %addr(c29atype) <> *null;
             catype = c29atype;
           endif;
           if     %parms > 144
              and %addr(c29len) <> *null;
             clen = c29len;
           endif;
           if     %parms > 145
              and %addr(c29scale) <> *null;
             cscale = c29scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 147;
         // Bind/unbind column 30.
         exsr initcparms;
         ccol = c30col;
         if c30data <> *null;
           cdata = c30data;
           if     %parms > 148
              and %addr(c30atype) <> *null;
             catype = c30atype;
           endif;
           if     %parms > 149
              and %addr(c30len) <> *null;
             clen = c30len;
           endif;
           if     %parms > 150
              and %addr(c30scale) <> *null;
             cscale = c30scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 152;
         // Bind/unbind column 31.
         exsr initcparms;
         ccol = c31col;
         if c31data <> *null;
           cdata = c31data;
           if     %parms > 153
              and %addr(c31atype) <> *null;
             catype = c31atype;
           endif;
           if     %parms > 154
              and %addr(c31len) <> *null;
             clen = c31len;
           endif;
           if     %parms > 155
              and %addr(c31scale) <> *null;
             cscale = c31scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 157;
         // Bind/unbind column 32.
         exsr initcparms;
         ccol = c32col;
         if c32data <> *null;
           cdata = c32data;
           if     %parms > 158
              and %addr(c32atype) <> *null;
             catype = c32atype;
           endif;
           if     %parms > 159
              and %addr(c32len) <> *null;
             clen = c32len;
           endif;
           if     %parms > 160
              and %addr(c32scale) <> *null;
             cscale = c32scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 162;
         // Bind/unbind column 33.
         exsr initcparms;
         ccol = c33col;
         if c33data <> *null;
           cdata = c33data;
           if     %parms > 163
              and %addr(c33atype) <> *null;
             catype = c33atype;
           endif;
           if     %parms > 164
              and %addr(c33len) <> *null;
             clen = c33len;
           endif;
           if     %parms > 165
              and %addr(c33scale) <> *null;
             cscale = c33scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 167;
         // Bind/unbind column 34.
         exsr initcparms;
         ccol = c34col;
         if c34data <> *null;
           cdata = c34data;
           if     %parms > 168
              and %addr(c34atype) <> *null;
             catype = c34atype;
           endif;
           if     %parms > 169
              and %addr(c34len) <> *null;
             clen = c34len;
           endif;
           if     %parms > 170
              and %addr(c34scale) <> *null;
             cscale = c34scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 172;
         // Bind/unbind column 35.
         exsr initcparms;
         ccol = c35col;
         if c35data <> *null;
           cdata = c35data;
           if     %parms > 173
              and %addr(c35atype) <> *null;
             catype = c35atype;
           endif;
           if     %parms > 174
              and %addr(c35len) <> *null;
             clen = c35len;
           endif;
           if     %parms > 175
              and %addr(c35scale) <> *null;
             cscale = c35scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 177;
         // Bind/unbind column 36.
         exsr initcparms;
         ccol = c36col;
         if c36data <> *null;
           cdata = c36data;
           if     %parms > 178
              and %addr(c36atype) <> *null;
             catype = c36atype;
           endif;
           if     %parms > 179
              and %addr(c36len) <> *null;
             clen = c36len;
           endif;
           if     %parms > 180
              and %addr(c36scale) <> *null;
             cscale = c36scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 182;
         // Bind/unbind column 37.
         exsr initcparms;
         ccol = c37col;
         if c37data <> *null;
           cdata = c37data;
           if     %parms > 183
              and %addr(c37atype) <> *null;
             catype = c37atype;
           endif;
           if     %parms > 184
              and %addr(c37len) <> *null;
             clen = c37len;
           endif;
           if     %parms > 185
              and %addr(c37scale) <> *null;
             cscale = c37scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 187;
         // Bind/unbind column 38.
         exsr initcparms;
         ccol = c38col;
         if c38data <> *null;
           cdata = c38data;
           if     %parms > 188
              and %addr(c38atype) <> *null;
             catype = c38atype;
           endif;
           if     %parms > 189
              and %addr(c38len) <> *null;
             clen = c38len;
           endif;
           if     %parms > 190
              and %addr(c38scale) <> *null;
             cscale = c38scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 192;
         // Bind/unbind column 39.
         exsr initcparms;
         ccol = c39col;
         if c39data <> *null;
           cdata = c39data;
           if     %parms > 193
              and %addr(c39atype) <> *null;
             catype = c39atype;
           endif;
           if     %parms > 194
              and %addr(c39len) <> *null;
             clen = c39len;
           endif;
           if     %parms > 195
              and %addr(c39scale) <> *null;
             cscale = c39scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 197;
         // Bind/unbind column 40.
         exsr initcparms;
         ccol = c40col;
         if c40data <> *null;
           cdata = c40data;
           if     %parms > 198
              and %addr(c40atype) <> *null;
             catype = c40atype;
           endif;
           if     %parms > 199
              and %addr(c40len) <> *null;
             clen = c40len;
           endif;
           if     %parms > 200
              and %addr(c40scale) <> *null;
             cscale = c40scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 202;
         // Bind/unbind column 41.
         exsr initcparms;
         ccol = c41col;
         if c41data <> *null;
           cdata = c41data;
           if     %parms > 203
              and %addr(c41atype) <> *null;
             catype = c41atype;
           endif;
           if     %parms > 204
              and %addr(c41len) <> *null;
             clen = c41len;
           endif;
           if     %parms > 205
              and %addr(c41scale) <> *null;
             cscale = c41scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 207;
         // Bind/unbind column 42.
         exsr initcparms;
         ccol = c42col;
         if c42data <> *null;
           cdata = c42data;
           if     %parms > 208
              and %addr(c42atype) <> *null;
             catype = c42atype;
           endif;
           if     %parms > 209
              and %addr(c42len) <> *null;
             clen = c42len;
           endif;
           if     %parms > 210
              and %addr(c42scale) <> *null;
             cscale = c42scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 212;
         // Bind/unbind column 43.
         exsr initcparms;
         ccol = c43col;
         if c43data <> *null;
           cdata = c43data;
           if     %parms > 213
              and %addr(c43atype) <> *null;
             catype = c43atype;
           endif;
           if     %parms > 214
              and %addr(c43len) <> *null;
             clen = c43len;
           endif;
           if     %parms > 215
              and %addr(c43scale) <> *null;
             cscale = c43scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 217;
         // Bind/unbind column 44.
         exsr initcparms;
         ccol = c44col;
         if c44data <> *null;
           cdata = c44data;
           if     %parms > 218
              and %addr(c44atype) <> *null;
             catype = c44atype;
           endif;
           if     %parms > 219
              and %addr(c44len) <> *null;
             clen = c44len;
           endif;
           if     %parms > 220
              and %addr(c44scale) <> *null;
             cscale = c44scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 222;
         // Bind/unbind column 45.
         exsr initcparms;
         ccol = c45col;
         if c45data <> *null;
           cdata = c45data;
           if     %parms > 223
              and %addr(c45atype) <> *null;
             catype = c45atype;
           endif;
           if     %parms > 224
              and %addr(c45len) <> *null;
             clen = c45len;
           endif;
           if     %parms > 225
              and %addr(c45scale) <> *null;
             cscale = c45scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 227;
         // Bind/unbind column 46.
         exsr initcparms;
         ccol = c46col;
         if c46data <> *null;
           cdata = c46data;
           if     %parms > 228
              and %addr(c46atype) <> *null;
             catype = c46atype;
           endif;
           if     %parms > 229
              and %addr(c46len) <> *null;
             clen = c46len;
           endif;
           if     %parms > 230
              and %addr(c46scale) <> *null;
             cscale = c46scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 232;
         // Bind/unbind column 47.
         exsr initcparms;
         ccol = c47col;
         if c47data <> *null;
           cdata = c47data;
           if     %parms > 233
              and %addr(c47atype) <> *null;
             catype = c47atype;
           endif;
           if     %parms > 234
              and %addr(c47len) <> *null;
             clen = c47len;
           endif;
           if     %parms > 235
              and %addr(c47scale) <> *null;
             cscale = c47scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 237;
         // Bind/unbind column 48.
         exsr initcparms;
         ccol = c48col;
         if c48data <> *null;
           cdata = c48data;
           if     %parms > 238
              and %addr(c48atype) <> *null;
             catype = c48atype;
           endif;
           if     %parms > 239
              and %addr(c48len) <> *null;
             clen = c48len;
           endif;
           if     %parms > 240
              and %addr(c48scale) <> *null;
             cscale = c48scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 242;
         // Bind/unbind column 49.
         exsr initcparms;
         ccol = c49col;
         if c49data <> *null;
           cdata = c49data;
           if     %parms > 243
              and %addr(c49atype) <> *null;
             catype = c49atype;
           endif;
           if     %parms > 244
              and %addr(c49len) <> *null;
             clen = c49len;
           endif;
           if     %parms > 245
              and %addr(c49scale) <> *null;
             cscale = c49scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 247;
         // Bind/unbind column 50.
         exsr initcparms;
         ccol = c50col;
         if c50data <> *null;
           cdata = c50data;
           if     %parms > 248
              and %addr(c50atype) <> *null;
             catype = c50atype;
           endif;
           if     %parms > 249
              and %addr(c50len) <> *null;
             clen = c50len;
           endif;
           if     %parms > 250
              and %addr(c50scale) <> *null;
             cscale = c50scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 252;
         // Bind/unbind column 51.
         exsr initcparms;
         ccol = c51col;
         if c51data <> *null;
           cdata = c51data;
           if     %parms > 253
              and %addr(c51atype) <> *null;
             catype = c51atype;
           endif;
           if     %parms > 254
              and %addr(c51len) <> *null;
             clen = c51len;
           endif;
           if     %parms > 255
              and %addr(c51scale) <> *null;
             cscale = c51scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 257;
         // Bind/unbind column 52.
         exsr initcparms;
         ccol = c52col;
         if c52data <> *null;
           cdata = c52data;
           if     %parms > 258
              and %addr(c52atype) <> *null;
             catype = c52atype;
           endif;
           if     %parms > 259
              and %addr(c52len) <> *null;
             clen = c52len;
           endif;
           if     %parms > 260
              and %addr(c52scale) <> *null;
             cscale = c52scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 262;
         // Bind/unbind column 53.
         exsr initcparms;
         ccol = c53col;
         if c53data <> *null;
           cdata = c53data;
           if     %parms > 263
              and %addr(c53atype) <> *null;
             catype = c53atype;
           endif;
           if     %parms > 264
              and %addr(c53len) <> *null;
             clen = c53len;
           endif;
           if     %parms > 265
              and %addr(c53scale) <> *null;
             cscale = c53scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 267;
         // Bind/unbind column 54.
         exsr initcparms;
         ccol = c54col;
         if c54data <> *null;
           cdata = c54data;
           if     %parms > 268
              and %addr(c54atype) <> *null;
             catype = c54atype;
           endif;
           if     %parms > 269
              and %addr(c54len) <> *null;
             clen = c54len;
           endif;
           if     %parms > 270
              and %addr(c54scale) <> *null;
             cscale = c54scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 272;
         // Bind/unbind column 55.
         exsr initcparms;
         ccol = c55col;
         if c55data <> *null;
           cdata = c55data;
           if     %parms > 273
              and %addr(c55atype) <> *null;
             catype = c55atype;
           endif;
           if     %parms > 274
              and %addr(c55len) <> *null;
             clen = c55len;
           endif;
           if     %parms > 275
              and %addr(c55scale) <> *null;
             cscale = c55scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 277;
         // Bind/unbind column 56.
         exsr initcparms;
         ccol = c56col;
         if c56data <> *null;
           cdata = c56data;
           if     %parms > 278
              and %addr(c56atype) <> *null;
             catype = c56atype;
           endif;
           if     %parms > 279
              and %addr(c56len) <> *null;
             clen = c56len;
           endif;
           if     %parms > 280
              and %addr(c56scale) <> *null;
             cscale = c56scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 282;
         // Bind/unbind column 57.
         exsr initcparms;
         ccol = c57col;
         if c57data <> *null;
           cdata = c57data;
           if     %parms > 283
              and %addr(c57atype) <> *null;
             catype = c57atype;
           endif;
           if     %parms > 284
              and %addr(c57len) <> *null;
             clen = c57len;
           endif;
           if     %parms > 285
              and %addr(c57scale) <> *null;
             cscale = c57scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 287;
         // Bind/unbind column 58.
         exsr initcparms;
         ccol = c58col;
         if c58data <> *null;
           cdata = c58data;
           if     %parms > 288
              and %addr(c58atype) <> *null;
             catype = c58atype;
           endif;
           if     %parms > 289
              and %addr(c58len) <> *null;
             clen = c58len;
           endif;
           if     %parms > 290
              and %addr(c58scale) <> *null;
             cscale = c58scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 292;
         // Bind/unbind column 59.
         exsr initcparms;
         ccol = c59col;
         if c59data <> *null;
           cdata = c59data;
           if     %parms > 293
              and %addr(c59atype) <> *null;
             catype = c59atype;
           endif;
           if     %parms > 294
              and %addr(c59len) <> *null;
             clen = c59len;
           endif;
           if     %parms > 295
              and %addr(c59scale) <> *null;
             cscale = c59scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 297;
         // Bind/unbind column 60.
         exsr initcparms;
         ccol = c60col;
         if c60data <> *null;
           cdata = c60data;
           if     %parms > 298
              and %addr(c60atype) <> *null;
             catype = c60atype;
           endif;
           if     %parms > 299
              and %addr(c60len) <> *null;
             clen = c60len;
           endif;
           if     %parms > 300
              and %addr(c60scale) <> *null;
             cscale = c60scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 302;
         // Bind/unbind column 61.
         exsr initcparms;
         ccol = c61col;
         if c61data <> *null;
           cdata = c61data;
           if     %parms > 303
              and %addr(c61atype) <> *null;
             catype = c61atype;
           endif;
           if     %parms > 304
              and %addr(c61len) <> *null;
             clen = c61len;
           endif;
           if     %parms > 305
              and %addr(c61scale) <> *null;
             cscale = c61scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       if %parms > 307;
         // Bind/unbind column 62.
         exsr initcparms;
         ccol = c62col;
         if c62data <> *null;
           cdata = c62data;
           if     %parms > 308
              and %addr(c62atype) <> *null;
             catype = c62atype;
           endif;
           if     %parms > 309
              and %addr(c62len) <> *null;
             clen = c62len;
           endif;
           if     %parms > 310
              and %addr(c62scale) <> *null;
             cscale = c62scale;
           endif;
         endif;
         exsr bindcol;
       endif;

       return *on;

       begsr initcparms;
         ccol   = 0;
         cdata  = *null;
         catype = SQL_CHAR;
         clen   = 5;
         cscale = 0;
       endsr;

       begsr bindcol;
         if    ccol < 1
            or ccol > 999;
           GStatus = -102;
           return *off;
         endif;
         cbv = clen;
         if     cdata <> *null
            and (   catype = SQL_DECIMAL
                 or catype = SQL_NUMERIC);
             cbv = clen * 256 + cscale;
         endif;
         if cbv < 0;
           cbv = 0;
         endif;
         if     cbv < 1
            and (   catype = SQL_DEFAULT
                 or catype = SQL_CHAR);
           cbv = 1;
         endif;
         pcba = %addr(PcbField) + (ccol - 1) * 4;
         rtn = SqlBindCol( S_h(st)
                 : ccol
                 : catype : cdata
                 : cbv : pcba );
         if     rtn <> SQL_SUCCESS
            and rtn <> SQL_SUCCESS_WITH_INFO;
           GStatus = -999;
           return *off;
         endif;
         if cdata = *null;
           %subst(S_colstat(st):ccol:1) = ' ';
         else;
           %subst(S_colstat(st):ccol:1) = 'B';
         endif;
       endsr;

      /end-free
     p                 e


     p SqlsFetch       b                   export
     d SqlsFetch       pi              n
     d   handle                       5i 0 const
     d   cpos                        10    const options(*nopass)
     d   cposnum                      5i 0 const options(*nopass)

     d st              s              5i 0
     d orient          s                   like(SQLSMALLINT)
     d offset          s                   like(SQLINTEGER)
     d rtn             s                   like(SQLRETURN)
     d i               s             10i 0
     d pcbv            s             10i 0 based(pcbv@)

      /free

       GStatus = 0;

       st = handle;

       if    st < 1
          or st > CSqlsMaxCurs
          or not S_allocated(st);
         GStatus = -101;
         return *off;
       endif;

       orient = SQL_FETCH_NEXT;
       offset = 0;
       if %parms > 1;
         select;
         when cpos = '*FIRST';
           orient = SQL_FETCH_FIRST;
         when cpos = '*LAST';
           orient = SQL_FETCH_LAST;
         when cpos = '*PRIOR';
           orient = SQL_FETCH_PRIOR;
         when cpos = '*REL';
           orient = SQL_FETCH_RELATIVE;
           if %parms > 2;
             offset = cposnum;
           else;
             offset = 1;
           endif;
         endsl;
       endif;
       rtn = SqlFetchScroll(S_h(st):orient:offset);

       if rtn = SQL_NO_DATA_FOUND;
         GStatus = 100;
       endif;

       if    rtn = SQL_SUCCESS
          or rtn = SQL_SUCCESS_WITH_INFO
          or rtn = SQL_NO_DATA_FOUND;

         for i = 1 to 999;
           if    %subst(S_colstat(st):i:1) = 'B'
              or %subst(S_colstat(st):i:1) = 'V'
              or %subst(S_colstat(st):i:1) = 'X'
              or %subst(S_colstat(st):i:1) = 'S';
             if rtn = SQL_NO_DATA_FOUND;
               %subst(S_colstat(st):i:1) = 'X';
             else;
               pcbv@ = %addr(PcbField) + (i - 1) * 4;
               select;
               when pcbv = SQL_NULL_DATA;
                 %subst(S_colstat(st):i:1) = 'X';
               when pcbv = SQL_NTS;
                 %subst(S_colstat(st):i:1) = 'S';
               other;
                 %subst(S_colstat(st):i:1) = 'V';
               endsl;
             endif;
           endif;
         endfor;

         return *on;

       endif;

       GStatus = -999;
       return *off;

      /end-free
     p                 e


     p SqlsUnbindAllCols...
     p                 b                   export
     d SqlsUnbindAllCols...
     d                 pi              n
     d   handle                       5i 0 const

     d st              s              5i 0
     d rtn             s                   like(SQLRETURN)

      /free

       GStatus = 0;

       st = handle;

       if    st < 1
          or st > CSqlsMaxCurs
          or not S_allocated(st);
         GStatus = -101;
         return *off;
       endif;

       rtn = SqlFreeStmt(S_h(st):SQL_UNBIND);

       if    rtn = SQL_SUCCESS
          or rtn = SQL_SUCCESS_WITH_INFO;
         S_colstat(st) = '';
         return *on;
       endif;

       GStatus = -999;
       return *off;

      /end-free
     p                 e


     p SqlsColIsNull   b                   export
     d SqlsColIsNull   pi              n
     d   handle                       5i 0 const
     d   col                          5i 0 const

     d st              s              5i 0

      /free

       GStatus = 0;

       st = handle;

       if    st < 1
          or st > CSqlsMaxCurs
          or not S_allocated(st);
         GStatus = -101;
         return *on;
       endif;

       if    col < 1
          or col > 999;
         GStatus = -102;
         return *on;
       endif;

       if    %subst(S_colstat(st):col:1) = 'X'
          or (    %subst(S_colstat(st):col:1) <> 'V'
              and %subst(S_colstat(st):col:1) <> 'S');
         return *on;
       endif;

       GStatus = -999;
       return *off;

      /end-free
     p                 e


     p SqlsColIsNTS    b                   export
     d SqlsColIsNTS    pi              n
     d   handle                       5i 0 const
     d   col                          5i 0 const

     d st              s              5i 0

      /free

       GStatus = 0;

       st = handle;

       if    st < 1
          or st > CSqlsMaxCurs
          or not S_allocated(st);
         GStatus = -101;
         return *off;
       endif;

       if    col < 1
          or col > 999;
         GStatus = -102;
         return *off;
       endif;

       if %subst(S_colstat(st):col:1) = 'S';
         return *on;
       endif;

       GStatus = -999;
       return *off;

      /end-free
     p                 e


     p SqlsCloseConn   b                   export
     d SqlsCloseConn   pi              n
     d   conn                         5i 0 const options(*nopass)

     d cn              s              5i 0

      /free

       GStatus = 0;

       if %parms > 0;
         cn = conn;
       else;
         cn = 1;
       endif;

       if    cn < 1
          or cn > CSqlsMaxConn;
         GStatus = -999;
         return *off;
       endif;

       if L_CloseConn(cn);
         return *on;
       endif;

       if GStatus = 0;
         GStatus = -999;
       endif;
       return *off;

      /end-free
     p                 e


     p SqlsCloseCurs   b                   export
     d SqlsCloseCurs   pi              n
     d   handle                       5i 0 const

     d st              s              5i 0

      /free

       GStatus = 0;

       st = handle;

       if    st < 1
          or st > CSqlsMaxCurs
          or not S_allocated(st);
         GStatus = -101;
         return *off;
       endif;

       if L_FreeStmt(st);
         return *on;
       endif;

       if GStatus = 0;
         GStatus = -999;
       endif;

       return *off;

      /end-free
     p                 e


     p SqlsStatusAsChar...
     p                 b                   export
     d SqlsStatusAsChar...
     d                 pi             4

     d s               s                   like(GStatus)
     d sc              s                   like(SqlsStatusAsChar)

      /free

       if GStatus < 0;
         s = 0 - GStatus;
       else;
         s = GStatus;
       endif;
       evalr sc = %editc(s:'X');
       if GStatus < 0;
         %subst(sc:1:1) = '-';
       endif;

       return sc;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModCI       b                   export
     dI_RlsModCI       pi

     d cn              s              5i 0

      /free

       for cn = 1 to CSqlsMaxConn;
         L_CloseConn(cn);
       endfor;

       SqlFreeEnv(E_.h);
       E_.allocated = *off;

       GStatus = 0;

       return;

      /end-free
     p                 e


       // ----- Implementation - Local


     pL_ConnIsActive   b
     dL_ConnIsActive   pi              n
     d  conn                          5i 0 const

     d rtn             s                   like(SQLRETURN)

      /free

       return     conn >= 1
              and conn <= CSqlsMaxConn
              and C_allocated(conn)
              and (   C_connrtn(conn) = SQL_SUCCESS
                   or C_connrtn(conn) = SQL_SUCCESS_WITH_INFO);

      /end-free
     p                 e


     pL_CheckConn      b
     dL_CheckConn      pi             5i 0
     d  conn                          5i 0 const
     d  allocstmt                      n   const options(*nopass)

     d st              s              5i 0
     d rtn             s                   like(SQLRETURN)

      /free

       if not C_allocated(conn);
         // Allocate the connection.

         if not L_CheckEnv();
           if GStatus = 0;
             GStatus = -999;
           endif;
           return -1;
         endif;

         rtn = SqlAllocConnect(E_.h:C_h(conn));
         if rtn <> SQL_SUCCESS;
           GStatus = -999;
           return -1;
         endif;

         C_connrtn(conn) = SQL_INVALID_HANDLE;

         C_allocated(conn) = *on;

       endif;

       if     C_connrtn(conn) <> SQL_SUCCESS
          and C_connrtn(conn) <> SQL_SUCCESS_WITH_INFO;
         // Connect to the database.

         rtn = SqlSetConnectAttr(
               C_h(conn)
             : SQL_ATTR_DBC_SYS_NAMING
             : SQL_TRUE : 0);

         if     rtn <> SQL_SUCCESS
            and rtn <> SQL_SUCCESS_WITH_INFO;
           C_connrtn(conn) = rtn;
           GStatus = -999;
           return -1;
         endif;

         C_connrtn(conn) = SqlConnect(
               C_h(conn)
             : '*LOCAL' : SQL_NTS
             : *NULL : SQL_NTS
             : *NULL : SQL_NTS);

         if     C_connrtn(conn) <> SQL_SUCCESS
            and C_connrtn(conn) <> SQL_SUCCESS_WITH_INFO;
           if     L_CliErr(0:C_h(conn):SQL_NULL_HSTMT)
              and CliErr.SQLSTATE = '08002';
             // Ignore this one.
             //GStatus = -300;
           else;
             GStatus = -999;
             return -1;
           endif;
         endif;

       endif;

       if     %parms > 1
          and allocstmt;
         // Allocate a new statement for this connection.

         st = 1;
         dow     st <= %elem(S_allocated)
             and S_allocated(st);
           st = st + 1;
         enddo;
         if st > %elem(S_allocated);
           GStatus = -190;
           return -1;
         endif;

         if SqlAllocStmt(C_h(conn):S_h(st)) <> SQL_SUCCESS;
           GStatus = -999;
           return -1;
         endif;

         if SqlSetStmtAttr(
               S_h(st)
             : SQL_ATTR_CURSOR_SCROLLABLE
             : SQL_TRUE : 0) <> SQL_SUCCESS;
           SqlFreeStmt(S_h(st):SQL_DROP);
           GStatus = -999;
           return -1;
         endif;

         S_allocated(st) = *on;
         S_conn(st) = conn;
         S_colstat(st) = '';

         return st;

       endif;

       return 0;

      /end-free
     p                 e


     pL_CloseConn      b
     dL_CloseConn      pi              n
     d  conn                          5i 0 const

     d st              s              5i 0

      /free

       if not C_allocated(conn);
         return *on;
       endif;

       for st = 1 to CSqlsMaxCurs;
         if     S_allocated(st)
            and S_conn(st) = conn;
           L_FreeStmt(st);
         endif;
       endfor;

       SqlDisconnect(C_h(conn));
       SqlFreeConnect(C_h(conn));

       C_allocated(conn) = *off;
       C_connrtn(conn) = SQL_INVALID_HANDLE;

       return *on;

      /end-free
     p                 e


     pL_FreeStmt       b
     dL_FreeStmt       pi              n
     d  st                            5i 0 const

      /free

       if not S_allocated(st);
         return *on;
       endif;

       SqlFreeStmt(S_h(st):SQL_DROP);
       S_allocated(st) = *off;
       S_conn(st) = 0;
       S_colstat(st) = '';

       return *on;

      /end-free
     p                 e


     pL_CheckEnv       b
     dL_CheckEnv       pi              n

     d rtn             s                   like(SQLRETURN)

      /free

       if E_.allocated;
         return *on;
       endif;

       E_.allocated = SqlAllocEnv(E_.h) = SQL_SUCCESS;

       if E_.allocated;

         rtn = SQL_SUCCESS;

         rtn = SqlSetEnvAttr(
              E_.h
            : SQL_ATTR_ENVHNDL_COUNTER
            : SQL_TRUE :  0);

         //if rtn = SQL_SUCCESS;
         //  rtn = SqlSetEnvAttr(
         //       E_.h
         //   : SQL_ATTR_SERVER_MODE
         //   : SQL_TRUE :  0);
         //endif;

         if rtn <> SQL_SUCCESS;
           if     L_CliErr(E_.h:SQL_NULL_HDBC:SQL_NULL_HSTMT)
              and CliErr.SQLSTATE = 'HY010';
             // Ignore this one.
           else;
             GStatus = -201;
             return *off;
           endif;
         endif;

       else;
         GStatus = -200;
         return *off;
       endif;

       return *on;

      /end-free
     p                 e


     pL_CliErr         b
     dL_CliErr         pi              n
     d  henv                               like(SQLHENV) const
     d  hdbc                               like(SQLHDBC) const
     d  hstmt                              like(SQLHSTMT) const

     d sqlstate        s              6
     d sqlcode         s                   like(SQLINTEGER)
     d mbuf            s            513
     d ml              s                   like(SQLSMALLINT)

      /free

       if SqlError(  henv : hdbc : hstmt
            : sqlstate
            : sqlcode
            : mbuf : %size(mbuf) : ml) = SQL_SUCCESS;

         clear CliErr;
         CliErr.SQLSTATE = %subst(sqlstate:1:%len(CliErr.SQLSTATE));
         CliErr.SQLCODE  = sqlcode;
         if ml > 0;
           CliErr.msg = %subst(mbuf:1:ml);
         endif;

         return *on;

       endif;

       return *off;

      /end-free
     p                 e

