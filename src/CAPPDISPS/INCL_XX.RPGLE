
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPDISP_INCL_XX)
      /EOF
      /ENDIF
      /DEFINE CAPPDISP_INCL_XX


       // INCLUDE: *SRVPGM CAPPDISP

       // Module XX: Miscellaneous

       // Do NOT include INCL_XX explicitly; use INCL_API instead.
       // The artifacts contained in module XX are not categorized yet
       // and therefore susceptible of being moved to another module.


      /include CAPPDISPS,INCL_DEFS


       // ----- Prototypes

       // DspHelp - Display Help
       // Display the help text, determined by "context", in a window.
       // The "context" parameter is used as the key for file CAPPDISPF1
       // which contains the help texts. At the top is the help text
       // shown for "context' if not blank. Below comes the help text
       // of context '' (blank) which is always shown independently of
       // "context". Optional parameter "text" contains help text that
       // is shown at the top, before "context", if "text" is given.
       // All non-blank lines contained in "text" will be shown at the
       // beginning of all help text.
       // If not blank then parameter "context" will be part of the
       // help text header.
       // The top-left location of the window is given with parameters
       // "row" and "column", which are optional. If not given, or the
       // value is 0, then the current cursor row and/or column is used
       // which is read from the workstation infds (WSI). For this to
       // work the WSI@ pointer exported from service program CSYSBASE
       // has to be set to the address of the program's workstation
       // infds (if not the results will be unpredictable).
     d DspHelp         pr                  extproc('DspHelp')
     d   context                     20    const
     d   text                        60    const dim(30) options(*nopass)
     d   wdwrow                       2  0 const         options(*nopass)
     d   wdwcol                       3  0 const         options(*nopass)

       // ShowDspMsgs - Show "DspMsgs"
       // Present a window with all (error)messages in "DspMsg" and
       // "DspMsgList", which are defined in and exported from *SRVPGM
       // CAPPBASE.
     d ShowDspMsgs     pr                  extproc('ShowDspMsgs')

       // PresentConfWdw - Present Confirmation Window
       // Present a confirmation window, showing "text" and a field where
       // the user can enter "Y" or "N" ("N" is the default), and then
       // must press enter to continue. Return *on if the user entered "Y",
       // else return *off.
       // If "dftyes" is given and is *on then the default is "Y".
     d PresentConfWdw  pr              n   extproc('PresentConfWdw')
     d   text                        40    const
     d   dftyes                        n   const options(*nopass)

