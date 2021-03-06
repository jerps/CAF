
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_AM)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_AM


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module AM: Application Messages


       // Contains application messages, subsystem AM (AppMenu).

       // Use "RtvAMsgAM" to retrieve a message for this subsystem.

       // Each message starts with it's id, followed by a colon and a space.
       // A message id consists of 3 letters and 4 digits.
       // The first two letters is the subsystem id.
       // The third letter indicates the message's severity as follows:
       //   F = Fatal
       //   W = Warning
       //   I = Info
       // The four digits actually identify each message and must be unique
       // among all messages defined in this module.

       // Each message text is identified with a 4-digit number. Parameter
       // "sev" indicates the severity and should be "F", "W" or "I" (this
       // is not checked). Use constants "CAmsFatal", "CAmsWarning" or
       // "CAmsInfo". The returned message consists of the subsystem id,
       // which is the same for all messages in this module, appended
       // with the character given with parameter "sev", appended with
       // the message text.

       // Constants "CAmsFatal", "CAmsWarning" and "CAmsInfo" are defined
       // in CAPPBASES/INCL_DEFS.


      /include CAPPSSAMS,INCL_DEFS


       // ----- Prototypes

       // RtvAMsgAM - Retrieve Application Message, subsystem AM
       // Retrieve the application message identified with "id".
       // Return blanks if the message could not be found.
       // Optional parameter "sev" specifies the severity of the
       // message which should be "CAmsFatal", "CAmsWarning" or
       // "CAmsInfo". If it is not given, or *OMITted, or blank,
       // then the severity defaults to "CAmsInfo".
       // Optional parameters "subst1", "subst2", ... are used to
       // provide substitution texts. Substitution marker "%1" in
       // the message text is replaced with the contents of "subst1",
       // etc. Procedure "CSYSBASE/SubstText" is used to substitute
       // the markers.
     d RtvAMsgAM       pr           200    extproc('RtvAMsgAM')
     d   id                           4  0 const
     d   sev                          1    const         options(*nopass:*omit)
     d   subst1                     200    const varying options(*nopass)
     d   subst2                     200    const varying options(*nopass)
     d   subst3                     200    const varying options(*nopass)
     d   subst4                     200    const varying options(*nopass)
     d   subst5                     200    const varying options(*nopass)
     d   subst6                     200    const varying options(*nopass)
     d   subst7                     200    const varying options(*nopass)
     d   subst8                     200    const varying options(*nopass)
     d   subst9                     200    const varying options(*nopass)

