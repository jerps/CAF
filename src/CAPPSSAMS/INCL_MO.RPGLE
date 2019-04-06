
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_MO)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_MO


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module MO: Menu Operations


       // This module is used to load the complete menu definition from
       // the database into memory, query and/or update the definition
       // (e.g. by adding a new option) and save the (updated) menu
       // definition back to the database.

       // The first procedure which must be called is "MnuLoadMenu" which
       // loads the complete menu definition in memory. Then, if something
       // has been updated, procedure "MnuSaveMenu" is called to save the
       // changed definition to the database.

       // The menu definition can only be updated (and saved) when the
       // complete menu definition is loaded. I.e. with all options for
       // all users, by calling "MnuLoadMenu" without a specific "user".
       // If the menu is loaded for a specific "user" then only those
       // options are loaded for which the user is authorised. I.e. all
       // options with one or more groups - which includes the groups
       // specified for the page containing the option and the groups
       // specified for the menu - of which the user or one of it's
       // group profiles is a member.

       // The complete menu definition consists of all "CNumPages" pages
       // in array "MenuPages" with the available options and headers, and
       // the groups and other attributes specified for the menu, pages and
       // options. The menu attributes are contained in data structure "Menu",
       // and the page and option attributes are contained in instances of
       // data structure "MenuPage" and "MenuOption", resp.

       // Groups (and some other attributes) which are specified for the menu
       // have the same effect as if they were specified for all pages, and
       // the groups (and some other attributes) which are specified for a
       // page have the same effect as if they were specified for all options
       // on that page.

       // If an option does not have any groups specified for it in table
       // CAPPSSAMF2 (which should not be allowed), and there are also no
       // groups specified for the page containing the option, and there are
       // no groups specified for the menu, then the option is only loaded
       // when the menu is loaded with all options for all users and never
       // if the menu is loaded for a specific user.

       // The following "special" groups - defined with constants "CSg*" -
       // are "built in" (they are not necessarily represented with an
       // entry in the database) and have the following special meaning:
       //   *ADMIN   - Users which are member of this group have admini-
       //              strative privileges. This means for example that
       //              only users in this group are allowed to load a menu
       //              with all options for all users, make updates, and
       //              save the menu. Other users are only allowed to load
       //              and display the menu and perform an option (such as
       //              *DISPLAY mode in program CAPPMENU). This module does
       //              not check whether update operations are allowed for
       //              the user as this is the resposibility of the client
       //              application, such as CAPPMENU.
       //   *ALL     - Every user is - by definition - a member of this
       //              group. Specifying this group for an option means
       //              that it is available for every user.
       //              Explicitly adding users to this group has no effect.
       //   *NONE    - This group has - by definition - no members, and
       //              specifying this group for an option has no effect.

       // A group can be specified for an option (or page or menu prefixed
       // with an exclamation mark (!), which means "not" or "inverse". For
       // example, the members of group !*ADMIN are all users that are NOT
       // a member of group *ADMIN. Group !*ALL is the same as *NONE and
       // vice versa.

       // The groups and their members, i.e. the authorisation data which
       // determines the allowable options for a user, are not part of the
       // menu definition. This information is checked against the database
       // when the menu is being loaded for a specific user, to determine
       // which options are allowed for that user (only these are loaded).
       // If the menu is loaded with all options for all users then all
       // groups and their members are also loaded from the database into
       // memory using procedure "MnuLoadAuth". Updates in the database to
       // these groups and members (e.g. a new group is added or a user-id
       // is removed from a group) are not reflected until "MnuLoadAuth"
       // is called again, or indirectly by calling "MnuLoadMenu" or
       // "MnuSaveMenu".

       // Because several users may want to read and/or update the menu
       // definition at the same time a special data area, CAPPSSAMA0, is
       // used to synchronize access to the stored menu definition. Every
       // time, while the menu is being loaded or saved with "MnsLoadMenu"
       // "MnsSaveMenu" resp., the data area is first read with *LOCK and
       // when the procedure ends the data area is released again. This
       // ensures the integrity of the stored and in-memory menu definition,
       // because only one user at a time accesses the menu definition in
       // the database.

       // Data area CAPPSSAMA0 not only synchronizes access to the menu
       // definition, it also contains the following global menu data.
       //    1 -  8  : Current menu version
       //              An 8-digit version counter which is increased by 1
       //              each time the menu is saved with "MnuSaveMenu". It
       //              is intialized to "00000000" if positions 1-8 do not
       //              contain 8 digits. The counter rolls over to "00000000".
       //              This version counter is used to determine whether the
       //              menu definition has been changed in the database since
       //              it was last read with "MnuLoadMenu" (see procedure
       //              "MnuVersionChanged").
       //    9 - 16  : Reload version
       //              An 8 digit number indicating that all users who
       //              currently have loaded the menu with a version counter
       //              that is less than the "reload" version MUST reload
       //              the menu definition (see proc. "MnuForceReload").
       //              It is up to the client application to enforce this.
       //              If positions 9-16 do not contain 8 digits, the reload
       //              version is assumed to be 00000000 (i.e. no reload).
       //   19 - 19  : The current bin number
       //              When the menu is saved to the database it is stored
       //              in bin 0 or bin 1. Position 19 of the data area
       //              contains the current bin, which is either "0" or "1".
       //              The current bin contains the last saved menu, and the
       //              other ("old") bin contains the previous version. Each
       //              time the menu is saved it is saved into the other bin
       //              (which is 0 if the current is 1, and vice versa). This
       //              is done so that if something goes wrong while saving,
       //              the current menu definition is not corrupted. When the
       //              complete menu definition has been saved into the other
       //              bin successfully, position 19 of the data area is
       //              updated with this other bin number, which then becomes
       //              the current one. The old menu definition is retained
       //              in (what is now) the other bin.
       //              If position 19 does not contain a "0" or a "1" it is
       //              assumed to be "0".
       //   21 - 30  : User which last saved the menu.

       // The loaded menu definition is represented with array "MenuPages",
       // which contains all "CNumPages" pages of the menu. The menu always
       // has "CNumPages" pages. A page can be empty (i.e. it contains no
       // options or headers), or not. The array is exported to be easily
       // accessible for applications. However, all updates to the menu, a
       // page or an option or header should be done through the procedures
       // that are exported from this module, not by directly manipulating the
       // internal menu data structures, like "Menu" or "MenuPage".

       // This module is primarily for program CAPPMENU, which is used to
       // present and/or update the menu on a 5250 screen. The menu structure,
       // i.e. the "CNumPages" pages and the fixed number and locations of the
       // slots on these pages, is influenced by the way the menu is presented
       // with CAPPMENU on a 5250 "green screen" display.

       // The names of the public procedures in this module are all prefixed
       // with "Mnu".


      /include CAPPSSAMS,INCL_DEFS


       // ----- Data Structures

       // Data structure "Menu" contains attributes which apply to the menu
       // as a whole.
     d Menu            ds                  qualified
      /IF DEFINED(CAPPSSAM_CAPPSSAMMO)
     d                                     inz
     d                                     export('Menu')
      /ELSE
     d                                     import('Menu')
      /ENDIF
     d   title                             like(TAM_MTEXT)
     d   groups                      16    dim(CNumGroups)
     d   specb                             like(TAM_SPECB)
     d   command                       *

       // Array "MenuPages" contains all pages, with the options and headers.
       // Each element is a menu page, pointing to an instance of data-
       // structure "MenuPage". A *null element is considered a blank page.
     d MenuPages       s               *   dim(CNumPages)
      /IF DEFINED(CAPPSSAM_CAPPSSAMMO)
     d                                     export('MenuPages')
      /ELSE
     d                                     import('MenuPages')
      /ENDIF

       // Each instance of data structure "MenuPage" represents one menu
       // page with a title, options and headers. Each page has "CNumSlots"
       // slots, which are placeholders for menu options and headers, and
       // is represented with array "slots". The options in a page are
       // divided into three equal parts which are displayed as three
       // vertical strips on the screen: left, middle and right. The right
       // strip is only visible in *WIDE screen mode. Each element of array
       // "slots" represents a slot which is either empty (*null), or it
       // contains an option (or header). Each slot corresponds to a strip
       // and a vertical position (row) on the screen (the location). In
       // *UPDATE mode, the options (and headers) are always displayed on
       // the fixed location (left, middle or right strip, and row) that
       // corresponds to the slot containing the option, unless display
       // mode is simulated. In *DISPLAY mode the location on which an
       // option (or header) is presented on screen is variable and depends
       // on the available options for that user. In *DISPLAY mode, the menu
       // is displayed without empty pages (i.e. pages with only empty slots
       // or no available options), and without gaps (empty rows) between
       // options on a vertical strip). An element in array "slots" which is
       // not *null points to an instance of "MenuOption", representing one
       // menu option or header.
     d MenuPage        ds                  qualified based(MenuPage@)
     d   title                             like(TAM_MTEXT)
     d   slots                         *   dim(CNumSlots)
     d   groups                      16    dim(CNumGroups)
     d   specb                             like(TAM_SPECB)
     d   command                       *

       // Each instance of data structure "MenuOption" represents one menu
       // option. If "choice" is blank, the instance represents a header.
       // It is not necessary for "choice" to have a unique value. However,
       // to be able to select an option by entering it's choice, it must
       // be unique among all other options within the same page.
     d MenuOption      ds                  qualified based(MenuOption@)
     d   choice                            like(TAM_MCHC)
     d   text                              like(TAM_MTEXT)
     d   groups                      16    dim(CNumGroups)
     d   specb                             like(TAM_SPECB)
     d   command                       *


       // ----- Prototypes

       // MnuLoadMenu - Load Menu
       // Load the complete menu definition from the database into memory
       // for "user" (populate/fill the "Menu*" data structures).
       // If the menu has already been loaded it is replaced with the most
       // current version.
       // Calling this procedure always first clears the current menu in
       // memory.
       // Only load the allowable options. If "user" is not given or blank
       // then all options for all users are loaded. Updates to the menu
       // definition are only possible if all options for all users have
       // been loaded.
       // The authorisations (i.e. which users belong to which groups) are
       // read only once from the database when the menu is being loaded,
       // to determine the allowable options. Updates (e.g. a new group is
       // added or a user is removed from a group) are not reflected, until
       // the menu is loaded again. If the menu is loaded with all options
       // for all users then procedure "MnuLoadAuth" is called which loads
       // all authorisation data (all groups and users) into memory at once
       // for later use (e.g. in proc. "MnuOptAllowed"). In this case, proc.
       // "MnuLoadAuth" can be called again to explicitly reload this data.
     d MnuLoadMenu     pr                  extproc('MnuLoadMenu')
     d   user                        10    const options(*nopass)

       // MnuGetSlotChoice - Get Slot with Choice
       // Return the slot which contains the option on page "pag" having
       // "choice". The option must be the only one with "choice" on the
       // same page. Return 0 if "choice" is blank, or if there is no option
       // on page "pag" with "choice", or if there are two or more options
       // with the same "choice" on page "pag". If "count" is given, the
       // number of options on page "pag" with "choice" is returned (which
       // is always 1 if a slot is returned).
     d MnuGetSlotChoice...
     d                 pr            10i 0 extproc('MnuGetSlotChoice')
     d   pag                         10i 0 const
     d   choice                       2    const
     d   count                       10i 0       options(*nopass)

       // MnuPerformOpt - Perform option
       // Perform the option in the "slot" on page "pag", if the slot contains
       // an option, and is allowed for the current user ("PSI.curuser").
       // An option is always allowed to be performed if the menu has been
       // loaded with all options for all users.
       // An option is never allowed if the menu has been loaded for a specific
       // user which is different from the current user.
       // If the menu is loaded for a specific user which is the same as the
       // current user, procedure "MnuOptAllowed" is called to check whether
       // the option is allowed for the current user. Procedure "MnuOptAllowed"
       // is called with option "*CURRENT" so that the most current authorisa-
       // tion data in the database is used.
       // The option is performed by executing up to three commands, i.e. the
       // command specified for the menu, the page and the option. If blanks
       // are specified for a command nothing is executed. Except when special
       // behavior code "CMsbUseCH" (use command handler) is specified. In this
       // case the handler is executed with a blank command.
       // The up to three commands (menu/page/option) are all executed in
       // a specific order. The order is specified with special behavior codes
       // "CMsbPCS1" thru "CMsbPCS5". First all commands for which special
       // behavior code "CMsbPCS1" is specified (on the menu, page or option)
       // Then all commands for which "CMsbPCS2" is specified, etc, up to
       // "CMsbPCS5". This way, if more then one "CMsbPCS" code is specified,
       // a command may be executed more than once. If different commands,
       // specified for the menu, page or option, have the same "CMsbPCS"
       // code specified then they are all executed in the order menu, page
       // option when the commands for that code are executed. If a menu,
       // page or option does not specify a "CMsbPCS" code then "CMsbPCS3"
       // is assumed.
       // Special behavior "CMsbConfPO" (confirm perform option) is ignored.
       // It is the responsibility of the client program to present the user
       // with a confirmation screen (or not).
       // Return *off with fatal message AMF1901 if no command has been
       // executed or the command handler has not been executed.
       // Return *off with fatal message AMF1990 if the option is not allowed.
       // Return *off with fatal message AMF1999 if an error occurs while
       // the commands specified for the menu, the page and the option are
       // executed. If special behavior code "CMsbUseCH" (use command handler)
       // is specified for the option, the page or the menu then the commands
       // are executed by calling program CAPPSSAMCH. If it reports an error
       // then return *off with fatal message AMF1998.
       // If an error occurs when executing a command then the rest of the
       // commands are not executed.
       // Return *on if successful, else return *off and set "errmsg" to the
       // error message.
     d MnuPerformOpt   pr              n   extproc('MnuPerformOpt')
     d   errmsg                     200
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuLoadAuth - Load Authorisations
       // Load all authorisation data (i.e. all groups and members) into
       // memory. Replace the authorisation data previously loaded into
       // memory.
       // The authorisation data can only be loaded if the menu is loaded
       // with all options for all users.
     d MnuLoadAuth     pr                  extproc('MnuLoadAuth')

       // MnuIsLoaded - Is Loaded
       // Return *on if the menu has been loaded with "MnsLoadMenu",
       // else return *off.
     d MnuIsLoaded     pr              n   extproc('MnuIsLoaded')

       // MnuIsUpdated - Is Updated
       // Return *on if the menu definition has been updated in memory
       // since it was loaded, else return *off. Always return *off
       // if the menu was loaded for a specific user.
     d MnuIsUpdated    pr              n   extproc('MnuIsUpdated')

       // MnuVersionChanged - Version Changed
       // Return *on if the version counter that was read from data area
       // CAPPSSAMA0 (pos. 1-8) when the menu was loaded with procedure
       // "MnuLoadMenu" is different from the current version number
       // stored in the data area, else return *off.
     d MnuVersionChanged...
     d                 pr              n   extproc('MnuVersionChanged')

       // MnuMustReload - Must Reload
       // Return *on if the version counter that was read from data area
       // CAPPSSAMA0 (pos. 1-8) is less than the number that is currently
       // stored in positions 9-16 in data area CAPPSSAMA0, else return
       // *off. Always return *off if pos. 9-16 in data area CAPPSSAMA0
       // does not contain only digits.
     d MnuMustReload   pr              n   extproc('MnuMustReload')

       // MnuSaveMenu - Save Menu
       // Save the complete menu definition from memory to the database.
       // For safety, procedure "MnuValNormMenu" is always called first,
       // to validate and normalize the menu, before it is saved. If an
       // error is found then "errattr", "errpage", "errslot" contain the
       // attribute/page/slot in error (see "MnuValNormMenu" for info).
       // Increase the current version counter in positions 1-8 in data
       // area CAPPSSAMA0 by 1.
       // If parameter "option" is given with value "*RELOAD", then the
       // increased version counter is written to positions 9-16 of the
       // data area, which indicates that other users who currently have
       // loaded the menu are (or should be) forced to reload the menu.
       // Return *on if successful, else return *off and set "errmsg"
       // to an appropriate error message.
       // The menu can only be saved if it has been loaded with all
       // options for all users (with no or blank "user").
     d MnuSaveMenu     pr              n   extproc('MnuSaveMenu')
     d   errmsg                     200
     d   option                      10    const options(*nopass:*omit)
     d   errattr                     10          options(*nopass)
     d   errpage                     10i 0       options(*nopass)
     d   errslot                     10i 0       options(*nopass)

       // MnuSetMenuAttr - Set Menu Attributes
       // Update the menu's attributes in data structure "Menu", using the
       // given parameter values  ("m...").
       // Validate the updated menu.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message and set "errattr" to the name of the
       // attribute in error (may be left blank if no specific attribute).
       // The following is a list of the attributes which can be in error:
       //   MTITLE   - menu title
       //   MGROUP1  - menu group 1
       //   MGROUP2  - menu group 2
       //   MGROUP3  - menu group 3
       //   MGROUP4  - menu group 4
       //   MGROUP5  - menu group 5
       //   MGROUP6  - menu group 6
       //   MGROUP7  - menu group 7
       //   MGROUP8  - menu group 8
       //   MGROUP9  - menu group 9
       //   MSPECB   - menu special behaviors
       //   MCOMMAND - menu command
     d MnuSetMenuAttr  pr              n   extproc('MnuSetMenuAttr')
     d   errmsg                     200
     d   errattr                     10
     d   mtitle                            const like(Menu.title)
     d                                           options(*nopass:*omit)
     d   mgroups                           const like(Menu.groups)
     d                                           dim(CNumGroups)
     d                                           options(*nopass:*omit)
     d   mspecb                            const like(Menu.specb)
     d                                           options(*nopass:*omit)
     d   mcommand                   500    const options(*nopass:*omit)

       // MnuGetPageTitle - Get Page Title
       // Return the title of page "pag".
       // Return blanks if the page does not exist.
     d MnuGetPageTitle...
     d                 pr                  like(MenuPage.title)
     d                                     extproc('MnuGetPageTitle')
     d   pag                         10i 0 const

       // MnuSetPageAttr - Set Page Attributes
       // Create a new page or update an existing page, at index "pag of
       // array "MenuPages", using the given parameter values  ("p...").
       // If the element is empty, create a new page with the given
       // attribute values. If the element is not empty, update the
       // page's attributes for which a parameter is given.
       // Validate the new or updated page.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message and set "errattr" to the name of the
       // attribute in error (may be left blank if no specific attribute).
       // The following is a list of the attributes which can be in error:
       //   PTITLE   - page title
       //   PGROUP1  - page group 1
       //   PGROUP2  - page group 2
       //   PGROUP3  - page group 3
       //   PGROUP4  - page group 4
       //   PGROUP5  - page group 5
       //   PGROUP6  - page group 6
       //   PGROUP7  - page group 7
       //   PGROUP8  - page group 8
       //   PGROUP9  - page group 9
       //   PSPECB   - page special behaviors
       //   PCOMMAND - page command
     d MnuSetPageAttr  pr              n   extproc('MnuSetPageAttr')
     d   errmsg                     200
     d   errattr                     10
     d   pag                         10i 0 const
     d   ptitle                            const like(MenuPage.title)
     d                                           options(*nopass:*omit)
     d   pgroups                           const like(MenuPage.groups)
     d                                           dim(CNumGroups)
     d                                           options(*nopass:*omit)
     d   pspecb                            const like(MenuPage.specb)
     d                                           options(*nopass:*omit)
     d   pcommand                   500    const options(*nopass:*omit)

       // MnuIsBlankPage - Is Blank Page
       // Return *on if the page at index "pag" in array "MenuPages"
       // is blank or the element is *null, or if the menu is not
       // loaded, else return *off.
       // A blank page has no attributes.
     d MnuIsBlankPage  pr              n   extproc('MnuIsBlankPage')
     d   pag                         10i 0 const

       // MnuClearPage - Clear Page
       // Clear the page at index "pag" in array "MenuPages".
       // The "MenuPage" instance (and all options in it) is deleted
       // (de-allocated).
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message.
     d MnuClearPage    pr              n   extproc('MnuClearPage')
     d   pag                         10i 0 const

       // MnuMovePagesRight - Move Pages Right
       // Move all pages from "pag" up to (and including) "CNumPages" to
       // the right by one, i.e., increase each page's page number (index
       // of array "MenuPages") by one.
       // The pages to the left of "pag" are not moved.
       // Page "pag" can not be blank or *null, or the last page ("CNumPages").
       // The last page (index "CNumPages") must be blank or *null.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message.
     d MnuMovePagesRight...
     d                 pr              n   extproc('MnuMovePagesRight')
     d   errmsg                     200
     d   pag                         10i 0 const

       // MnuMovePagesLeft - Move Pages Left
       // Move all pages from "pag" up to (and including) "CNumPages" to
       // the left by one, i.e., decrease each page's page number (index
       // of array "MenuPages") by one.
       // The pages to the left of "pag" are not moved.
       // Page "pag" can not be blank or *null, or the first page (1).
       // The first page (index 1) must be blank or *null.
       // The previous page ("pag" - 1) must be blank or *null.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message.
     d MnuMovePagesLeft...
     d                 pr              n   extproc('MnuMovePagesLeft')
     d   errmsg                     200
     d   pag                         10i 0 const

       // MnuGetOptText - Get Option Text
       // Return the text of the option or header on page "pag" and "slot".
       // Return blanks if the page or slot does not exist, or if the slot
       // does not contain an option or header.
     d MnuGetOptText   pr                  like(MenuOption.text)
     d                                     extproc('MnuGetOptText')
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuGetOptChoice - Get Option Choice
       // Return the choice of the option on page "pag" and "slot".
       // Return blanks if the page or slot does not exist, or if the slot
       // does not contain an option.
     d MnuGetOptChoice...
     d                 pr                  like(MenuOption.choice)
     d                                     extproc('MnuGetOptChoice')
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuSetOptAttr - Set Option Attributes
       // Create a new option or update an existing option in the "slot"
       // on page "pag", using the given parameter values ("o...").
       // If there is no page "pag" (i.e. element "pag" of array "MenuPages"
       // is *null), first create a new blank page "pag".
       // If the slot is empty, create a new option with the given
       // attribute values. If the slot is not empty, update the option's
       // attributes for which a parameter is given.
       // If the "choice" attribute of an option is blank it is considered
       // a header. A header can only have a non-blank text; all other
       // attributes must be blank. Procedure "MnuSetOptHdr" should be used
       // to set a header, which is equivalent to calling "MnuSetOptAttr"
       // with a non-blank value for "text", and blank values for all other
       // attributes.
       // Validate the new or updated option.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message and set "errattr" to the name of the
       // attribute in error (may be left blank if no specific attribute).
       // The following is a list of the attributes which can be in error:
       //   OCHOICE  - option choice
       //   OTEXT    - option text
       //   OGROUP1  - option group 1
       //   OGROUP2  - option group 2
       //   OGROUP3  - option group 3
       //   OGROUP4  - option group 4
       //   OGROUP5  - option group 5
       //   OGROUP6  - option group 6
       //   OGROUP7  - option group 7
       //   OGROUP8  - option group 8
       //   OGROUP9  - option group 9
       //   OSPECB   - option special behaviors
       //   OCOMMAND - option command
     d MnuSetOptAttr   pr              n   extproc('MnuSetOptAttr')
     d   errmsg                     200
     d   errattr                     10
     d   pag                         10i 0 const
     d   slot                        10i 0 const
     d   ochoice                           const like(MenuOption.choice)
     d                                           options(*nopass:*omit)
     d   otext                             const like(MenuOption.text)
     d                                           options(*nopass:*omit)
     d   ogroups                           const like(MenuOption.groups)
     d                                           dim(CNumGroups)
     d                                           options(*nopass:*omit)
     d   ospecb                            const like(MenuOption.specb)
     d                                           options(*nopass:*omit)
     d   ocommand                   500    const options(*nopass:*omit)

       // MnuSetOptHdr - Set Option Header
       // Create a new header or update an existing option or header in
       // the "slot" on page "pag". If "slot" contains an option, all it's
       // attributes are set to blanks, except "text".
       // Validate the new or updated option.
       // This procedure simply calls procedure "MnuSetOptAttr" with a
       // value for "otext", and blanks for all other attributes.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message and set "errattr" to the name of the
       // attribute in error (may be left blank if no specific attribute).
       // The following is a list of the attributes which can be in error:
       //   OTEXT    - option text
     d MnuSetOptHdr    pr              n   extproc('MnuSetOptHdr')
     d   errmsg                     200
     d   errattr                     10
     d   pag                         10i 0 const
     d   slot                        10i 0 const
     d   otext                             const like(MenuOption.text)

       // MnuDeleteOpt - Delete Option
       // Delete the option or header in the "slot" on page "pag".
       // The page (element of array "MenuPages") can not be blank (*null).
       // The slot must contain an option or header.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message.
     d MnuDeleteOpt    pr              n   extproc('MnuDeleteOpt')
     d   errmsg                     200
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuSlotHasOpt - Slot Has Option
       // Return *on if the "slot" on page "pag" contains an option (and
       // a header), else return *off.
     d MnuSlotHasOpt   pr              n   extproc('MnuSlotHasOpt')
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuSlotHasHdr - Slot Has Header
       // Return *on if the "slot" on page "pag" contains a header (and
       // not an option), else return *off.
     d MnuSlotHasHdr   pr              n   extproc('MnuSlotHasHdr')
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuMoveOptsDown - Move Options Down
       // Move options and headers down one slot on page "pag". The options
       // and headers that are moved are the ones in the slots beginning
       // from "slot" down to (and including) the slot at the bottom of
       // the same vertical strip on page "pag".
       // The options in the slots above "slot" are not moved.
       // The page (element of array "MenuPages") can not be blank (*null).
       // There must be at least one option or header to move.
       // The slot at the bottom of the strip must be empty.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message.
     d MnuMoveOptsDown...
     d                 pr              n   extproc('MnuMoveOptsDown')
     d   errmsg                     200
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuMoveOptsUp - Move Options Up
       // Move options and headers up one slot on page "pag". The options
       // and headers that are moved are the ones in the slots beginning from
       // "slot" down to (and including) the slot at the bottom of the same
       // vertical strip on page "pag".
       // The options in the slots above "slot" are not moved.
       // The page (element of array "MenuPages") can not be blank (*null).
       // There must be at least one option or header to move.
       // If "slot" contains an option (or header), then it must have an
       // empty slot directly above it on the same strip.
       // Return *on if successful, else return *off and set "errmsg" to
       // an appropriate error message.
     d MnuMoveOptsUp   pr              n   extproc('MnuMoveOptsUp')
     d   errmsg                     200
     d   pag                         10i 0 const
     d   slot                        10i 0 const

       // MnuValNormMenu - Validate/Normalize Menu
       // Validate and normalize the complete menu structure loaded in
       // memory. E.g., for all existing pages the titles are checked if
       // they are not blank, and they are left adjusted.
       // Return *on if ok, else return *off and set "errmsg" to an
       // appropriate error message and set "errattr" to the name of the
       // attribute in error (may be left blank if no specific attribute).
       // If parameter "errpage" is given, or "errpage" and "errslot" are
       // both given, they contain the page (and slot) in error if *off is
       // returned ("errslot" will be 0 if the error concerns a page and
       // not an individual slot. Parameter "errpage" will be 0 if the error
       // concerns the menu as a whole (e.g. if it's not loaded).
       // The following is a list of the attributes which can be in error:
       //   OCHOICE  - option choice
       //   OTEXT    - option text
       //   OGROUP1  - option group 1
       //   OGROUP2  - option group 2
       //   OGROUP3  - option group 3
       //   OGROUP4  - option group 4
       //   OGROUP5  - option group 5
       //   OGROUP6  - option group 6
       //   OGROUP7  - option group 7
       //   OGROUP8  - option group 8
       //   OGROUP9  - option group 9
       //   OSPECB   - option special behaviors
       //   OCOMMAND - option command
       //   PTITLE   - page title
       //   PGROUP1  - page group 1
       //   PGROUP2  - page group 2
       //   PGROUP3  - page group 3
       //   PGROUP4  - page group 4
       //   PGROUP5  - page group 5
       //   PGROUP6  - page group 6
       //   PGROUP7  - page group 7
       //   PGROUP8  - page group 8
       //   PGROUP9  - page group 9
       //   PSPECB   - page special behaviors
       //   PCOMMAND - page command
       //   MTITLE   - menu title
       //   MGROUP1  - menu group 1
       //   MGROUP2  - menu group 2
       //   MGROUP3  - menu group 3
       //   MGROUP4  - menu group 4
       //   MGROUP5  - menu group 5
       //   MGROUP6  - menu group 6
       //   MGROUP7  - menu group 7
       //   MGROUP8  - menu group 8
       //   MGROUP9  - menu group 9
       //   MSPECB   - menu special behaviors
       //   MCOMMAND - menu command
       // It should not be necessary to call this procedure because
       // the menu page and slot attributes should always be updated
       // by calling the appropriate procedures, such as "MnuSetOptAttr",
       // which already do the necessary validations and normalizations.
       // However, for safety, when the menu is saved with "MnuSaveMenu",
       // it is completely validated first to prevent corrupted data in
       // the database. This is done by calling this procedure, which is
       // provided as a public procedure.
     d MnuValNormMenu  pr              n   extproc('MnuValNormMenu')
     d   errmsg                     200
     d   errattr                     10    options(*nopass)
     d   errpage                     10i 0 options(*nopass)
     d   errslot                     10i 0 options(*nopass)

       // MnuOptAllowed - Option Allowed
       // Return *on if "slot" on page "pag" contains a menu option which
       // is allowed for "user", else return *off. Return *off when the
       // slot does not contain an option (it is empty or it contains a
       // header), when the page is blank or *null, when the menu is not
       // loaded, or when the menu has been loaded for a specific user
       // different than "user".
       // Always return *on when the slot contains an option and "user"
       // is blank, or "MenuUser" is blank and "user" contains an asterisk
       // ("*").
       // An option is allowed if "user" or one of its group profiles is
       // a member of at least one of theg roups specified for the menu,
       // the option's page, or the option.
       // Return *off if "pag" or "slot" refers to a non-existing page or
       // slot.
       // If the menu was loaded for a specific user then this procedure
       // just checks the menu definition in memory to see whether the slot
       // contains an option or not (because in this case only the options
       // that are allowed for that user have been loaded). However, if
       // parameter "option" with value "*CURRENT" is given, the database
       // is queried to check the most current authorisation data.
       // If the menu was loaded with all options for all users then the
       // authorisation data in memory (loaded with procedure "MnuLoadAuth")
       // is used, unless parameter "option" with value "*CURRENT" is given.
       // If parameter "option" with value "*CURRENT" is given then the most
       // current authorisation data is used (i.e. what is currenly stored
       // in the database) instead of the authorisation data in memory. This
       // takes much more time because of the database I/O involved. Option
       // "*CURRENT" uses procedure "IsGrpMember" in module DQ to query the
       // database.
     d MnuOptAllowed   pr              n   extproc('MnuOptAllowed')
     d   user                        10    const
     d   pag                         10i 0 const
     d   slot                        10i 0 const
     d   option                      10    const options(*nopass)

       // MnuUserPage - User Page
       // Return the "real" menu page (i.e. index into array "MenuPages")
       // for each "userpage", for "user". Return the number of user pages
       // (last user page) if "userpage" is not given, which can be 0 if
       // there are no available options for "user". Return 0 if "userpage"
       // is 0, or greater than the last user page, or if the menu is
       // loaded for a specific user which is different than "user", or
       // if the menu is not loaded at all.
       // If "user" is an asterisk ("*"), the "user pages" have all
       // options that are defined in the menu (and not just for a
       // specific user).
       // If "user" is blank then the user pages are the same as the
       // "real" menu pages, i.e. user page 1 gives "real" page 1, etc.
       // If "userpage" is negative, it's absolute value is interpreted
       // as a "real" page (i.e. index of array "MenuPages"), and the
       // procedure returns the user page that is associated with it (the
       // inverse). Note that the number of "real" pages (the last page)
       // is always "CNumPages".
       // With a blank "user" or with a negative "userpage", the returned
       // "real" page can be empty, i.e. the "MenuPages" element is *null
       // (no page), or the page does not have any attributes or options.
       // Background info:
       // Depending on "user", some menu pages are empty because they do
       // not contain one or more options allowed for that user. This
       // procedure is used to present one or more consecutive pages with
       // options, without empty pages, for a specific user (the "user"
       // pages). These pages are a subset of the "real" menu pages in
       // array "MenuPages". The empty pages effectively do not exist for
       // that user. E.g., the first (1) user page for "user" is "real"
       // page 3 (i.e. index of array "MenuPages") because pages 1 and 2
       // are empty (the slots do not contain an option), or do not have
       // any allowable options for that user. The second (2) user page
       // is "real" page 5, etc. In the special case where "user" is an
       // asterisk ("*"), the user pages are simply all the non-empty
       // "real" pages.
     d MnuUserPage     pr            10i 0 extproc('MnuUserPage')
     d   user                        10    const
     d   userpage                    10i 0 const options(*nopass)

       // MnuCopyPgSlots - Copy Page Slots
       // Copy all slots from page "pags" (source) to "pagt" (target).
       // When done, page "pagt" will have the same slots as "pags".
       // All options/headers in "pagt" will be deleted (released).
       // All options/headers in "pags" will be copied to "pagt".
       // Do nothing if "pags"/"pagt" is less than 1 or higher than
       // "CNumPages".
     d MnuCopyPgSlots  pr                  extproc('MnuCopyPgSlots')
     d   pags                        10i 0 const
     d   pagt                        10i 0 const

       // MnuSwapSlotSeq - Swap Slot Sequence
       // Swap two consecutive slot sequences on page "pag". The
       // first slot of the first sequence is "slot1". The first
       // slot of the second sequence is "slot2". The number of
       // slots for both sequences is given with "num". if the two
       // sequences overlap then the result will be a corrupt page;
       // there is no check being done. Also, nothing happens if
       // the number of slots goes past the last slot of the page,
       // "pag" is less than 1 or greater than "CNumPages" or "slot1"
       // or "slot2" is less than 1 or greater than "CNumSlots".
     d MnuSwapSlotSeq  pr                  extproc('MnuSwapSlotSeq')
     d   pag                         10i 0 const
     d   slot1                       10i 0 const
     d   slot2                       10i 0 const
     d   num                         10i 0 const

