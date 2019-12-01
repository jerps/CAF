document.write('\
\
<h1 id="applications">Applications</h1>\
<p>\
CAF comes with several application programs, based on the framework. Besides being examples, they also provide some \
useful functionality. All applications except <a href="#cafmenu">CAFMENU</a> can be used as templates for new applications. \
</p>\
<p>\
Applications <a href="#cafnwd">CAFNWD</a> and <a href="#cafnwdt">CAFNWDT</a> provide a way to specify "non-workdays". \
These are days such as week-ends and holidays on which no work is performed. Only one entry has to be used to specify that, \
for example, all sundays are non-workdays or to specify that every 25th of december is a non-workday. Application \
<a href="#cafmenu">CAFMENU</a> is used to maintain the options and authorities of a menu, and to present the menu \
to users. It\'s a simple menu system, useful for departments or small companies. Application <a href="#cafmenug">CAFMENUG</a> \
is used to maintain the hierarchy of "groups" and user profiles names (user id\'s) that are used in the menu system. Application \
<a href="#cafsqls">CAFSQLS</a> is used to maintain the SQL statements in file CSYSSQLSF1.\
</p>\
<p>\
All applications support displaying 80 or 132 columns. Press F9 to switch between 80 and 132 columns. The extra screen \
space available when in "132 column mode" is not always utilized. This varies per application.\
</p>\
<p>\
When used, the following function keys are always the same in every application. \
Press F1 to show a list with these function keys.\
<div class="item1-h">F1=Help</div>\
<div class="item1-d">\
Display help text.\
</div>\
<div class="item1-h">F3=Exit</div>\
<div class="item1-d">\
Exit the application.\
</div>\
<div class="item1-h">F4=Select item</div>\
<div class="item1-d">\
Select an item from a list.\
</div>\
<div class="item1-h">F5=Refresh</div>\
<div class="item1-d">\
Read current data again and re-display current screen with the latest data. Current unsaved data on the screen is lost.\
</div>\
<div class="item1-h">F9=Resize screen</div>\
<div class="item1-d">\
Switch between displaying 80 and 132 columns. Current unsaved data on the screen is lost.\
</div>\
<div class="item1-h">F10=Go to next cursor location</div>\
<div class="item1-d">\
A screen may have several "special" positions on which the cursor can be placed. F10 iterates \
through these positions and places the cursor on the next one.\
</div>\
<div class="item1-h">F12=Cancel</div>\
<div class="item1-d">\
Cancel the current screen and go back to the previous screen.\
</div>\
<div class="item1-h">F17=Go to top, or first page/screen</div>\
<div class="item1-d">\
Go to the top or first page or screen. For example when displaying a list, pressing F17 displays \
the first page.\
</div>\
<div class="item1-h">F18=Go to bottom, or last page/screen</div>\
<div class="item1-d">\
Go to the bottom or last page or screen. For example when displaying a list, pressing F18 displays \
the last page.\
</div>\
<div class="item1-h">F22=Show all messages</div>\
<div class="item1-d">\
An application screen usually displays only one (error) message at the bottom of the screen, i.e. line 22 (80 columns) \
or 25 (132 columns). Although multiple (error) messages may be present. By placing the cursor on line 22/25 and \
pressing F22 a window with all messages is displayed. F10 can be used to place the cursor on line 22/25.\
</div>\
</p>\
<p>\
The available function keys are always displayed at the bottom of the screen. Only the specific ones are shown here, \
i.e. the ones not present in the list above. Press F1 to see the common function keys.\
</p>\
\
');
