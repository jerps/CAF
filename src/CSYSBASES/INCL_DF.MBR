
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_DF)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_DF


       // INCLUDE: *SRVPGM CSYSBASE

       // Module DF: DisplayFile


       // IMPORTANT:

       // To use the display functions in this module, it is mandatory
       // to set the exported field "WSI@" to the address of the work-
       // station information data structure (INFDS) of the display file
       // that is defined in the client program.


      /include CSYSBASES,INCL_DEFS


       // ----- Constants

       // Display Attribute Codes
     dCDacNormal       c                   x'20'
     dCDacRevImg       c                   x'21'
     dCDacHighInt      c                   x'22'
     dCDacHighIntRi    c                   x'23'
     dCDacUscore       c                   x'24'
     dCDacUscoreRi     c                   x'25'
     dCDacUscoreHi     c                   x'26'
     dCDacNonDisplay   c                   x'27'
     dCDacBlink        c                   x'28'

       // Key Scancodes
     d KsF01           c                   x'31'
     d KsF02           c                   x'32'
     d KsF03           c                   x'33'
     d KsF04           c                   x'34'
     d KsF05           c                   x'35'
     d KsF06           c                   x'36'
     d KsF07           c                   x'37'
     d KsF08           c                   x'38'
     d KsF09           c                   x'39'
     d KsF10           c                   x'3A'
     d KsF11           c                   x'3B'
     d KsF12           c                   x'3C'
     d KsF13           c                   x'B1'
     d KsF14           c                   x'B2'
     d KsF15           c                   x'B3'
     d KsF16           c                   x'B4'
     d KsF17           c                   x'B5'
     d KsF18           c                   x'B6'
     d KsF19           c                   x'B7'
     d KsF20           c                   x'B8'
     d KsF21           c                   x'B9'
     d KsF22           c                   x'BA'
     d KsF23           c                   x'BB'
     d KsF24           c                   x'BC'
     d KsClear         c                   x'BD'
     d KsEnter         c                   x'F1'
     d KsHelp          c                   x'F3'
     d KsPageUp        c                   x'F4'
     d KsPageDown      c                   x'F5'
     d KsPrint         c                   x'F6'
     d KsRecBackspace  c                   x'F8'
     d KsAutoEnter     c                   x'3F'


       // ----- Data Structures

       // Workstation Information
       // Note: programs using this data structure must set pointer
       //       WSI@ - which is exported from this service program -
       //       to the address of WSI in the program.
     d WSI             ds                  qualified
      /IF DEFINED(CSYSBASE_CSYSBASEDF)
     d                                     based(WSI@)
      /ENDIF

         // Content flag bits:
         //   1: Cancel-read indicator
         //      0 = The cancel-read operation did not cancel the read request.
         //      1 = The cancel-read operation canceled the read request.
         //   2: Data-returned indicator.
         //      0 = The cancel-read operation did not change the contents of
         //          the input buffer.
         //      1 = The cancel-read operation placed the data from the
         //          read-with-no-wait operation into the input buffer.
         //   3: Command key indicator.
         //      0 = Conditions for setting this indicator did not occur.
         //      1 = The Print, Help, Home, Roll Up, Roll Down, or Clear
         //          key was pressed. The key is enabled with a DDS keyword,
         //          but without a response indicator specified.
         //   4-16: Reserved.
     d   cfbits              367    368

         // Key scancode (AID byte).
     d   scancode            369    369

         // Cursor location (row/column)
     d   cursrc              370    371i 0

         // Actual data length (length of the processed record format)
     d   datalen             372    375i 0

         // Subfiles: Relative Record No (last subfile updated)
     d   srrn                376    377i 0

         // Subfiles: First RRN of page (subfile in upper screen area)
     d   sfrrn               378    379i 0

         // Subfiles: Number of records (all subfiles)
     d   snumrecs            380    381i 0

         // Cursor location within active window (row/column)
     d   wcursrc             382    383i 0

         // Major return code:
         //   00: Operation completed successfully.
         //   02: Input operation completed successfully, but job is
         //       being canceled (controlled).
         //   03: Input operation completed successfully, but no data
         //       received.
         //   04: Output exception.
         //   08: Device already acquired.
         //   11: Read from invited devices was not successful.
         //   34: Input exception.
         //   80: Permanent server or file error.
         //   81: Permanent session or device error.
         //   82: Acquire or open operation failed.
         //   83: Recoverable session or device error.
     d   rcmajor             401    402

         // Minor return code.
     d   rcminor             403    404


      /IF DEFINED(CSYSBASE_CSYSBASEDF)
     d WSI@            s               *   export inz(*null)
      /ELSE
     d WSI@            s               *   import
      /ENDIF


       // ----- Prototypes

       // KeyPressed - Key Pressed
       // Return *on if the scancode in the workstation infds (WSI.scancode)
       // matches the given scancode, else return *off. Use one of the
       // scancode constants (Ks*).
       // Example:
       //   if KeyPressed(KsF3);
       //      return;
       //   endif;
     d KeyPressed      pr              n   extproc('KeyPressed')
     d   scancode                     1    const

       // GetCursRow - Get Cursor Row
       // Return the cursor row location from the workstation infds
       // (WSI.cursrc).
     d GetCursRow      pr             2  0 extproc('GetCursRow')

       // GetCursCol - Get Cursor Column
       // Return the cursor column location from the workstation infds
       // (WSI.cursrc).
     d GetCursCol      pr             3  0 extproc('GetCursCol')

       // GetWCursRow - Get Window Cursor Row
       // Return the cursor row location within the active window from
       // the workstation infds (WSI.wcursrc).
     d GetWCursRow     pr             2  0 extproc('GetWCursRow')

       // GetWCursCol - Get Window Cursor Column
       // Return the cursor column location within the active window from
       // the workstation infds (WSI.wcursrc).
     d GetWCursCol     pr             3  0 extproc('GetWCursCol')

       // IsDspModeWide - Is Display Mode Wide
       // Return *on if the current display mode is wide (132 x 27),
       // else return *off.
     d IsDspModeWide   pr              n   extproc('IsDspModeWide')

       // IsDspModeWideSupported - Is Display Mode Wide Supported
       // Return *on if display mode wide  (132 x 27) is supported,
       // else return *off.
     d IsDspModeWideSupported...
     d                 pr              n   extproc('IsDspModeWideSupported')

