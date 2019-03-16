
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Declare the work fields needed by this include member (IMWF__)
     c     DECL_IMWF__   begsr
     c                   z-add     0             IMWF__I           6 0
     c                   z-add     0             IMWF__J           6 0
     c                   z-add     0             IMWF__X           6 0
     c                   z-add     0             IMWF__Y           6 0
     c                   z-add     0             IMWF__Z           6 0
     c                   z-add     0             IMWF__N           6 0
     c                   move      '0'           IMWF__F           1
     c                   move      *blanks       IMWF__A012       12
     c                   move      *blanks       IMWF__A012X      12
     c                   move      *blanks       IMWF__A100      100
     c                   endsr


      /free


       // Add all message error field/attribute names associated
       // with "DspMsg" and "DspMsgList" to "Err.flds".
       begsr AddAssocErrFlds;
         IMWF__A100 = GetAssocDspMsgData(0);
         if IMWF__A100 <> '';
           for IMWF__J = 17 to 89 by 12;
             IMWF__A012 = %subst(IMWF__A100:IMWF__J:12);
             if IMWF__A012 <> '';
               L_AddErrFld(IMWF__A012);
             endif;
           endfor;
         endif;
         for IMWF__I = 1 to %elem(DspMsgList);
           if DspMsgList(IMWF__I) = '';
             leavesr;
           endif;
           IMWF__A100 = GetAssocDspMsgData(IMWF__I);
           if IMWF__A100 <> '';
             for IMWF__J = 17 to 89 by 12;
               IMWF__A012 = %subst(IMWF__A100:IMWF__J:12);
               if IMWF__A012 <> '';
                 L_AddErrFld(IMWF__A012);
               endif;
             endfor;
           endif;
         endfor;
       endsr;


       // Set error indicators for the field/attribute names specified
       // in "Err.flds" to *on, as specified in array "FEMap".
       begsr SetErrFldsInd;

         for IMWF__I = 1 to %elem(Err.flds);
           IMWF__A012 = Err.flds(IMWF__I);
           if IMWF__A012 <> '';
             for IMWF__J = 1 to %elem(FEMap);
               IMWF__A012X = FEMap(IMWF__J);
               if IMWF__A012X <> '';
                 IMWF__N = 1;
                 dow IMWF__N <= %len(IMWF__A012X);
                   if    %subst(IMWF__A012X:IMWF__N:1) = '?'
                      or %subst(IMWF__A012X:IMWF__N:1) =
                           %subst(IMWF__A012:IMWF__N:1);
                     IMWF__N = IMWF__N + 1;
                   else;
                     leave;
                   endif;
                 enddo;
                 if IMWF__N > 12;
                   IMWF__N = CvtTxtToInt(%subst(FEMap(IMWF__J)
                                               :%len(IMWF__A012X)+1:2));
                   if     IMWF__N > 30
                      and IMWF__N < 70;
                     *in(IMWF__N) = *on;
                     SetCurs = *off;
                   endif;
                   leave;
                 endif;
               endif;
             endfor;
           endif;
         endfor;

       endsr;


       // Set cursor on next location.
       begsr SetNextCursLoc;

         IMWF__N = *hival;
         IMWF__J = 0;
         IMWF__Z = 0;

         for IMWF__I = 1 to %elem(CursLocs);
           if     CursLocs(IMWF__I) <> ''
              and (   %subst(CursLocs(IMWF__I):1:1) = ''
                   or DspWide and %subst(CursLocs(IMWF__I):1:1) = 'W'
                   or not DspWide and %subst(CursLocs(IMWF__I):1:1) = 'N')
              and (   %subst(CursLocs(IMWF__I):2:1) = ''
                   or Screen = CvtTxtToInt(%subst(CursLocs(IMWF__I):2:1)));
             if IMWF__J = 0;
               IMWF__J = IMWF__I;
             endif;
             if IMWF__Z = 0;
               IMWF__Z = IMWF__I;
             endif;
             IMWF__X = CvtTxtToInt(%subst(CursLocs(IMWF__I):5:3));
             IMWF__Y = CvtTxtToInt(%subst(CursLocs(IMWF__I):3:2));
             if     CursRow = IMWF__Y
                and CursCol = IMWF__X;
               IMWF__N = 0;
               IMWF__Z = 0;
             elseif     CursRow = IMWF__Y
                    and CursCol < IMWF__X
                    and IMWF__N > IMWF__X - CursCol;
               IMWF__N = IMWF__X - CursCol;
               IMWF__Z = IMWF__I;
             elseif     IMWF__N = *hival
                    and (   CursRow < IMWF__Y
                         or     CursRow = IMWF__Y
                            and CursCol < IMWF__X);
               IMWF__N = IMWF__N - 1;
               IMWF__Z = IMWF__I;
             endif;
           endif;
         endfor;

         if     IMWF__J = 0
            and IMWF__Z = 0;
           SetCurs = *off;
         elseif IMWF__Z > 0;
           CursRow = CvtTxtToInt(%subst(CursLocs(IMWF__Z):3:2));
           CursCol = CvtTxtToInt(%subst(CursLocs(IMWF__Z):5:3));
           SetCurs = *on;
         else;
           CursRow = CvtTxtToInt(%subst(CursLocs(IMWF__J):3:2));
           CursCol = CvtTxtToInt(%subst(CursLocs(IMWF__J):5:3));
           SetCurs = *on;
         endif;

       endsr;


      /end-free

