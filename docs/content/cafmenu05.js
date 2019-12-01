document.write('\
\
<h3 id="cafmenu05">Adding and removing headers/options</h3>\
<div class="lvl3">\
<p>\
After executing "CAFMENU *UPDATE", and nothing is specified yet for the menu, the following screen is displayed.\
<image class="screenshot" src="images/screen110.png">\
</p>\
<p>\
The dots mark the empty slots. To add a header or option, place the cursor nearby a dot and press Enter.\
<image class="screenshot" src="images/screen115.png">\
</p>\
<p>\
A window appears to fill in the option choice, like "1" or "a", and the header or option text. To enter a header \
leave the choice blank.\
<image class="screenshot" src="images/screen117.png">\
</p>\
<p>\
Press Enter and the header or option text appears where the cursor was placed.\
<image class="screenshot" src="images/screen119.png">\
</p>\
<p>\
To change or delete a header or an option, place the cursor on it and press Enter. Then change the attributes or \
press F14 twice to delete the header or option. When a page with options and headers is displayed, press F14 twice \
to completely clear the page, i.e. all options and headers are removed and the page attributes (see <a href="#cafmenu10">Page and menu attributes</a>) \
are cleared.\
</p>\
<p>\
To add an option place the cursor below the header and press Enter. The slot just below the header must stay empty. \
Fill in the option choice and the text.\
<image class="screenshot" src="images/screen125.png">\
</p>\
<p>\
Press Enter to fill in the option\'s attributes.\
<image class="screenshot" src="images/screen128.png">\
</p>\
<p>\
<div class="item1-h">Groups</div>\
<div class="item1-d">\
Enter up to 9 menu groups to specify the users for which the option is allowed. An option is allowed when the user is in \
at least one of the groups specified for the option, the page or the menu (see <a href="#cafmenu10">Page and menu attributes</a>). \
Press F4 to select a group.\
</div>\
<div class="item1-h">Command</div>\
<div class="item1-d">\
The command to execute when the option is selected. Press F4 to prompt the command.  Leave blank if no command \
should be executed.\
</div>\
<div class="item1-h">Command sequence</div>\
<div class="item1-d">\
Like an option, a command can be specified for the page and for the menu (see <a href="#cafmenu10">Page and menu attributes</a>). \
The command sequence specifies the order in which these up to three commands should be executed. For example, specify 3 for the \
option command and 1 for the page command to execute the page command before the option command. If the same sequence is specified \
the commands are executed in the order menu, page and command.\
</div>\
<div class="item1-h">Confirm perform opt</div>\
<div class="item1-d">\
Fill in Y to display a confirmation window when an option is selected by the user. A confirmation window is shown when Y is specified \
in either the option attributes, page attributes or menu attributes.\
</div>\
<div class="item1-h">Use command handler</div>\
<div class="item1-d">\
Fill in Y to execute program CAPPSSAMCH instead of the specified command. The specified command is passed as an argument to the \
command handler. See member CAPPSSAMCH in sourcefile CAPPSSAMS.\
</div>\
</p>\
<p>\
<image class="screenshot" src="images/screen131.png">\
<image class="screenshot" src="images/screen132.png">\
<image class="screenshot" src="images/screen133.png">\
<image class="screenshot" src="images/screen134.png">\
<image class="screenshot" src="images/screen135.png">\
</p>\
</div>\
\
');
