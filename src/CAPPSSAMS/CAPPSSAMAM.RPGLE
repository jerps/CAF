
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module AM for *SRVPGM CAPPSSAM


       // Service Program: Common App Services / SubSystem AppMenu
       // Module         : Application Messages


       // All available messages are contained in compile-time array "AppMsg",
       // defined in the module. Each message text starts with its unique
       // 4-digit number, a colon and a space.

       // The first element of "AppMsg" contains the array length (the first
       // three characters) and the number of elements (the next four chars).


      /DEFINE CAPPSSAM_MODULE
      /DEFINE CAPPSSAM_CAPPSSAMAM

      /include CAPPSSAMS,INCL__MODH


      /include CAPPSSAMS,INCL_AM
      /include CAPPBASES,INCL_API
      /include CSYSBASES,INCL_API

      /include CAPPSSAMS,INCL__AM

      /include CAPPSSAMS,INCL__MODD


       // Subsystem id.
     d Subsysid        c                   'AM'


       // Application messages.
     d AppMsg          s            100    ctdata dim(200)


       // ----- Implementation


     p RtvAMsgAM       b                   export
     d RtvAMsgAM       pi           200
     d   id                           4  0 const
     d   sev                          1    const         options(*nopass:*omit)
     d   subst1                     200    const varying options(*nopass)
     d   subst2                     200    const varying options(*nopass)
     d   subst3                     200    const varying options(*nopass)
     d   subst4                     200    const varying options(*nopass)
     d   subst5                     200    const varying options(*nopass)
     d   subst6                     200    const varying options(*nopass)
     d   subst7                     200    const varying options(*nopass)
     d   subst8                     200    const varying options(*nopass)
     d   subst9                     200    const varying options(*nopass)

     d msg             s            200

      /free

       msg = GetBuffldId(%addr(AppMsg):%editc(id:'X'));
       if msg = '';
         msg = *all'?';
         %subst(msg:1:%len(id)) = %editc(id:'X');
       endif;
       select;
       when %parms > 10;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6:subst7:subst8:subst9);
       when %parms > 9;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6:subst7:subst8);
       when %parms > 8;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6:subst7);
       when %parms > 7;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5:subst6);
       when %parms > 6;
         msg = SubstText(msg:subst1:subst2:subst3:subst4
                            :subst5);
       when %parms > 5;
         msg = SubstText(msg:subst1:subst2:subst3:subst4);
       when %parms > 4;
         msg = SubstText(msg:subst1:subst2:subst3);
       when %parms > 3;
         msg = SubstText(msg:subst1:subst2);
       when %parms > 2;
         msg = SubstText(msg:subst1);
       endsl;
       if     %parms > 1
          and %addr(sev) <> *null
          and sev <> '';
         return Subsysid + sev + msg;
       else;
         return Subsysid + CAmsInfo + msg;
       endif;

       return '';

      /end-free
     p                 e


       // ----- Implementation - Internal


     pI_RlsModAM       b                   export
     dI_RlsModAM       pi

      /free

       return;

      /end-free
     p                 e


** AppMsg
1000200

1001: The menu is not loaded.
1003: The menu is not loaded for user "%1".
1011: Can not update or save the menu if it's loaded for a specific user.
1012: Can not load authorisation data; the menu is loaded for a specific user.
1021: Can not save menu; group %1 in the menu does not exist.
1022: Can not save menu; group %1 in page %2 does not exist.
1023: Can not save menu; group %1 for option %2 in page %3 does not exist.

1901: No command or command handler executed.
1990: The current user (%2) is not authorised to perform option "%1".
1998: CAPPSSAMCH: %1
1999: ERROR: %1

2001: An option (or header) must have a text.
2002: A header can not be directly preceded or followed by a non-empty slot.
2003: A header can only have a text and no other attributes.
2004: The command is too long (maximum is %1 characters).
2005: Special behavior character "%1" is not supported for an option.
2006: Special behavior character "%1" is not supported for a page.
2007: Special behavior character "%1" is not supported for the menu.
2008: Group "%1" occurs more than once.
2009: Group "%1" does not exist in the database.
2010: Group inversion character is not directly followed by a group name.
2013: An option can not be directly preceded or followed by a header.
2021: Enter 1, 2, 3, 4 or 5 for command sequence.

2111: To move options/headers down, the bottom slot must be empty.
2112: No room to move options/headers up; already at top.
2113: No room to move options/headers up.
2114: No room to move options/headers up; blank line must follow header.
2115: No room to move options/headers up; blank line must precede header.
2116: There are no options/headers to move.
2121: The slot does not contain an option or header.
2122: The slot does not contain an option.
2151: To move pages right, the last page (%1) must be blank.
2152: Can not move page 1 to the left.
2153: To move page %1 to the left, page %2 must be blank.
2154: Can not move the last page to the right.

