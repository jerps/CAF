
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module DQ for *SRVPGM CAPPSSAM

       // Service Program: Common App Services / SubSystem AppMenu
       // Module         : Database Queries


      /DEFINE CAPPSSAM_MODULE
      /DEFINE CAPPSSAM_CAPPSSAMDQ

      /include CAPPSSAMS,INCL__MODH


     fCAPPSSAMF1if   e           k disk    usropn
     fCAPPSSAMF3if   e           k disk    usropn
     fCAPPSSAMF4if   e           k disk    usropn
     fCAPPSSAMF5if   e           k disk    usropn rename(MENUSGREC:MENUSGREC5)
     fCAPPSSAMF6if   e           k disk    usropn rename(MENUMGREC:MENUMGREC6)


      /include CAPPSSAMS,INCL_DQ

      /include CAPPSSAMS,INCL_XX
      /include CAPPSSAMS,INCL_AM
      /include CAPPBASES,INCL_API

      /include CAPPSSAMS,INCL__DQ
      /include CAPPSSAMS,INCL__MO

      /include CAPPSSAMS,INCL__MODD


       // ----- Implementation


     p IsGrpMember     b                   export
     d IsGrpMember     pi              n
     d   member                            const like(TAM_MBRN)
     d   isgroup                       n   const
     d   group0                            const like(TAM_GROUP)
     d   group1                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group2                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group3                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group4                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group5                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group6                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group7                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group8                            const like(TAM_GROUP)
     d                                           options(*nopass)
     d   group9                            const like(TAM_GROUP)
     d                                           options(*nopass)

     d chunksz         c                   20
     d yes             s               n
     d visited         s                   like(TAM_GROUP)   dim(32767)
     d                                     based(visited@)
     d visited#        s             10i 0
     d stackgrps       s                   like(TAM_GROUP)   dim(32767)
     d                                     based(stackgrps@)
     d stackgrps#      s             10i 0
     d act             s               n
     d grp             s                   like(TAM_GROUP)

      /free

       if member = '';
         return *off;
       endif;

       yes = *off;

       visited@    = *null;
       stackgrps@  = *null;

       if     %parms > 2
          and group0 <> '';
         MENUMGROUP = group0;
         exsr check;
       endif;
       if     %parms > 3
          and group1 <> '';
         MENUMGROUP = group1;
         exsr check;
       endif;
       if     %parms > 4
          and group2 <> '';
         MENUMGROUP = group2;
         exsr check;
       endif;
       if     %parms > 5
          and group3 <> '';
         MENUMGROUP = group3;
         exsr check;
       endif;
       if     %parms > 6
          and group4 <> '';
         MENUMGROUP = group4;
         exsr check;
       endif;
       if     %parms > 7
          and group5 <> '';
         MENUMGROUP = group5;
         exsr check;
       endif;
       if     %parms > 8
          and group6 <> '';
         MENUMGROUP = group6;
         exsr check;
       endif;
       if     %parms > 9
          and group7 <> '';
         MENUMGROUP = group7;
         exsr check;
       endif;
       if     %parms > 10
          and group8 <> '';
         MENUMGROUP = group8;
         exsr check;
       endif;
       if     %parms > 11
          and group9 <> '';
         MENUMGROUP = group9;
         exsr check;
       endif;

       return *off;

       begsr exit;
         if visited@ <> *null;
           dealloc(e) visited@;
         endif;
         if stackgrps@ <> *null;
           dealloc(e) stackgrps@;
         endif;
         return yes;
       endsr;

       begsr check;

         if isgroup;
           MENUMGMBRT = 0;
         else;
           MENUMGMBRT = 1;
         endif;
         MENUMGMBRN = member;

         // Check MENUMGROUP.
         exsr check_group;

         if not act;
           // Group MENUMGROUP not active.
           leavesr;
         endif;

         // Check if "member" is a member of one of the successors of
         // MENUMGROUP, recursively.

         // Array "visited" contains all groups already visited.
         // These can be skipped when encountered again. However
         // this shouldn't be necessary because cycles are detected
         // when storing groups.
         visited@ = %alloc(%size(visited)*chunksz);
         visited# = 1;
         visited(visited#) = MENUMGROUP;

         // Array "stackgrps" acts like a stack with the groups that
         // are already checked and active, and for which the successors
         // must be checked. The group at the top of the stack is the last
         // one that was checked. If all direct successors of MENUMGROUP
         // have been checked, and the active ones pushed onto the stack,
         // the top group is popped from the stack to check it's direct
         // successors.

         if not %open(CAPPSSAMF6);
           open CAPPSSAMF6;
         endif;

         stackgrps@   = *null;  // stack
         stackgrps#   = 0;      // # entries

         dow 0=0;

           // Check MENUMGROUP's direct successors.

           MENUMGMBRT = 0;
           setll (MENUMGROUP:MENUMGMBRT) CAPPSSAMF6;
           if %equal;

             dow 0=0;

               MENUMGMBRT = 0;
               reade (MENUMGROUP:MENUMGMBRT) CAPPSSAMF6;
               if %eof;
                 leave;
               endif;

               if %lookup(MENUMGMBRN:visited:1:visited#) = 0;

                 // Successor MENUMGMBRN; not been visited yet.

                 // Add successor to "visited".
                 if visited# >= %elem(visited);
                   leave;
                 elseif %rem(visited#:chunksz) = 0;
                   visited@ = %realloc(visited@
                                 :%size(visited)*(visited#+chunksz));
                 endif;
                 visited# = visited# + 1;
                 visited(visited#) = MENUMGROUP;

                 grp = MENUMGROUP;

                 MENUMGROUP = MENUMGMBRN;
                 if isgroup;
                   MENUMGMBRT = 0;
                 else;
                   MENUMGMBRT = 1;
                 endif;
                 MENUMGMBRN = member;
                 exsr check_group;

                 if act;

                   // Successor group is active, push onto the stack
                   // to check it's successors later.
                   if stackgrps# = 0;
                     stackgrps@ = %alloc(%size(stackgrps)*chunksz);
                   elseif stackgrps# >= %elem(stackgrps);
                     leave;
                   elseif %rem(stackgrps#:chunksz) = 0;
                     stackgrps@ = %realloc(stackgrps@
                                      :%size(stackgrps)*(stackgrps#+chunksz));
                   endif;
                   stackgrps# = stackgrps# + 1;
                   stackgrps(stackgrps#) = MENUMGROUP;

                 endif;

                 MENUMGROUP = grp;

               endif;

             enddo;

           endif;

           if stackgrps# = 0;
             leave;
           else;
             // Pop the next group of which the successors must be
             // checked from the stack.
             MENUMGROUP = stackgrps(stackgrps#);
             stackgrps# = stackgrps# - 1;
           endif;

         enddo;

         if visited@ <> *null;
           dealloc(e) visited@;
           visited@ = *null;
         endif;
         if stackgrps@ <> *null;
           dealloc(e) stackgrps@;
           stackgrps@ = *null;
         endif;

       endsr;

       begsr check_group;
         act = *on;
         if MENUMGROUP = CSgAll;
           yes = *on;
           exsr exit;
         elseif MENUMGROUP = CSgNone;
           leavesr;
         elseif     MENUMGROUP <> CSgAdmin
                and not IsGrpActive(MENUMGROUP);
           act = *off;
           leavesr;
         endif;
         if not %open(CAPPSSAMF4);
           open CAPPSSAMF4;
         endif;
         chain (MENUMGMBRT:MENUMGMBRN:MENUMGROUP) CAPPSSAMF4;
         if %found;
           yes = *on;
           exsr exit;
         endif;
       endsr;

      /end-free
     p                 e


     p GroupExists     b                   export
     d GroupExists     pi              n
     d   group                             const like(TAM_GROUP)

      /free

       if IsGrpSpecial(group);
         return *on;
       endif;

       if not %open(CAPPSSAMF3);
         open CAPPSSAMF3;
       endif;

       chain (group) CAPPSSAMF3;

       return %found;

      /end-free
     p                 e


     p GetGrpText      b                     export
     d GetGrpText      pi                    like(TAM_TEXT)
     d   group                               const like(TAM_GROUP)

      /free

       if IsGrpSpecial(group);
         return GetSpGrpText(group);
       endif;

       if not %open(CAPPSSAMF3);
         open CAPPSSAMF3;
       endif;

       chain (group) CAPPSSAMF3;

       if %found;
         return MENUGTEXT;
       endif;

       return '';

      /end-free
     p                 e


     p IsGrpActive     b                   export
     d IsGrpActive     pi              n
     d   group                             const like(TAM_GROUP)

      /free

       if IsGrpSpecial(group);
         return *on;
       endif;

       if not %open(CAPPSSAMF3);
         open CAPPSSAMF3;
       endif;

       chain (group) CAPPSSAMF3;

       return     %found
              and MENUGACT = 'Y';

      /end-free
     p                 e


     p RtvSuperGroups  b                   export
     d RtvSuperGroups  pi            10i 0
     d   group                             const like(TAM_GROUP)
     d   supergroups                   *
     d   active                        n   const options(*nopass)


     d chunksz         c                   20
     d count           s                   like(RtvSuperGroups)
     d stackgrps       s                   like(TAM_GROUP)   dim(32767)
     d                                     based(stackgrps@)
     d stackgrps#      s             10i 0
     d grp             s                   like(TAM_GROUP) based(grp@)
     d g               s             10i 0

      /free

       supergroups = *null;

       count = 0;

       if not %open(CAPPSSAMF4);
         open CAPPSSAMF4;
       endif;

       stackgrps@ = *null;  // stack
       stackgrps# = 0;      // # entries

       MENUMGMBRT = 0;
       MENUMGMBRN = group;

       dow 0=0;

         // Visit and count the supergroups (predecessors) of group
         // MENUMGMBRN, recursively.
         // Array "stackgrps" acts like a stack with the groups that
         // already have been visited, and for which the predecessors
         // must be visited. The group at the top of the stack is the
         // last one visited. If all direct predecessors of MENUMGMBRN
         // have been visited and pushed onto the stack, the top group
         // is popped from the stack to visit it's direct predecessors.

         // Visit MENUMGMBRN's direct predecessors.

         setll (MENUMGMBRT:MENUMGMBRN) CAPPSSAMF4;
         if %equal;

           dow 0=0;

             reade (MENUMGMBRT:MENUMGMBRN) CAPPSSAMF4;
             if %eof;
               leave;
             endif;

             if     MENUMGROUP <> group
                and (   %parms < 3
                     or not active
                     or IsGrpActive(MENUMGROUP));

               g = count;
               if g > 0;
                 grp@ = supergroups;
                 dow g > 0;
                   if grp = MENUMGROUP;
                     leave;
                   endif;
                   grp@ = grp@ + %size(grp);
                   g = g - 1;
                 enddo;
               endif;
               if g = 0;

                 // Predecessor MENUMGROUP; not been visited yet.

                 // Add to "supergroups".
                 if count = 0;
                   supergroups = %alloc(%size(grp)*chunksz);
                 elseif %rem(count:chunksz) = 0;
                   supergroups = %realloc(supergroups
                                     :%size(grp)*(count+chunksz));
                 endif;
                 grp@  = supergroups + count * %size(grp);
                 grp   = MENUMGROUP;
                 count = count + 1;

                 // Push predecessor group onto the stack to visit
                 // it's predecessors later.
                 if stackgrps# = 0;
                   stackgrps@ = %alloc(%size(grp)*chunksz);
                 elseif stackgrps# >= %elem(stackgrps);
                   leave;
                 elseif %rem(stackgrps#:chunksz) = 0;
                   stackgrps@ = %realloc(stackgrps@
                                    :%size(stackgrps)*(stackgrps#+chunksz));
                 endif;
                 stackgrps# = stackgrps# + 1;
                 stackgrps(stackgrps#) = MENUMGROUP;

               endif;

             endif;

           enddo;

         endif;

         if stackgrps# = 0;
           leave;
         else;
           // Pop the next group of which the predecessors must be
           // visited from the stack.
           MENUMGMBRN = stackgrps(stackgrps#);
           stackgrps# = stackgrps# - 1;
         endif;

       enddo;

       if stackgrps@ <> *null;
         dealloc(e) stackgrps@;
       endif;

       return count;

      /end-free
     p                 e


     p IsGroupUsed     b                   export
     d IsGroupUsed     pi            30
     d   group                             const like(TAM_GROUP)

     d cb              s              1s 0
     d t               s             20    varying

      /free

       if not %open(CAPPSSAMF4);
         open CAPPSSAMF4;
       endif;
       chain (0:group) CAPPSSAMF4;
       if %found;
         return 'group ' + MENUMGROUP;
       endif;

       if not %open(CAPPSSAMF5);
         open CAPPSSAMF5;
       endif;
       cb = I_SdaCurBin();
       setll (cb:group:0) CAPPSSAMF5;
       if %equal;
         return 'the menu';
       endif;
       reade (cb:group) CAPPSSAMF5;
       if not %eof;
         if MENUSGSLOT > 0;
           t = 'option ';
           if not %open(CAPPSSAMF1);
             open CAPPSSAMF1;
           endif;
           chain (cb:MENUSGPAGE:MENUSGSLOT) CAPPSSAMF1;
           if %found;
             t = t + %trim(MENUSCHC);
           else;
             t = t + '??';
           endif;
           t = t + ', page ' + %char(MENUSGPAGE);
         else;
           t = 'page ' + %char(MENUSGPAGE);
         endif;
         return t;
       endif;

       return '';

      /end-free
     p                 e


     pQds_AM_GroupAll  b                   export
     dQds_AM_GroupAll  pi             2  0
     d   data                                    likeds(Qds_AM_GroupAll$)
     d   group                             const like(TAM_GROUP)

      /free

       clear data;

       data.gmembers_n(*) = '';
       data.gmembers_t(*) = 0;
       data.gmembers#     = 0;
       data.dbgmembers    = 0;

       SetQdsDs(data
           :-99
           :RtvAMsgAB(1900:CAmsFatal));

       // Open all files needed in this procedure.
       if not %open(CAPPSSAMF3);
         open CAPPSSAMF3;
       endif;
       if not %open(CAPPSSAMF6);
         open CAPPSSAMF6;
       endif;

       // Read group.
       chain (group) CAPPSSAMF3;
       if not %found;
         SetQdsDs(data
             :-11
             :RtvAMsgAM(2551:CAmsFatal:%trimr(group))
             :CEfAMGROUP);
         return data.rc;
       endif;

       data.group = MENUGROUP;
       data.gtext = MENUGTEXT;
       data.gact  = MENUGACT;

       setll (data.group) CAPPSSAMF6;
       reade (data.group) CAPPSSAMF6;
       dow not %eof;
         data.dbgmembers = data.dbgmembers + 1;
         if data.gmembers# < CNumGrpMembers;
           data.gmembers# = data.gmembers# + 1;
           data.gmembers_n(data.gmembers#) = MENUMGMBRN;
           data.gmembers_t(data.gmembers#) = MENUMGMBRT;
         endif;
         reade (data.group) CAPPSSAMF6;
       enddo;

       if data.gmembers# < data.dbgmembers;
         SetQdsDs(data
             :11
             :RtvAMsgAM(2552:CAmsWarning:%trimr(group)
                  :%char(data.dbgmembers):%char(CNumGrpMembers))
             :CEfAMMBRN);
       else;
         SetQdsDs(data);
       endif;

       return data.rc;

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_DetectGroupCycle...
     p                 b                   export
     dI_DetectGroupCycle...
     d                 pi              n
     d   group                             const like(TAM_GROUP)
     d   subgroups                         const like(TAM_MBRN)
     d                                           dim(CNumGrpMembers)
     d   cyclegrp                                like(TAM_GROUP)
     d   cyclepath                   80

     d chunksz         c                   20
     d se              ds                  qualified
     d   grp1                              like(MENUMGROUP)
     d   grp2                              like(MENUMGROUP)
     d st1             s                   like(se) dim(32767) based(st1@)
     d st1#            s             10i 0
     d st1sz           s             10i 0
     d st2             s                   like(se) dim(32767) based(st2@)
     d st2#            s             10i 0
     d st2sz           s             10i 0
     d r               s               n
     d g               s                   like(MENUMGROUP)
     d i               s             10i 0
     d j               s             10i 0
     d v               s             80    varying

      /free

       r = *off;

       cyclegrp = '';
       cyclepath = '';

       if not %open(CAPPSSAMF4);
         open CAPPSSAMF4;
       endif;
       if not %open(CAPPSSAMF6);
         open CAPPSSAMF6;
       endif;

       st1@ = *null;
       st1# = 0;
       st1sz = 0;
       st2@ = *null;
       st2# = 0;
       st2sz = 0;

       for i = 1 to %elem(subgroups);
         if subgroups(i) <> '';
           se.grp1 = group;
           se.grp2 = '';
           exsr pushse1;
           dow st1# > 0;
             se = st1(st1#);
             setgt (0:se.grp1:se.grp2) CAPPSSAMF4;
             reade (0:se.grp1)         CAPPSSAMF4;
             if %eof;
               if se.grp2 = '';
                 se.grp1 = subgroups(i);
                 se.grp2 = '';
                 exsr pushse2;
                 exsr check;
                 dow st2# > 0;
                   se = st2(st2#);
                   setgt (se.grp1:0:se.grp2) CAPPSSAMF6;
                   reade (se.grp1:0)         CAPPSSAMF6;
                   if %eof;
                     st2# = st2# - 1;
                   else;
                     se.grp2 = MENUMGMBRN;
                     st2(st2#) = se;
                     se.grp1 = MENUMGMBRN;
                     se.grp2 = '';
                     exsr pushse2;
                     if st2sz >= %elem(st2);
                       leave;
                     endif;
                     exsr check;
                   endif;
                 enddo;
                 dealloc(e) st2@;
               endif;
               st1# = st1# - 1;
             else;
               se.grp2 = MENUMGROUP;
               st1(st1#) = se;
               se.grp1 = MENUMGROUP;
               se.grp2 = '';
               exsr pushse1;
               if st1sz >= %elem(st1);
                 leave;
               endif;
             endif;
           enddo;
           dealloc(e) st1@;
         endif;
       endfor;

       exsr exit;

       begsr exit;
         if st1@ <> *null;
           dealloc(e) st1@;
         endif;
         if st2@ <> *null;
           dealloc(e) st2@;
         endif;
         return r;
       endsr;

       begsr pushse1;
         st1# = st1# + 1;
         if st1# > st1sz;
           if st1sz = 0;
             st1@ = %alloc(%size(se)*chunksz);
           elseif st1sz >= %elem(st1);
             leavesr;
           elseif %rem(st1sz:chunksz) = 0;
             st1@ = %realloc(st1@:%size(se)*(st1sz+chunksz));
           endif;
           st1sz = st1#;
         endif;
         st1(st1#) = se;
       endsr;

       begsr pushse2;
         st2# = st2# + 1;
         if st2# > st2sz;
           if st2sz = 0;
             st2@ = %alloc(%size(se)*chunksz);
           elseif st2sz >= %elem(st2);
             leavesr;
           elseif %rem(st2sz:chunksz) = 0;
             st2@ = %realloc(st2@:%size(se)*(st2sz+chunksz));
           endif;
           st2sz = st2#;
         endif;
         st2(st2#) = se;
       endsr;

       begsr check;
         se = st2(st2#);
         g = se.grp1;
         for j = 1 to st1#;
           se = st1(j);
           if g = se.grp1;
             r = *on;
             cyclegrp = %trim(g);
             v = '';
             for i = 1 to st2#;
               se = st2(i);
               if i = 1;
                 v = %trim(se.grp1);
               else;
                 v = v + '>' + %trim(se.grp1);
               endif;
               if %len(v) >= %len(cyclepath);
                 leave;
               endif;
             endfor;
             i = j - 1;
             dow     i >= 1
                 and %len(v) < %len(cyclepath);
               se = st1(i);
               v = v + '>' + %trim(se.grp1);
               i = i - 1;
             enddo;
             cyclepath = v;
             if %len(v) > %len(cyclepath) - 3;
               %subst(cyclepath:%len(cyclepath)-2) = '...';
             endif;
             exsr exit;
           endif;
         endfor;
       endsr;

      /end-free
     p                 e


     pI_RlsModDQ       b                   export
     dI_RlsModDQ       pi

      /free

       close(e) *ALL;

       return;

      /end-free
     p                 e

