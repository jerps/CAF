
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL__MO)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL__MO


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module MO: Menu Operations

       // Internal


       // ----- Prototypes

       // Read data area CAPPSSAMA0 with *LOCK, and return the version
       // counter. If given, parameter "curbin" returns the current bin
       // (0 or 1).
     dI_SdaReadLock    pr             8s 0
     d  curbin                        1s 0       options(*nopass)

       // Write data area CAPPSSAMA0.
       // Update and UNLOCK the data area.
       // If parameters "vcounter" and/or "vreload" are given the data
       // area's version counter in pos. 1-8 and/or the "reload" version
       // in pos. 9-16 are updated with the given values. Also, if par.
       // "vcounter" is given, the current bin number in pos. 19 is
       // flipped, and the current user is written to pos. 21-30.
       // If no parameters are given the data area is only unlocked; no
       // data is written.
     dI_SdaWrite       pr
     d  vcounter                      8s 0 const options(*nopass)
     d  vreload                       8s 0 const options(*nopass)

       // I_SdaCurBin - Get Current Bin
       // Return the current bin number, 0 or 1, of data area CAPPSSAMA0.
     dI_SdaCurBin      pr             1s 0 extproc('I_GetCurBin')

       // I_RlsModMO - Release Module MO
       // Release all resources (such as Open Data Paths and dynamically
       // allocated memory) used by this module. If it's not called then
       // these resources are automatically released when the activation
       // group in which the module has been activated is released.
       // Use this procedure to ensure that these resources are *properly*
       // released. If they are automatically released it's possible that
       // not all resources are completely and properly released.
     dI_RlsModMO       pr                  extproc('I_RlsModMO')

