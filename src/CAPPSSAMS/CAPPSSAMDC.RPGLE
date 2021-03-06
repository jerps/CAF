
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module DC for *SRVPGM CAPPSSAM

       // Service Program: Common App Services / SubSystem AppMenu
       // Module         : Database Commands


       // Implementation guidelines:

       //   All       - Use %error to detect database errors on update or
       //               write (use error message 9...).

       //   *ADD      - Key values and non-key values must both be given.
       //             - If the new key is fully given then check first if a
       //               record with the same key already exists and, if this
       //               is the case, immediately return with code -31.
       //             - If the new key is determined automatically (e.g. a
       //               sequence number) then do this as late as possible,
       //               just before actually writing the new record.

       //   *UPDATE   - Key values and non-key values must both be given.
       //             - First read the record "for update" - i.e. WITH LOCK -
       //               and, if not found, immediately return with code -32.
       //             - Update the record - and RELEASE THE LOCK - when there
       //               are no fatal issues and all processing has been done,
       //               then immediately return with code >= 0.

       //   *DELETE   - Only key values must given; non-key values are ignored.
       //             - First read the record "for update" - i.e. WITH LOCK -
       //               and if not found, immediately return with code -12.
       //             - Delete the record when there are no fatal issues,
       //               then immediately return with code >= 0.


      /DEFINE CAPPSSAM_MODULE
      /DEFINE CAPPSSAM_CAPPSSAMDC

      /include CAPPSSAMS,INCL__MODH


     fCAPPSSAMF3uf a e           k disk    usropn
     fCAPPSSAMF6uf a e           k disk    usropn rename(MENUMGREC:MENUMGREC6)


      /include CAPPSSAMS,INCL_DC

      /include CAPPSSAMS,INCL_XX
      /include CAPPSSAMS,INCL_DQ
      /include CAPPSSAMS,INCL_AM
      /include CAPPBASES,INCL_API

      /include CAPPSSAMS,INCL__DC
      /include CAPPSSAMS,INCL__DQ
      /include CAPPSSAMS,INCL__MO

      /include CAPPSSAMS,INCL__MODD


       // Import "DspMsgList" which is defined in *SRVPGM CAPPBASE.
     d DspMsgList      s            130    dim(99) import('DspMsgList')


       // ----- Implementation


     pDC_AM_Group      b                   export
     dDC_AM_Group      pi             2  0
     d   ctype                       10    const
     d   data                                    likeds(DC_AM_Group$)
     d   members_n                         like(TAM_MBRN)   dim(CNumGrpMembers)
     d                                     options(*nopass)
     d   members_t                         like(TAM_MBRT)   dim(CNumGrpMembers)
     d                                     options(*nopass)

     d rc              s              2  0
     d prc             s                   like(rc)
     d cAdd            s               n
     d cUpd            s               n
     d cDel            s               n
     d islocked        s               n
     d imc             s                   like(GetDspMsgListCount)
     d mc              s                   like(GetDspMsgListCount)
     d grps            s                   like(TAM_MBRN)   dim(CNumGrpMembers)
     d grps#           s             10i 0
     d cyclegrp        s                   like(TAM_GROUP)
     d cyclepath       s             80
     d f               s               n
     d i               s             10i 0
     d j               s             10i 0
     d a               s             30

      /free

       rc = 0;

       cAdd = ctype = '*ADD';
       cUpd = ctype = '*UPDATE';
       cDel = ctype = '*DELETE';

       if     not cAdd
          and not cUpd
          and not cDel;
         return -1;
       endif;

       I_SdaReadLock();

       // First, ensure that all needed files are opened.
       // Files should be left open; they are closed in "I_RlsModDC".
       if not %open(CAPPSSAMF3);
         open CAPPSSAMF3;
       endif;
       if not %open(CAPPSSAMF6);
         open CAPPSSAMF6;
       endif;

       // Set to *on if the record is read for-update (i.e. locked),
       // and *off again if the record is updated (or released).
       islocked = *off;

       // Initial message count.
       imc = GetDspMsgListCount();

       // Preferred return code if error.
       prc = -30;

       // Normalize values.
       exsr normalize;

       // Validate key fields first, if *ADD or *UPDATE.
       if    cAdd
          or cUpd;
         exsr val_key;
         exsr return_on_error;
       endif;

       // Check key existence and - if *UPDATE or *DELETE - lock record.
       if cAdd;
         prc = -31;
       else;
         prc = -32;
       endif;
       exsr readlock_key;
       exsr return_on_error;

       prc = -30;

       // Do generic validations, if *ADD or *UPDATE.
       if    cAdd
          or cUpd;
         exsr val_generic;
       endif;

       select;
       when cAdd;
         // Do *ADD specific validations.
         exsr val_add;
       when cUpd;
         // Do *UPDATE specific validations.
         exsr val_update;
       when cDel;
         // Do *DELETE specific validations.
         exsr val_delete;
       endsl;

       exsr return_on_error;

       // Perform *ADD, *UPDATE or *DELETE.
       select;
       when cAdd; // *ADD
         exsr new_key;
         exsr return_on_error;
         exsr set_db_fields;
         exsr return_on_error;
         write(e) MENUGREC;
         if %error;
           AddDCVMsg(RtvAMsgAM(9001:CAmsFatal)
               :CEfAMGROUP);
         elseif %parms > 3;
           exsr delete_members;
           exsr return_on_error;
           exsr add_members;
           exsr return_on_error;
         endif;
       when cUpd; // *UPDATE
         if %parms > 3;
           exsr delete_members;
           exsr return_on_error;
           exsr add_members;
           exsr return_on_error;
         endif;
         exsr set_db_fields;
         exsr return_on_error;
         update(e) MENUGREC;
         if %error;
           AddDCVMsg(RtvAMsgAM(9002:CAmsFatal)
               :CEfAMGROUP);
         else;
           islocked = *off;
         endif;
       when cDel; // *DELETE
         exsr delete_members;
         exsr return_on_error;
         delete(e) MENUGREC;
         if %error;
           AddDCVMsg(RtvAMsgAM(9003:CAmsFatal)
               :CEfAMGROUP);
         else;
           islocked = *off;
         endif;
       endsl;

       exsr return_on_error;

       exsr exit;

       begsr exit;
         if islocked;
           unlock(e) CAPPSSAMF3;
         endif;
         I_SdaWrite();
         return rc;
       endsr;

       // Delete all members from group "data.GROUP".
       begsr delete_members;

         dou 0=0;
           setll(e) (data.GROUP) CAPPSSAMF6;
           if %error;
             leave;
           endif;
           reade(e) (data.GROUP) CAPPSSAMF6;
           dow     not %eof
               and not %error;
             delete(e) MENUMGREC6;
             if not %error;
               reade(e) (data.GROUP) CAPPSSAMF6;
             endif;
           enddo;
         enddo;
         if %error;
           AddDCVMsg(RtvAMsgAM(9004:CAmsFatal)
               :CEfAMMBRN);
         endif;

       endsr;

       // Add all non-blank elements in "members_n" as members
       // to group "data.GROUP".
       begsr add_members;

         for i = 1 to %elem(members_n);
           if members_n(i) <> '';
             clear *all MENUMGREC6;
             MENUMGMBRT = members_t(i);
             MENUMGMBRN = members_n(i);
             MENUMGROUP = data.GROUP;
             write(e) MENUMGREC6;
             if %error;
               leave;
             endif;
           endif;
         endfor;
         if %error;
           AddDCVMsg(RtvAMsgAM(9005:CAmsFatal)
               :CEfAMMBRN);
         endif;
       endsr;

       // Normalize values.
       begsr normalize;
       endsr;

       // Validate key fields, for *ADD or *UPDATE.
       begsr val_key;

         if     data.GROUP <> CSgAdmin
            and %check(CCharLettersUC:%subst(data.GROUP:1:1)) > 0;
           AddDCVMsg(RtvAMsgAM(2501:CAmsFatal):CEfAMGROUP);
         endif;

       endsr;

       // Check if key (already) exists; lock record if *UPDATE or *DELETE.
       begsr readlock_key;

         if cAdd;
           // Check if key exists.
           chain(n) (data.GROUP) CAPPSSAMF3;
           if %found;
             // Can not add; record already exists.
             AddDCVMsg(RtvAMsgAM(2591:CAmsFatal:%trimr(MENUGROUP))
                 :CEfAMGROUP);
           endif;
         else;
           // Read with lock.
           chain (data.GROUP) CAPPSSAMF3;
           if %found;
             islocked = *on;
           else;
             // Can not update or delete; record does not exist.
             if cUpd;
               AddDCVMsg(RtvAMsgAM(2592:CAmsFatal:%trimr(MENUGROUP))
                   :CEfAMGROUP);
             else;
               AddDCVMsg(RtvAMsgAM(2593:CAmsFatal:%trimr(MENUGROUP))
                   :CEfAMGROUP);
             endif;
           endif;
         endif;

       endsr;

       // Generic validations, for *ADD or *UPDATE.
       begsr val_generic;

         // Text can not start with a blank.
         if %subst(data.TEXT:1:1) = ' ';
           AddDCVMsg(RtvAMsgAM(2502:CAmsFatal):CEfAMTEXT);
         endif;

         // Active Y/N.
         if     data.ACTIVE <> 'Y'
            and data.ACTIVE <> 'N';
           AddDCVMsg(RtvAMsgAM(2503:CAmsFatal):CEfAMACTIVE);
         endif;

         // CsgAdmin must be active.
         if     data.GROUP = CSgAdmin
            and data.ACTIVE <> 'Y';
           AddDCVMsg(RtvAMsgAM(2514:CAmsFatal:CsgAdmin):CEfAMACTIVE);
         endif;

         if %parms > 3;

           // Members

           grps(*) = '';
           grps# = 0;

           for i = 1 to %elem(members_n);
             if     members_n(i) <> ''
                and members_t(i) <> 0
                and members_t(i) <> 1;
               AddDCVMsg(RtvAMsgAM(2507:CAmsFatal
                             :%char(members_t(i)):%trimr(members_n(i)))
                   :CEfAMMBRT);
             endif;
           endfor;

           for i = 1 to %elem(members_n);
             if members_n(i) <> '';

               if members_t(i) = 0;
                 grps# = grps# + 1;
                 grps(grps#) = members_n(i);
               endif;

               if %subst(members_n(i):1:1) = ' ';
                 AddDCVMsg(RtvAMsgAM(2504:CAmsFatal:%trimr(members_n(i)))
                     :CEfAMMBRN);
               elseif     members_t(i) = 1
                      and %subst(members_n(i):1:1) = '-';
                 AddDCVMsg(RtvAMsgAM(2510:CAmsFatal:%trimr(members_n(i)))
                     :CEfAMMBRN);
               elseif     members_t(i) = 0
                      and members_n(i) = data.GROUP;
                 AddDCVMsg(RtvAMsgAM(2513:CAmsFatal:%trimr(members_n(i)))
                     :CEfAMMBRN);
               elseif     members_t(i) = 0
                      and not GroupExists(members_n(i));
                 AddDCVMsg(RtvAMsgAM(2508:CAmsFatal
                               :%trimr(members_n(i)))
                     :CEfAMMBRN);
               endif;

               if i < %elem(members_n);
                 for j = i + 1 to %elem(members_n);
                   if     members_n(j) = members_n(i)
                      and members_t(j) = members_t(i);
                     if members_t(i) = 0;
                       AddDCVMsg(RtvAMsgAM(2505:CAmsFatal
                                     :%trimr(members_n(i)))
                           :CEfAMMBRN);
                     else;
                       AddDCVMsg(RtvAMsgAM(2506:CAmsFatal
                                     :%trimr(members_n(i)))
                           :CEfAMMBRN);
                     endif;
                   endif;
                 endfor;
               endif;

             endif;
           endfor;

           // Check cycles.
           if I_DetectGroupCycle(data.GROUP:grps:cyclegrp:cyclepath);
             AddDCVMsg(RtvAMsgAM(2509:CAmsFatal
                                :%trim(cyclegrp):%trim(cyclepath))
                 :CEfAMMBRN);
           endif;

         endif;

       endsr;

       // Validations for *ADD.
       begsr val_add;
       endsr;

       // Validations for *UPDATE.
       begsr val_update;
       endsr;

       // Validations for *DELETE.
       begsr val_delete;

         if data.GROUP = CsgAdmin;
           // Special group can not be deleted.
           AddDCVMsg(RtvAMsgAM(2541:CAmsFatal:%trimr(data.GROUP))
               :CEfAMGROUP);
         endif;

         // Check if group is still in use.
         a = IsGroupUsed(data.GROUP);
         if a <> '';
           AddDCVMsg(RtvAMsgAM(2511:CAmsFatal:%trimr(data.GROUP):%trimr(a))
               :CEfAMGROUP);
         endif;

       endsr;

       // Determine new key for *ADD.
       begsr new_key;
       endsr;

       // Set database record fields, for *ADD or *UPDATE.
       begsr set_db_fields;

         if IsGrpSpecial(data.GROUP);
           // Always set default fields for special groups.
           data.TEXT = GetSpGrpText(data.GROUP);
           data.ACTIVE = 'Y';
         endif;

         clear *all MENUGREC;

         monitor;

           MENUGROUP = data.GROUP;
           MENUGTEXT = data.TEXT;
           MENUGACT  = data.ACTIVE;

         on-error;
           AddDCVMsg(RtvAMsgAM(9120:CAmsFatal:'CAPPSSAMF3':%char(%status)));
         endmon;

       endsr;

      /include QINCSRC,CAPPDC_ROE

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModDC       b                   export
     dI_RlsModDC       pi

      /free

       close(e) *ALL;

       return;

      /end-free
     p                 e

