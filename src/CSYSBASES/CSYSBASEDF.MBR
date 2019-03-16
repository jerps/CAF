
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module DF for *SRVPGM CSYSBASE

       // Service Program: Common System Services / Base
       // Module         : DisplayFile


      /DEFINE CSYSBASE_MODULE
      /DEFINE CSYSBASE_CSYSBASEDF

      /include CSYSBASES,INCL__MODH


      /include CSYSBASES,INCL_DF

      /include CSYSBASES,INCL__DF

      /include CSYSBASES,INCL__MODD


       // ----- OS/400 API Defs

       // API QsnRtvMod
     d QsnRtvMod       pr                  extproc('QsnRtvMod')
     d   dspmod                       1
     d   envh                        10i 0 const
     d   apierr                                  like(OS4Error)

       // API QsnQryModSup
     d QsnQryModSup    pr                  extproc('QsnQryModSup')
     d   dspmod                       1    const
     d   modind                       1
     d   envh                        10i 0 const
     d   apierr                                  like(OS4Error)


       // ----- Implementation


     p KeyPressed      b                   export
     d KeyPressed      pi              n
     d   scancode                     1    const

      /free

       return     WSI@ <> *null
              and scancode = WSI.scancode;

      /end-free
     p                 e


     p GetCursRow      b                   export
     d GetCursRow      pi             2  0

      /free

       if WSI@ = *null;
         return 1;
       endif;
       return %div(WSI.cursrc:256);

      /end-free
     p                 e


     p GetCursCol      b                   export
     d GetCursCol      pi             3  0

      /free

       if WSI@ = *null;
         return 1;
       endif;
       return %rem(WSI.cursrc:256);

      /end-free
     p                 e


     p GetWCursRow     b                   export
     d GetWCursRow     pi             2  0

      /free

       if WSI@ = *null;
         return 1;
       endif;
       return %div(WSI.wcursrc:256);

      /end-free
     p                 e


     p GetWCursCol     b                   export
     d GetWCursCol     pi             3  0

      /free

       if WSI@ = *null;
         return 1;
       endif;
       return %rem(WSI.wcursrc:256);

      /end-free
     p                 e


     p IsDspModeWide   b                   export
     d IsDspModeWide   pi              n

     d dspmod          s              1

      /free

       reset OS4Error;
       QsnRtvMod(dspmod:0:OS4Error);

       return     OS4Error.bavl = 0
              and dspmod = '4';

      /end-free
     p                 e


     p IsDspModeWideSupported...
     p                 b                   export
     d IsDspModeWideSupported...
     d                 pi              n

     d modind          s              1

      /free

       reset OS4Error;
       QsnQryModSup('4':modind:0:OS4Error);

       return     OS4Error.bavl = 0
              and modind = '1';

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModDF       b                   export
     dI_RlsModDF       pi

      /free

       return;

      /end-free
     p                 e