2501: Group name must start with an uppercase letter.
2502: Group text must start with a non-blank character.
2503: Group active must be "Y" or "N".
2504: Member "%1" does not start with a non-blank character.
2505: Group "%1" is specified more than once.
2506: User-id "%1" is specified more than once.
2507: Unknown group member type %1 for member "%2".
2508: Group "%1" does not exist.
2509: Cycle detected on "%1": %2
2510: User-id "%1" starts with a hyphen ("-") which is not allowed.
2511: Can not delete group "%1"; it is used in %2.
2513: Group "%1" can not be a member of itself.
2514: Group "%1" is always active.
2541: Special group "%1" can not be deleted.
2551: Group "%1" not found.
2552: Group "%1" has %2 members in the database; only %3 have been read.
2591: Can not add group "%1"; it already exists.
2592: Can not update group "%1"; it does not exist (anymore).
2593: Can not delete group "%1"; it does not exist (anymore).

3001: Page %1 does not exist.
3002: Slot %1 does not exist.
3003: Could not create blank page %1.
3004: Page %1 is blank.

5001: The menu has been saved.
5002: Empty menu; no options.
5003: There is no slot on this cursor location.
5004: The menu has not been loaded yet.
5005: This page is blank.
5006: This page is blank; nothing to clear.
5007: The slot is empty; nothing to delete.
5008: The menu is NOT updated; press enter to save anyway.
5009: This is the first page.
5010: This is the last page.
5011: The last menu page is already displayed.
5012: The first menu page is already displayed.
5013: This page is blank; nothing to move.
5014: Previous non-blank page not found.
5015: Next non-blank page not found.
5016: This page is blank; nothing to choose.
5018: No option with choice "%1" found on the current page.
5019: There are %1 options with choice "%2" on the current page.
5020: Option "%1" not performed; no confirmation.
5021: Edit slot %2 on page %1.
5022: Edit option attributes in slot %2 on page %1.
5023: Edit attributes for page %1.
5024: Edit MENU ATTRIBUTES.
5025: The menu has been updated; press enter to save the menu.
5031: Place the cursor on the option to be performed and press enter.
5032: Place the cursor on the option to be edited and press enter.
5041: Press F6 with cursor on a slot to copy slot %1, page %2; F12 to cancel.
5042: Press F6 to copy page %1 to the current page; F12 to cancel.
5043: Press F21 with cursor on a vertical strip to swap with %1 strip.
5044: Press F6 with cursor on an option or header to copy.
5045: Press F21 with cursor on a vert. strip to swap with another vert. strip.
5050: The chosen option is not visible; press F9 first and try again.
5051: Page number not recognized.
5053: Can not edit slot; command is too long (%1 > %2).
5054: Can not edit page attributes; command is too long (%1 > %2).
5055: Can not edit menu attributes; command is too long (%1 > %2).
5059: Can not edit slot; it is directly followed or preceded by a header.
5061: Enter "YES" to force reload for all users, else enter "NO".
5062: Place the cursor on a group field first.
5063: There is no room to insert a blank group at the cursor location.
5080: Enter a command to prompt.
5081: Prompt error; no command returned.
5082: Prompt error; returned command too long.
5090: The menu has been updated; press F5 to RELOAD first.

5101: Press F3 again to EXIT MENU.
5103: Press F2 again to SAVE MENU.
5105: The menu has been UPDATED; press F5 again to RELOAD MENU.
5111: Press F14 again to CLEAR PAGE (and delete all options/headers on it).
5112: Press F14 again to DELETE OPTION.
5113: Press F14 again to DELETE HEADER.
5120: About to REPLACE OPTION with header: press enter again to CONFIRM.
5131: CANCELLED copy page.
5132: CANCELLED copy option.
5133: CANCELLED copy header.
5134: CANCELLED swap vertical strip.

5200: OPTION "%1" has been PERFORMED.
5201: Slot %2 on page %1 has been SET to HEADER "%3".
5202: Slot %2 on page %1 has been SET to OPTION "%3".
5203: The attributes of page %1 have been UPDATED.
5204: Page %1 has been CLEARED.
5205: OPTION "%1" on page %2, slot %3 has been DELETED.
5206: HEADER "%1" on page %2, slot %3 has been DELETED.
5207: The MENU has been SAVED; authorizations have been reloaded.
5208: The MENU has been LOADED.
5209: The AUTHORISATIONS have been RELOADED.
5211: The SLOTS have been MOVED.
5212: Non-blank page FOUND.
5213: The MENU attributes have been UPDATED.
5214: Opts/hdrs page %1 REPLACED with opts/hdrs page %2.
5215: Swapped %1 and %2 vertical strip.
5221: The PAGES have been MOVED to the LEFT.
5222: The PAGES have been MOVED to the RIGHT.

6001: Too many members specified; a maximum of %1 is allowed.
6002: DATABASE CONTAINED TOO MANY MEMBERS (%1); CAN NOT PROCEED.
6011: Group "%1" is specified more than once.
6012: User-id "%1" is specified more than once.
6013: Group name can not be blank.

9001: Database ERROR trying to add menu group; SEE JOB LOG.
9002: Database ERROR trying to update menu group; SEE JOB LOG.
9003: Database ERROR trying to delete menu group; SEE JOB LOG.
9004: Database ERROR trying to delete menu group members; SEE JOB LOG.
9005: Database ERROR trying to add menu group members; SEE JOB LOG.

9901: Could not load the menu; error trying to access data area %1.
9902: Could not save the menu; error trying to access data area %1.
9903: A database error occurred while saving the menu; try again.

