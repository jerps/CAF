
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_API)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_API


       // INCLUDE: *SRVPGM CAPPBASE

       // API


       // Base

       // Provides base functions for applications.

       // Service programs which provide application functionality are based
       // on this serviceprogram (which must appear in the binding directory).
       // These service programs may have a designated two-letter "subsystem
       // id" (although not strictly necessary) which is unique for all service
       // programs. This seperates functionality into different "subsystems",
       // where each subsystem is identified with an id and is implemented with
       // one service program. The subsystem id is necessary if the service
       // program has messages that are defined in module AM (Application
       // Messages). When these messages are retrieved with "RtvAMsgXX" (where
       // XX is the subsystem id) then the retrieved message is prefixed with
       // this subsystem id.

       // The subsystem id for each such service program is defined as a
       // constant in INCL_DEFS.

       // This serviceprogram has subsystem id "AB" (AppBase) and thus can not
       // be used as a subsystem id.


      /include CAPPBASES,INCL_DEFS
      /include CAPPBASES,INCL_PT
      /include CAPPBASES,INCL_IR
      /include CAPPBASES,INCL_MS
      /include CAPPBASES,INCL_XX
      /include CAPPBASES,INCL_VA
      /include CAPPBASES,INCL_AM
      /include CAPPBASES,INCL_RM

