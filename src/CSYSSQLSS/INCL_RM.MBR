
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSSQLS_INCL_RM)
      /EOF
      /ENDIF
      /DEFINE CSYSSQLS_INCL_RM


       // INCLUDE: *SRVPGM CSYSSQLS

       // Module RM: Resource Management


       // IMPORTANT!

       // SQL CLI is not used in Server Mode. This brings some issues,
       // see: "http://www-03.ibm.com/systems/power/software/i/db2/...
       // support/tips/clifaq.html#header_3".

       // This service program is activated in a named activation group,
       // "CSYSSQLS". This is because the resources used by SQL CLI
       // (module CI) are also scoped to the job. And because only one
       // connection is allowed to the local database in one job, this
       // same connection must be shared by different programs within
       // the same job. It's not possible to access an existing CLI data-
       // base connection from an activation group other than the acti-
       // vation group that allocated this connection.

       // The above does not apply when "Server Mode" is used.

       // Programs should only release this service program (using
       // "RlsSpCSYSSQLS") if it's not needed anymore by a program that
       // is still active in the same job.

       // Be sure to release resources such as open cursors as soon as
       // they are not needed anymore. Do not release a resource if it's
       // still needed by another program in the same job.

       // NOTE:
       // If a program compiled with activation group *NEW is the first one
       // in the call stack that executes an SQL statement using this service
       // program, and it ends without releasing this service program (or the
       // connection), and then it's called again (third time on V5R1, second
       // time on V7R1), exception MCH3601 is generated when it executes an
       // SQL statement. This only seems to happen with the program that's the
       // first one in the call stack that uses this service program. If the
       // same program (or another but this is not tested) further in the call
       // stack executes SQL using this service program (so there is an earlier
       // program in the call stack executing SQL using this service program)
       // and it ends and then immediately is called again (so there still is
       // the first program in the stack) then it works ok. However, if the
       // first program ends and it releases this service program (or just the
       // connection but this is not tested), and then it's called again (and
       // this repeated multiple times) then no exception is generated. It's
       // not clear why this happens, but it does, and only (it seems) with the
       // program that is first on the call stack using this service program.
       // So, to circumvent this problem, make sure to release this service
       // program if the program using it is the first one on the call stack
       // using this service program (and no other active program in the same
       // job is using it). This problem is not an issue when using Server Mode.
       // Also, in batch jobs this is probaby not an issue because the job is
       // normally ended when the first program in the stack is ended.


      /include CSYSSQLSS,INCL_DEFS


       // ----- Prototypes

       // RlsSpCSYSSQLS - Release Service Program CSYSSQLS
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this service program, e.g. when the
       // program using this service program exits. If it's not called then
       // these resources are automatically released when the activation
       // group in which the service program has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     d RlsSpCSYSSQLS   pr                  extproc('RlsSpCSYSSQLS')

