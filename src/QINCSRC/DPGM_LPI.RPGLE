
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


     p L_SetErr        b
     d L_SetErr        pi
     d   msg                        130    const
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

     d i               s             10i 0

      /free

       Err.e = *on;
       DspMsg = msg;
       Err.flds(*) = '';
       i = 0;
       if     %parms > 1
          and fld1 <> '';
         i = i + 1;
         Err.flds(i) = fld1;
       endif;
       if     %parms > 2
          and fld2 <> '';
         i = i + 1;
         Err.flds(i) = fld2;
       endif;
       if     %parms > 3
          and fld3 <> '';
         i = i + 1;
         Err.flds(i) = fld3;
       endif;
       if     %parms > 4
          and fld4 <> '';
         i = i + 1;
         Err.flds(i) = fld4;
       endif;
       if     %parms > 5
          and fld5 <> '';
         i = i + 1;
         Err.flds(i) = fld5;
       endif;
       if     %parms > 6
          and fld6 <> '';
         i = i + 1;
         Err.flds(i) = fld6;
       endif;
       if     %parms > 7
          and fld7 <> '';
         i = i + 1;
         Err.flds(i) = fld7;
       endif;

       return;

      /end-free
     p                 e


     p L_SetErrQdsDs   b
     d L_SetErrQdsDs   pi
     d   qds                      30000          options(*varsize)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

     d f               s                   like(fld1)
     d i               s             10i 0
     d p               s             10i 0

      /free

       Err.e = *on;
       DspMsg = %subst(qds:3:200);
       Err.flds(*) = '';
       i = 0;
       for p = 0 to 8;
         f = %subst(qds:203+12*p:12);
         if f <> '';
           i = i + 1;
           Err.flds(i) = f;
         endif;
       endfor;
       if     %parms > 1
          and fld1 <> '';
         f = fld1;
         exsr addf;
       endif;
       if     %parms > 2
          and fld2 <> '';
         f = fld2;
         exsr addf;
       endif;
       if     %parms > 3
          and fld3 <> '';
         f = fld3;
         exsr addf;
       endif;
       if     %parms > 4
          and fld4 <> '';
         f = fld4;
         exsr addf;
       endif;
       if     %parms > 5
          and fld5 <> '';
         f = fld5;
         exsr addf;
       endif;
       if     %parms > 6
          and fld6 <> '';
         f = fld6;
         exsr addf;
       endif;
       if     %parms > 7
          and fld7 <> '';
         f = fld7;
         exsr addf;
       endif;

       return;

       begsr addf;
         for i = 1 to %elem(Err.flds);
           if Err.flds(i) = f;
             leavesr;
           elseif Err.flds(i) = '';
             Err.flds(i) = f;
             leavesr;
           endif;
         endfor;
       endsr;

      /end-free
     p                 e


     p L_AddErrFld     b
     d L_AddErrFld     pi
     d   fld                         12    const

     d i               s             10i 0

      /free

       if %lookup(fld:Err.flds) > 0;
         return;
       endif;

       i = %lookup(' ':Err.flds);
       if i > 0;
         Err.flds(i) = fld;
       endif;

       return;

      /end-free
     p                 e

