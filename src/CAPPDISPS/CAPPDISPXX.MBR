
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module XX for *SRVPGM CAPPDISP

       // Service Program: Common App Services / Display
       // Module         : Miscellaneous


      /DEFINE CAPPDISP_MODULE
      /DEFINE CAPPDISP_CAPPDISPXX

      /include CAPPDISPS,INCL__MODH


      /include CAPPDISPS,INCL_XX

      /include CAPPDISPS,INCL__XX
      /include CAPPDISPS,INCL__HD

      /include CAPPDISPS,INCL__MODD


       // ----- Implementation


     p DspHelp         b                   export
     d DspHelp         pi
     d   context                     20    const
     d   text                        60    const dim(30) options(*nopass)
     d   wdwrow                       2  0 const         options(*nopass)
     d   wdwcol                       3  0 const         options(*nopass)

      /free

       if %parms > 3;
         I_DspHelp(context:text:wdwrow:wdwcol);
       elseif %parms > 2;
         I_DspHelp(context:text:wdwrow);
       elseif %parms > 1;
         I_DspHelp(context:text);
       else;
         I_DspHelp(context);
       endif;

       return;

      /end-free
     p                 e


     p ShowDspMsgs     b                   export
     d ShowDspMsgs     pi

      /free

       I_ShowDspMsgs();

       return;

      /end-free
     p                 e


     p PresentConfWdw  b                   export
     d PresentConfWdw  pi              n
     d   text                        40    const
     d   dftyes                        n   const options(*nopass)

      /free

       if %parms > 1;
         return I_PresentConfWdw(text:dftyes);
       else;
         return I_PresentConfWdw(text);
       endif;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModXX       b                   export
     dI_RlsModXX       pi

      /free

       return;

      /end-free
     p                 e

