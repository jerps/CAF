
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Program CAPPDISPP0


       // Service Program: Common App Services / Display
       // Program        : Load Initial Data


      /include QINCSRC,PGM_HEAD1


     fCAPPDISPF1if a e           k disk


     d Main            pr                  extpgm('CAPPDISPP0')
     d   inif1                        1    const


     d HelpText        s             60    ctdata dim(12)


     d Main            pi
     d   inif1                        1    const

     d i               s             10i 0

      /free

       *inlR = *on;

       if inif1 = '1';
         // Add help text.
         for i = 1 to %elem(HelpText);
           clear *all HLPTREC;
           HLPTSEQ# = i;
           HLPTEXT  = HelpText(i);
           write HLPTREC;
         endfor;
       endif;

       return;

      /end-free


** HelpText
   F1  = Help
   F3  = Exit
   F4  = Select item
   F5  = Refresh
   F9  = Resize screen (normal/wide)
   F10 = Go to next cursor location
   F12 = Cancel
   F17 = Go to top, or first page/screen
   F18 = Go to bottom, or last page/screen
   F22 = Show all messages (cursor on messages)
  PgUp = previous page/screen
PgDown = next page/screen
