
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module SI for *SRVPGM CAPPDISP

       // Service Program: Common App Services / Display
       // Module         : Select Item


      /DEFINE CAPPDISP_MODULE
      /DEFINE CAPPDISP_CAPPDISPSI

      /include CAPPDISPS,INCL__MODH


     fCSYSBASEF1if   e           k disk    usropn
     fCAPPSSAMF3if   e           k disk    usropn


       // SQL Stmt Id : Procedure
       //          00 : SelSqlStmtId
     d SSID00          c                   'CSYS-000'


      /include CAPPDISPS,INCL_SI

      /include CAPPBASES,INCL_API
      /include CSYSSQLSS,INCL_API
      /include CSYSBASES,INCL_API

      /include CAPPDISPS,INCL__SI
      /include CAPPDISPS,INCL__HD

      /include CAPPDISPS,INCL__MODD


       // ----- External Data Structures

      /IF NOT DEFINED(ERF_CSYSSQLSF1)
      /DEFINE ERF_CSYSSQLSF1
     dErfCSYSSQLSF1  e ds                  extname(CSYSSQLSF1)
      /ENDIF


       // ----- Arrays

       // Misc. Texts
     d Text            s             80    ctdata dim(10)
       // Header Texts
     d HText           s             80    ctdata dim(3)


       // ---- Implementation


     p SelectSimpleValue...
     p                 b                   export
     d SelectSimpleValue...
     d                 pi            40
     d   wdwtitle                    40    const
     d   values                      40    const dim(100)
     d   values#                     10i 0 const options(*nopass:*omit)
     d   wdwrow                       2  0 const options(*nopass:*omit)
     d   wdwcol                       3  0 const options(*nopass:*omit)

     d num             s             10i 0
     d wrow            s              2  0
     d wcol            s              3  0
     d sk              s             40
     d items           s                   like(sk) dim(%elem(values))
     d i               s             10i 0

      /free


       num = 0;
       wrow = 0;
       wcol = 0;
       if     %parms > 2
          and %addr(values#) <> *null
          and values# > 0;
         num = values#;
       endif;
       if     %parms > 3
          and %addr(wdwrow) <> *null;
         wrow = wdwrow;
       endif;
       if     %parms > 4
          and %addr(wdwcol) <> *null;
         wcol = wdwcol;
       endif;

       items(*) = '';

       if num > 0;
         for i = 1 to num;
           items(i) = values(i);
         endfor;
       else;
         for i = 1 to %elem(values);
           if values(i) <> '';
             num = num + 1;
             items(num) = values(i);
           endif;
         endfor;
       endif;

       if     I_SelectItem(wrow:wcol
                  :wdwtitle
                  :sk:num:%addr(items))
          and sk <> *allx'00';
         return sk;
       endif;

       return '';

      /end-free
     p                 e


     p SelNwdType      b                   export
     d SelNwdType      pi              n
     d   selkey                                  likeds(SelNwdType$)
     d   wdwrow                       2  0 const options(*omit:*nopass)
     d   wdwcol                       3  0 const options(*omit:*nopass)

       // Read data once per activation.
     d readdata        s               n   static inz(*on)

     d wrow            s              2  0
     d wcol            s              3  0
     d sk              s             40
     d item#           s             10i 0 static inz(0)
     d items           s                   static like(sk) dim(100)
     d keys            s                   static like(sk) dim(%elem(items))
     d wasopen         s               n

      /free

       clear selkey;

       wrow = 0;
       wcol = 0;
       if     %parms > 1
          and %addr(wdwrow) <> *null;
         wrow = wdwrow;
       endif;
       if     %parms > 2
          and %addr(wdwcol) <> *null;
         wcol = wdwcol;
       endif;

       if readdata;

         readdata = *off;

         item#    = 0;
         items(*) = '';
         keys(*)  = '';

         wasopen = %open(CSYSBASEF1);

         if not wasopen;
           open CSYSBASEF1;
         endif;

         setll *start CSYSBASEF1;
         read CSYSBASEF1;
         dow     not %eof
             and item# < %elem(items);
           item# = item# + 1;
           if item# < %elem(items);
             items(item#) = NWDTCODE + ': ' + NWDTNAME;
             keys(item#)  = NWDTCODE;
           else;
             items(item#) = Text(1);
             keys(item#)  = *allx'00';
           endif;
           read CSYSBASEF1;
         enddo;

         if not wasopen;
           close CSYSBASEF1;
         endif;

       endif;

       if     I_SelectItem(wrow:wcol
                  :HText(1)
                  :sk:item#:%addr(items):%addr(keys))
          and sk <> *allx'00';
         selkey.f1 = sk;
         return *on;
       endif;

       return *off;

      /end-free
     p                 e


     p SelAppMenuGroup...
     p                 b                   export
     d SelAppMenuGroup...
     d                 pi              n
     d   selkey                                  likeds(SelAppMenuGroup$)
     d   wdwrow                       2  0 const options(*omit:*nopass)
     d   wdwcol                       3  0 const options(*omit:*nopass)

       // Read data once per activation.
     d readdata        s               n   static inz(*on)

     d wrow            s              2  0
     d wcol            s              3  0
     d sk              s             40
     d item#           s             10i 0 static inz(0)
     d items           s                   static like(sk) dim(100)
     d keys            s                   static like(sk) dim(%elem(items))
     d wasopen         s               n

      /free

       clear selkey;

       wrow = 0;
       wcol = 0;
       if     %parms > 1
          and %addr(wdwrow) <> *null;
         wrow = wdwrow;
       endif;
       if     %parms > 2
          and %addr(wdwcol) <> *null;
         wcol = wdwcol;
       endif;

       if readdata;

         readdata = *off;

         item#    = 0;
         items(*) = '';
         keys(*)  = '';

         wasopen = %open(CAPPSSAMF3);

         if not wasopen;
           open CAPPSSAMF3;
         endif;

         setll *start CAPPSSAMF3;
         read CAPPSSAMF3;
         dow     not %eof
             and item# < %elem(items);
           item# = item# + 1;
           if item# < %elem(items);
             items(item#) = MENUGROUP + ': ' + MENUGTEXT;
             keys(item#)  = MENUGROUP;
           else;
             items(item#) = Text(1);
             keys(item#)  = *allx'00';
           endif;
           read CAPPSSAMF3;
         enddo;

         if not wasopen;
           close CAPPSSAMF3;
         endif;

       endif;

       if     I_SelectItem(wrow:wcol
                  :HText(2)
                  :sk:item#:%addr(items):%addr(keys))
          and sk <> *allx'00';
         selkey.f1 = sk;
         return *on;
       endif;

       return *off;

      /end-free
     p                 e


     p SelSqlStmtId    b                   export
     d SelSqlStmtId    pi              n
     d   selkey                                  likeds(SelSqlStmtId$)
     d   wdwrow                       2  0 const options(*omit:*nopass)
     d   wdwcol                       3  0 const options(*omit:*nopass)

       // Read data once per activation.
     d readdata        s               n   static inz(*on)

       // Use SQL statement (query) 00
     d ssid            s             20    inz(SSID00)
     d qstmt           s                   like(SqlsRtvStmt)

     d wrow            s              2  0
     d wcol            s              3  0
     d sk              s             40
     d item#           s             10i 0 static inz(0)
     d items           s                   static like(sk) dim(500)
     d keys            s                   static like(sk) dim(%elem(items))
     d cid             s              5i 0
     d sqlerr          s               n

      /free

       clear selkey;

       wrow = 0;
       wcol = 0;
       if     %parms > 1
          and %addr(wdwrow) <> *null;
         wrow = wdwrow;
       endif;
       if     %parms > 2
          and %addr(wdwcol) <> *null;
         wcol = wdwcol;
       endif;

       if readdata;

         readdata = *off;

         item#    = 0;
         items(*) = '';
         keys(*)  = '';

         qstmt = SqlsRtvStmt(ssid);
         if     %len(qstmt) > 0
            and %len(%triml(qstmt)) >= 7
            and ToUppercase(%subst(%triml(qstmt):1:7)) = 'SELECT ';

           sqlerr = *on;

           DspStatMsg(RtvAMsgAB(1100:*omit:%trim(ssid)));

           cid = SqlsDBExec(*omit:qstmt);
           if cid > 0;
             if SqlsBindCols( cid
                 :1:%addr(SQLSID):SQL_CHAR:%size(SQLSID):*omit);
               sqlerr = not SqlsFetch(cid);
               dow     not sqlerr
                   and SqlsStatus() <> 100
                   and item# < %elem(items);
                 item# = item# + 1;
                 if item# < %elem(items);
                   items(item#) = SQLSID;
                   keys(item#)  = items(item#);
                 else;
                   items(item#) = Text(1);
                   keys(item#)  = *allx'00';
                 endif;
                 sqlerr = not SqlsFetch(cid);
               enddo;
             endif;
             SqlsCloseCurs(cid);
           endif;

           DspStatMsg('');

           if     sqlerr
              and item# < %elem(items);
             item# = item# + 1;
             items(item#) = SubstText(Text(3):%trim(ssid));
             keys(item#)  = *allx'00';
           endif;

         else;
           item# = 1;
           items(1) = SubstText(Text(2):%trim(ssid));
           keys(1)  = *allx'00';
         endif;

       endif;

       if     I_SelectItem(wrow:wcol
                  :HText(3)
                  :sk:item#:%addr(items):%addr(keys))
          and sk <> *allx'00';
         selkey.f1 = sk;
         return *on;
       endif;

       return *off;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModSI       b                   export
     dI_RlsModSI       pi

      /free

       close(e) *ALL;

       return;

      /end-free
     p                 e


** Text
MORE ITEMS ...
ERROR: SELECT stmt %1 not found
ERROR: SQL stmt %1
** HText
Select Non-Work Day Type
Select Menu Group
Select SQL Stmt Id
