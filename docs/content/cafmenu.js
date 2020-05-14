document.write('\
\
<h2 id="cafmenu">CAFMENU (Display or Update the Menu)</h2>\
<div class="lvl2">\
<p>\
CAF provides a simple menu system. It provides only one menu, which presents the options that are available for a specific \
user as one or more pages. Up to 999 pages with options can be specified. Each page is organized into 3 vertical strips, each \
providing 15 "slots". Each slot can be an option or a header. The slot below or above a header must be empty. So without any \
headers up to 15 options can be specified on one vertical strip, or 45 on one page. In normal display mode only two \
strips are displayed. In wide display mode (132 columns) all three strips are displayed.\
</p>\
<p>\
To update the menu, execute command "CAFMENU *UPDATE". The current user must be in menu group *ADMIN. Execute command \
"CAFMENU *DISPLAY" or simply "CAFMENU" to display the menu to the current user. Only the options allowed for the  current \
user are displayed.\
</p>\
<p>\
The menu is stored in files CAPPSSAMF1 and CAPPSSAMF2 and in data area CAPPSSAMA0.\
</p>\
<p>\
When a menu option is selected up to three commands are executed. These commands can be specified for the option, the \
page with the option, and the menu. The order in which these commands are executed can be controlled. Instead of a command \
the command handler can be executed. This is a CL program named CAPPSSAMCH. It receives several arguments such as the specified \
command, the user id, the selected option, etc. The standard version does nothing but it can be changed to perform any task. \
See member CAPPSSAMCH in sourcefile CAPPSSAMS. Blanks may be specified for a command.\
</p>\
<p>\
When the menu is displayed or when in "simulation mode" (see further) only the options allowed for the user are displayed. \
This means that the options and headers below an option that is not allowed and thus not displayed, on the same vertical \
strip, move up to fill the gap. Empty slots between the headers and options are removed, except the slots directly below or \
above the headers, and the headers and options below move up to fill the empty slots. Also, when displaying the menu or when \
in simulation mode, empty pages (or pages where all specified options are not allowed) are removed.\
</p>\
<p>\
When updating the menu, press F15 to edit the menu groups, i.e. execute "CAFMENUG *EDIT". Press PageDown/PageUp \
to go to the next/previous page. Put the cursor just below and to the right of the text "Page 1 of 999" (or go there \
using F10) to enter the page number to go to (press Enter).\
</p>\
<p>\
When the menu is displayed to a user by executing "CAFMENU *DISPLAY" only the standard function keys are available.\
</p>\
<p>\
The documentation here after only shows the menu in normal display mode (80 columns) so only two vertical strips per \
page are displayed. Use F9 to switch to wide mode (132 columns) to update or display all three strips. The available \
function keys are only showed at the bottom of the screen when in wide mode. In normal mode, press F1 to display the \
available function keys.\
</p>\
</div>\
\
');
