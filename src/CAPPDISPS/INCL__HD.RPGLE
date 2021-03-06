
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPDISP_INCL__HD)
      /EOF
      /ENDIF
      /DEFINE CAPPDISP_INCL__HD


       // INCLUDE: *SRVPGM CAPPDISP

       // Module HD: Handle Display

       // Internal


       // ----- Prototypes

       // I_DspHelp - Display Help
     dI_DspHelp        pr                  extproc('I_DspHelp')
     d  context                      20    const
     d  text                         60    const dim(30) options(*nopass)
     d  wdwrow                        2  0 const         options(*nopass)
     d  wdwcol                        3  0 const         options(*nopass)

       // I_SelectItem - Select Item
       // Present a list of "items" in a subfile within a window. Each item is
       // associated with a "key". The user is allowed to select one item by
       // pressing ENTER. The key of the selected item is passed back to the
       // caller with parameter "selkey". Return *on if the user selected an
       // item; "selkey" contains the selected key. Return *off if nothing
       // has been selected (i.e. the user pressed F12 or F4); in this case
       // "selkey" contains *allx'00'. Up to 9999 items are supported.
       // Parameter "items" contains the items that are presented to the user
       // and parameter "keys" contains the keys for all items (which are
       // returned through "selkey"). If "keys" is not given then the keys
       // are assumed to be the same as "items".
       // To disable selection of a specific item, set it's corresponding key
       // to *allx'00'.
     dI_SelectItem     pr              n   extproc('I_SelectItem')
     d  wdwrow                        2  0 const options(*omit)
     d  wdwcol                        3  0 const options(*omit)
     d  wdwtitle                     40    const
     d  selkey                       40
     d  item#                         4  0 const
     d  items                          *   const
     d  keys                           *   const options(*nopass)

       // I_ShowDspMsgs - Show "DspMsgs"
       // Present a window with all (error)messages in "DspMsg" and
       // "DspMsgList", which are defined in and exported from *SRVPGM
       // CAPPBASE.
     dI_ShowDspMsgs    pr                  extproc('I_ShowDspMsg')

       // PresentConfWdw - Present Confirmation Window
       // Present a confirmation window, showing "text". Return *on if the
       // user entered "Y", else return *off.
     dI_PresentConfWdw...
     d                 pr              n   extproc('I_PresentConfWdw')
     d  text                         40    const
     d  dftyes                         n   const options(*nopass)

       // I_RlsModHD - Release Module HD
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this module. If it's not called then
       // these resources are automatically released when the activation
       // group in which the module has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     dI_RlsModHD       pr                  extproc('I_RlsModHD')

