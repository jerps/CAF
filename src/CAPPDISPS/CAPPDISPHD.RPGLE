
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module HD for *SRVPGM CAPPDISP

       // Internal Only

       // Service Program: Common App Services / Display
       // Module         : Handle Display

       //                  This module is for internal use only and should
       //                  only contain internal (or local) procedures (I_*).
       //                  Do NOT put public procedures in this module.
       //                  This module encapsulates all display file handling,
       //                  and is the only module in this service program that
       //                  directly uses display files.


      /DEFINE CAPPDISP_MODULE
      /DEFINE CAPPDISP_CAPPDISPHD

      /include CAPPDISPS,INCL__MODH


     fCAPPDISPD1cf   e             workstn sfile(DFSFR1:SFLR#)
     f                                     infds(WSI1) usropn
     fCAPPDISPD2cf   e             workstn sfile(DFSFR2:SFLR#)
     f                                     infds(WSI2) usropn
     fCAPPDISPD3cf   e             workstn sfile(DFSFR3:SFLR#)
     f                                     infds(WSI3) usropn
     fCAPPDISPD4cf   e             workstn sfile(DFSFR4:SFLR#)
     f                                     infds(WSI4) usropn
     fCAPPDISPD9cf   e             workstn infds(WSI9) usropn
     f
     fCAPPDISPF1if   e           k disk    usropn


      /include CAPPBASES,INCL_MS
      /include CSYSBASES,INCL_API

      /include CAPPDISPS,INCL__HD

      /include CAPPDISPS,INCL__MODD


       // ----- Global Defs

     d SFLR#           s              5  0
     d SFLR#T          s              5  0

     d WSI1            ds                  likeds(WSI)
     d WSI2            ds                  likeds(WSI)
     d WSI3            ds                  likeds(WSI)
     d WSI4            ds                  likeds(WSI)
     d WSI9            ds                  likeds(WSI)

     d DspMsg          s            130            import('DspMsg')
     d DspMsgList      s            130    dim(99) import('DspMsgList')


       // ----- Local Prototypes

       // Add/Update subfile record 1.
     dL_AddUpdSfRec1   pr
     d  text                               const like(D_HLPTEXT)
     d  recno                              const like(SFLR#)


       // ----- Implementation - Internal


     pI_DspHelp        b                   export
     dI_DspHelp        pi
     d  context                      20    const
     d  text                         60    const dim(30) options(*nopass)
     d  wdwrow                        2  0 const         options(*nopass)
     d  wdwcol                        3  0 const         options(*nopass)

     d wcrows          c                   13
     d wrowstop        c                   1
     d wrowsbot        c                   1
     d wccols          c                   60
     d wcolsleft       c                   2
     d wcolsright      c                   7
     d pglen           c                   13
     d WSI@_           s                   like(WSI@)
     d wrow            s              2  0
     d wcol            s              3  0
     d wasopend        s               n
     d wasopenf        s               n
     d dspwide         s               n
     d scrrows         s             10i 0
     d scrcols         s             10i 0
     d pgtopl          s             10i 0
     d sflempty        s               n
     d cursrow         s             10i 0
     d curscol         s             10i 0
     d setcurs         s               n
     d i               s             10i 0
     d n               s             10i 0

      /free

       if     %parms > 2
          and wdwrow > 0;
         wrow = wdwrow;
       else;
         wrow = GetCursRow();
       endif;
       if     %parms > 3
          and wdwcol > 0;
         wcol = wdwcol;
       else;
         wcol = GetCursCol();
       endif;

       WSI@_ = WSI@;
       WSI@  = %addr(WSI1);

       wasopend = %open(CAPPDISPD1);
       if not wasopend;
         open CAPPDISPD1;
       endif;
       wasopenf = %open(CAPPDISPF1);
       if not wasopenf;
         open CAPPDISPF1;
       endif;

       D__TITLE1 = 'Help';
       if context <> '';
         D__TITLE1 = %trimr(D__TITLE1) + ' (' + %trimr(context) + ')';
       endif;

       dspwide = IsDspModeWide();
       if dspwide;
         scrrows = 27;
         scrcols = 132;
       else;
         scrrows = 24;
         scrcols = 80;
       endif;

       if wrow < 1;
         D__WDWROW = 1;
       elseif wrow > scrrows - wcrows - wrowstop - wrowsbot;
         D__WDWROW = scrrows - wcrows - wrowstop - wrowsbot;
       else;
         D__WDWROW = wrow;
       endif;
       if wcol < 2;
         D__WDWCOL = 2;
       elseif wcol > scrcols - wccols - wcolsleft - wcolsright;
         D__WDWCOL = scrcols - wccols - wcolsleft - wcolsright;
       else;
         D__WDWCOL = wcol;
       endif;

       pgtopl = D__WDWROW + 1;

       setcurs = *off;

       exsr fillsf;

       D__CURREC = 1;

       dou    KeyPressed(KsF12)
           or KeyPressed(KsF01)
           or KeyPressed(KsEnter);
         exsr display;
         if KeyPressed(KsPageDown);
           if not sflempty;
             D__CURREC = 1;
           endif;
         elseif KeyPressed(KsPageUp);
           if not sflempty;
             D__CURREC = SFLR#T - pglen + 1;
           endif;
         endif;
       enddo;

       if not wasopend;
         close CAPPDISPD1;
       endif;
       if not wasopenf;
         close CAPPDISPF1;
       endif;

       WSI@ = WSI@_;

       return;

       begsr fillsf;

         *in10 = dspwide;
         *in21 = *off;
         *in22 = *off;
         *in23 = *on;

         sflempty = *on;
         SFLR#T = 0;
         write DFSFC1;

         n = 0;
         if %parms > 1;
           for i = 1 to %elem(text);
             if     SFLR#T < 9999
                and text(i) <> '';
               sflempty = *off;
               n = i;
               L_AddUpdSfRec1(text(i):i);
             endif;
           endfor;
         endif;
         if context <> '';
           i = n;
           HLPTCNTX = context;
           setll HLPTCNTX CAPPDISPF1;
           reade HLPTCNTX CAPPDISPF1;
           dow not %eof;
             if     SFLR#T < 9999
                and HLPTSEQ# >= 1;
               sflempty = *off;
               i = n + HLPTSEQ#;
               L_AddUpdSfRec1(HLPTEXT:i);
             endif;
             reade HLPTCNTX CAPPDISPF1;
           enddo;
           n = i;
         endif;
         i = n;
         HLPTCNTX = '';
         setll HLPTCNTX CAPPDISPF1;
         reade HLPTCNTX CAPPDISPF1;
         dow not %eof;
           if     SFLR#T < 9999
              and HLPTSEQ# >= 1;
             sflempty = *off;
             i = n + HLPTSEQ#;
             L_AddUpdSfRec1(HLPTEXT:i);
           endif;
           reade HLPTCNTX CAPPDISPF1;
         enddo;

         if sflempty;
           SFLR# = 1;
           clear *all DFSFR1;
           *in59 = *on;
           write DFSFR1;
           SFLR# = 2;
           clear *all DFSFR1;
           *in59 = *off;
           D_HLPTEXT = '----- No Help Found -----';
           write DFSFR1;
           SFLR#T = SFLR#;
         endif;

         if %rem(SFLR#T:pglen) > 0;
           n = (%div(SFLR#T:pglen) + 1) * pglen;
         endif;
         dow SFLR#T < n;
           SFLR# = SFLR#T + 1;
           clear *all DFSFR1;
           *in59 = *on;
           write DFSFR1;
           SFLR#T = SFLR#;
         enddo;

       endsr;

       begsr display;

         *in10 = dspwide;
         *in21 = *on;
         *in22 = *on;
         *in23 = *off;
         *in27 = setcurs;
         *in29 = *on;

         if cursrow < 1;
           cursrow = 1;
         elseif cursrow > wcrows;
           cursrow = wcrows;
         endif;
         if curscol < 1;
           curscol = 1;
         elseif curscol > wccols;
           curscol = wccols;
         endif;

         if setcurs;
           D__CURSROW = cursrow;
           D__CURSCOL = curscol;
         endif;

         if D__CURREC < 1;
           D__CURREC = 1;
         endif;
         if D__CURREC > SFLR#T;
           D__CURREC = SFLR#T;
         endif;

         exfmt DFSFC1;

         cursrow = %div(WSI1.wcursrc:256);
         curscol = %rem(WSI1.wcursrc:256);

         setcurs = *off;

         if cursrow < pgtopl;
           D__CURREC = WSI1.sfrrn;
         elseif cursrow >= pgtopl + pglen;
           D__CURREC = WSI1.sfrrn + pglen - 1;
         else;
           D__CURREC = WSI1.sfrrn + cursrow - pgtopl;
         endif;

       endsr;

      /end-free
     p                 e


     pI_SelectItem     b                   export
     dI_SelectItem     pi              n
     d  wdwrow                        2  0 const options(*omit)
     d  wdwcol                        3  0 const options(*omit)
     d  wdwtitle                     40    const
     d  selkey                       40
     d  item#                         4  0 const
     d  items                          *   const
     d  keys                           *   const options(*nopass)

     d wcrows          c                   9
     d wrowstop        c                   1
     d wrowsbot        c                   1
     d wccols          c                   40
     d wcolsleft       c                   2
     d wcolsright      c                   7
     d pglen           c                   9
     d itemlen         c                   40
     d keylen          c                   40
     d sel             s               n
     d stop            s               n
     d WSI@_           s                   like(WSI@)
     d wrow            s              2  0
     d wcol            s              3  0
     d wasopend        s               n
     d dspwide         s               n
     d scrrows         s             10i 0
     d scrcols         s             10i 0
     d pgtopl          s             10i 0
     d sflempty        s               n
     d cursrow         s             10i 0
     d curscol         s             10i 0
     d setcurs         s               n
     d i               s             10i 0
     d n               s             10i 0
     d p               s             10i 0
     d field           s             40    based(field@)

      /free

       if     %addr(wdwrow) <> *null
          and wdwrow > 0;
         wrow = wdwrow;
       elseif     %addr(wdwrow) <> *null
              and wdwrow < 0;
         wrow = GetCursRow() - wdwrow;
       else;
         wrow = GetCursRow();
       endif;
       if     %addr(wdwcol) <> *null
          and wdwcol > 0;
         wcol = wdwcol;
       elseif     %addr(wdwcol) <> *null
              and wdwcol < 0;
         wcol = GetCursCol() - wdwcol;
       else;
         wcol = GetCursCol();
       endif;

       WSI@_ = WSI@;
       WSI@  = %addr(WSI2);

       sel = *off;
       selkey = *allx'00';

       wasopend = %open(CAPPDISPD2);
       if not wasopend;
         open CAPPDISPD2;
       endif;

       D__TITLE2 = %trim(wdwtitle);

       dspwide = IsDspModeWide();
       if dspwide;
         scrrows = 27;
         scrcols = 132;
       else;
         scrrows = 24;
         scrcols = 80;
       endif;

       if wrow < 1;
         D__WDWROW = 1;
       elseif wrow > scrrows - wcrows - wrowstop - wrowsbot;
         D__WDWROW = scrrows - wcrows - wrowstop - wrowsbot;
       else;
         D__WDWROW = wrow;
       endif;
       if wcol < 2;
         if wrow = 1;
           D__WDWCOL = 2;
         elseif wcol < 1;
           D__WDWCOL = 1;
         endif;
       elseif wcol > scrcols - wccols - wcolsleft - wcolsright;
         D__WDWCOL = scrcols - wccols - wcolsleft - wcolsright;
       else;
         D__WDWCOL = wcol;
       endif;

       pgtopl = D__WDWROW + 1;

       setcurs = *off;

       exsr fillsf;

       D__CURREC = 1;

       stop = *off;

       dou    KeyPressed(KsF12)
           or KeyPressed(KsF04)
           or stop;
         exsr display;
         if KeyPressed(KsPageDown);
           if not sflempty;
             D__CURREC = 1;
           endif;
         elseif KeyPressed(KsPageUp);
           if not sflempty;
             D__CURREC = SFLR#T - pglen + 1;
           endif;
         elseif KeyPressed(KsEnter);
           for i = 1 to SFLR#T;
             chain i DFSFR2;
             if     sflempty
                and i = 1
                and D__CHCCTL = 1;
               stop = *on;
               leave;
             endif;
             if     D__CHCCTL = 1
                and D__ACTIVE = '1';
               selkey = D_SELITEMK;
               sel = *on;
               stop = *on;
               leave;
             endif;
           endfor;
         endif;
       enddo;

       if not wasopend;
         close CAPPDISPD2;
       endif;

       WSI@ = WSI@_;

       return sel;

       begsr fillsf;

         *in10 = dspwide;
         *in21 = *off;
         *in22 = *off;
         *in23 = *on;

         sflempty = *on;
         SFLR#T = 0;
         write DFSFC2;

         if item# = 0;
           n = pglen;
         else;
           n = %rem(item#:pglen);
           if n = 0;
             n = item#;
           else;
             n = item# + pglen - n;
           endif;
         endif;

         for i = 1 to n;
           if SFLR#T >= 9999;
             leave;
           endif;
           clear *all DFSFR2;
           *in59 = *off;
           if i > item#;
             *in59 = *on;
             D__CHCCTL = 0;
             D__ACTIVE = '0';
           else;
             p = (i - 1) * itemlen + 1;
             field@ = items + (i - 1) * itemlen;
             D_SELITEM = field;
             if %parms > 6;
               field@ = keys + (i - 1) * keylen;
             endif;
             D__CHCCTL = 0;
             if field = *allx'00';
               D__ACTIVE = '0';
             else;
               D_SELITEMK = field;
               D__ACTIVE = '1';
             endif;
             sflempty = *off;
           endif;
           SFLR# = SFLR#T + 1;
           write DFSFR2;
           SFLR#T = SFLR#;
         endfor;

         if sflempty;
           chain 2 DFSFR2;
           clear *all DFSFR2;
           *in59 = *off;
           D_SELITEM = '--- No Items Found ---';
           D__CHCCTL = 0;
           D__ACTIVE = '0';
           update DFSFR2;
         endif;

       endsr;

       begsr display;

         *in10 = dspwide;
         *in21 = *on;
         *in22 = *on;
         *in23 = *off;
         *in27 = setcurs;
         *in29 = *on;

         if cursrow < 1;
           cursrow = 1;
         elseif cursrow > wcrows;
           cursrow = wcrows;
         endif;
         if curscol < 1;
           curscol = 1;
         elseif curscol > wccols;
           curscol = wccols;
         endif;

         if setcurs;
           D__CURSROW = cursrow;
           D__CURSCOL = curscol;
         endif;

         if D__CURREC < 1;
           D__CURREC = 1;
         endif;
         if D__CURREC > SFLR#T;
           D__CURREC = SFLR#T;
         endif;

         exfmt DFSFC2;

         cursrow = %div(WSI2.wcursrc:256);
         curscol = %rem(WSI2.wcursrc:256);

         setcurs = *off;

         if cursrow < pgtopl;
           D__CURREC = WSI2.sfrrn;
         elseif cursrow >= pgtopl + pglen;
           D__CURREC = WSI2.sfrrn + pglen - 1;
         else;
           D__CURREC = WSI2.sfrrn + cursrow - pgtopl;
         endif;

       endsr;

      /end-free
     p                 e


     pI_ShowDspMsgs    b                   export
     dI_ShowDspMsgs    pi

     d wrow            c                   17
     d wcol            c                   1
     d wcrows          c                   6
     d wrowstop        c                   1
     d wrowsbot        c                   1
     d wccols          c                   69
     d wcolsleft       c                   2
     d colsright       c                   8
     d pglen           c                   6
     d pglenw          c                   9
     d widthdiff       c                   52
     d heightdiff      c                   3
     d WSI@_           s                   like(WSI@)
     d wasopend        s               n
     d msgcount        s             10i 0
     d dspwide         s               n
     d wdiff           s             10i 0
     d hdiff           s             10i 0
     d scrrows         s             10i 0
     d scrcols         s             10i 0
     d pgtopl          s             10i 0
     d sflempty        s               n
     d cursrow         s             10i 0
     d curscol         s             10i 0
     d setcurs         s               n
     d pl              s             10i 0
     d i               s             10i 0
     d n               s             10i 0

      /free

       WSI@_ = WSI@;

       msgcount = GetDspMsgListCount() + 1;

       D__TITLE3 = 'Messages (' + %char(msgcount) + ')';
       D__TITLE4 = D__TITLE3;

       dspwide = IsDspModeWide();
       if dspwide;
         wdiff = widthdiff;
         hdiff = heightdiff;
         WSI@ = %addr(WSI4);
         wasopend = %open(CAPPDISPD4);
         if not wasopend;
           open CAPPDISPD4;
         endif;
         pl = pglenw;
         scrrows = 27;
         scrcols = 132;
       else;
         wdiff = 0;
         hdiff = 0;
         WSI@  = %addr(WSI3);
         wasopend = %open(CAPPDISPD3);
         if not wasopend;
           open CAPPDISPD3;
         endif;
         pl = pglen;
         scrrows = 24;
         scrcols = 80;
       endif;

       pgtopl = wrow + 1;

       setcurs = *off;

       exsr fillsf;

       D__CURREC = 1;

       dou    KeyPressed(KsF12)
           or KeyPressed(KsF22)
           or KeyPressed(KsEnter);
         exsr display;
         if KeyPressed(KsPageDown);
           if not sflempty;
             D__CURREC = 1;
           endif;
         elseif KeyPressed(KsPageUp);
           if not sflempty;
             D__CURREC = SFLR#T - pl + 1;
           endif;
         endif;
       enddo;

       if not wasopend;
         if dspwide;
           close CAPPDISPD4;
         else;
           close CAPPDISPD3;
         endif;
       endif;

       WSI@ = WSI@_;

       return;

       begsr fillsf;

         *in21 = *off;
         *in22 = *off;
         *in23 = *on;

         sflempty = *on;
         SFLR#T = 0;
         if dspwide;
           write DFSFC4;
         else;
           write DFSFC3;
         endif;

         for i = 1 to msgcount;
           if SFLR#T >= 9999;
             leave;
           endif;
           if dspwide;
             clear *all DFSFR4;
           else;
             clear *all DFSFR3;
           endif;
           *in59 = *off;
           if i = 1;
             D_DSPMSGTW = DspMsg;
           else;
             D_DSPMSGTW = DspMsgList(i-1);
           endif;
           D_DSPMSGT = D_DSPMSGTW;
           sflempty = *off;
           SFLR# = SFLR#T + 1;
           if dspwide;
             write DFSFR4;
           else;
             write DFSFR3;
           endif;
           SFLR#T = SFLR#;
         endfor;

         if sflempty;
           SFLR# = 1;
           *in59 = *on;
           if dspwide;
             clear *all DFSFR4;
             write DFSFR4;
           else;
             clear *all DFSFR3;
             write DFSFR3;
           endif;
           SFLR# = 2;
           if dspwide;
             clear *all DFSFR4;
           else;
             clear *all DFSFR3;
           endif;
           *in59 = *off;
           D_DSPMSGTW = '--- No Messages Found ---';
           D_DSPMSGT  = D_DSPMSGTW;
           if dspwide;
             write DFSFR4;
           else;
             write DFSFR3;
           endif;
           SFLR#T = SFLR#;
         endif;

         if %rem(SFLR#T:pl) > 0;
           n = (%div(SFLR#T:pl) + 1) * pl;
         endif;
         dow SFLR#T < n;
           SFLR# = SFLR#T + 1;
           *in59 = *on;
           if dspwide;
             clear *all DFSFR4;
             write DFSFR4;
           else;
             clear *all DFSFR3;
             write DFSFR3;
           endif;
           SFLR#T = SFLR#;
         enddo;

       endsr;

       begsr display;

         *in21 = *on;
         *in22 = *on;
         *in23 = *off;
         *in27 = setcurs;
         *in29 = *on;

         if cursrow < 1;
           cursrow = 1;
         elseif cursrow > wcrows + hdiff;
           cursrow = wcrows + hdiff;
         endif;
         if curscol < 1;
           curscol = 1;
         elseif curscol > wccols + wdiff;
           curscol = wccols + wdiff;
         endif;

         if setcurs;
           D__CURSROW = cursrow;
           D__CURSCOL = curscol;
         endif;

         if D__CURREC < 1;
           D__CURREC = 1;
         endif;
         if D__CURREC > SFLR#T;
           D__CURREC = SFLR#T;
         endif;

         if dspwide;
           exfmt DFSFC4;
           WSI = WSI4;
         else;
           exfmt DFSFC3;
           WSI = WSI3;
         endif;

         cursrow = %div(WSI.wcursrc:256);
         curscol = %rem(WSI.wcursrc:256);

         if cursrow < pgtopl;
           D__CURREC = WSI.sfrrn;
         elseif cursrow >= pgtopl + pl;
           D__CURREC = WSI.sfrrn + pl - 1;
         else;
           D__CURREC = WSI.sfrrn + cursrow - pgtopl;
         endif;

         setcurs = *off;

       endsr;

      /end-free
     p                 e


     pI_PresentConfWdw...
     p                 b                   export
     dI_PresentConfWdw...
     d                 pi              n
     d  text                         40    const
     d  dftyes                         n   const options(*nopass)

     d wrows           c                   9
     d wcols           c                   45
     d WSI@_           s                   like(WSI@)
     d wasopend        s               n
     d dspwide         s               n
     d scrrows         s             10i 0
     d scrcols         s             10i 0
     d yes             s               n

      /free

       WSI@_ = WSI@;
       WSI@  = %addr(WSI9);

       wasopend = %open(CAPPDISPD9);
       if not wasopend;
         open CAPPDISPD9;
       endif;

       dspwide = IsDspModeWide();
       if dspwide;
         scrrows = 27;
         scrcols = 132;
       else;
         scrrows = 24;
         scrcols = 80;
       endif;

       D__WDWROW = %div(scrrows-wrows:2) + 1;
       D__WDWCOL = %div(scrcols-wcols:2) + 1;

       D_W1TEXT = '';
       D_W1TEXT = %subst(D_W1TEXT:1:
                      %div(%len(D_W1TEXT)-%len(%trim(text)):2)) +
                  %trim(text);

       if     %parms > 1
          and dftyes;
         D_W1YN = 'Y';
       else;
         D_W1YN = 'N';
       endif;

       yes = *off;

       *in61 = *off;

       dow 0=0;

         *in10 = dspwide;
         exfmt DFWINDOW1;

         if     KeyPressed(KsEnter)
            and D_W1YN = 'Y';
           yes = *on;
           leave;
         elseif    KeyPressed(KsF12)
                or     KeyPressed(KsEnter)
                   and D_W1YN = 'N';
           leave;
         else;
           *in61 = *on;
         endif;

       enddo;

       if not wasopend;
         close CAPPDISPD9;
       endif;

       WSI@ = WSI@_;

       return yes;

      /end-free
     p                 e


     pI_RlsModHD       b                   export
     dI_RlsModHD       pi

      /free

       close(e) *ALL;

       return;

      /end-free
     p                 e


       // ----- Implementation - Local


     pL_AddUpdSfRec1   b
     dL_AddUpdSfRec1   pi
     d  text                               const like(D_HLPTEXT)
     d  recno                              const like(SFLR#)

     d i               s             10i 0

      /free

       if recno > SFLR#T;
         for i = SFLR#T + 1 to recno - 1;
           *in59 = *off;
           D_HLPTEXT = '';
           SFLR# = i;
           write DFSFR1;
         endfor;
         *in59 = *off;
         D_HLPTEXT = text;
         SFLR# = recno;
         write DFSFR1;
         SFLR#T = SFLR#;
       else;
         chain recno DFSFR1;
         *in59 = *off;
         D_HLPTEXT = text;
         update DFSFR1;
       endif;

       return;

      /end-free
     p                 e

