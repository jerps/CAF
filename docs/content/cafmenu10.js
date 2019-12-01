document.write('\
\
<h3 id="cafmenu10">Page and menu attributes</h3>\
<div class="lvl3">\
<p>\
The same attributes as can be specified for an option can also be specified for a page and the menu. Press F16 to fill in\
the attributes for the current page. Press F16 again to fill in the attributes for the menu. The title of the page can \
also be directly filled in at the top of the screen. An empty page title is displayed as "- BLANK -".\
<div class="item1-h">Page/menu title</div>\
<div class="item1-d">\
Title of the page or menu.\
</div>\
<div class="item1-h">Groups</div>\
<div class="item1-d">\
Enter up to 9 menu groups to specify the users for which all the options on the page or in the menu are allowed. An option \
is allowed when the user is in at least one of the groups specified for the option, the page or the menu. Press F4 to select \
a group.\
</div>\
<div class="item1-h">Command</div>\
<div class="item1-d">\
The command to execute when an option on the page or in the menu is selected. Press F4 to prompt the command.  Leave blank \
if no command should be executed for the page or the menu.\
</div>\
<div class="item1-h">Command sequence</div>\
<div class="item1-d">\
The command sequence specifies the order in which the up to three commands specified for an option, the page and the menu \
should be executed. For example, specify 3 for the option command and 1 for the page command to execute the page command \
before the option command. If the same sequence is specified the commands are executed in the order menu, page and command.\
</div>\
<div class="item1-h">Confirm perform opt</div>\
<div class="item1-d">\
Fill in Y to display a confirmation window when an option on the page or in the menu is selected by the user. A confirmation \
window is shown when Y is specified in either the option attributes, page attributes or menu attributes.\
</div>\
<div class="item1-h">Use command handler</div>\
<div class="item1-d">\
Fill in Y to execute program CAPPSSAMCH instead of the specified command. The specified command is passed as an argument to the \
command handler. See member CAPPSSAMCH in sourcefile CAPPSSAMS.\
</div>\
</p>\
<p>\
<image class="screenshot" src="images/screen141.png">\
<image class="screenshot" src="images/screen142.png">\
<image class="screenshot" src="images/screen143.png">\
</p>\
</div>\
\
');
