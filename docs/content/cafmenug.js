document.write('\
\
<h2 id="cafmenug">CAFMENUG (Work with Menu Groups)</h2>\
<div class="lvl2">\
<p>\
The menu, updated with application <a href="#cafmenu">CAFMENU</a>, uses "menu groups" to associate menu options with \
users.\
</p>\
<p>\
A menu group is a list of user id\'s (i.e. user profiles) and/or other menu groups. It identifies a group of users that \
are allowed to select some menu option. A user id can be a group profile, representing all users in that group.\
</p>\
<p>\
Menu groups are stored in files CAPPSSAMF3 and CAPPSSAMF4.\
</p>\
<p>\
The following special menu groups are defined.\
<div class="item1-h">*ADMIN</div>\
<div class="item1-d">\
The group of users that are allowed to update the menu. This group can be updated with <a href="#cafmenug">CAFMENUG</a>.\
</div>\
<div class="item1-h">*ALL</div>\
<div class="item1-d">\
Represents all users.\
</div>\
<div class="item1-h">*NONE</div>\
<div class="item1-d">\
Represents none of the users.\
</div>\
</p>\
<p>\
An exclamation mark (!) followed by a group name represents the inverse of that group, i.e. the group of users <span style="font-style: italic">not</span> \
in the group. For example, group !*NONE is the same as *ALL and vice versa.\
</p>\
<p>\
Execute "CAFMENUG *EDIT" to maintain the menu groups.\
<image class="screenshot" src="images/screen021.png">\
</p>\
<p>\
A list is presented with each group\'s name, description and whether it\'s active.\
</p>\
<p>\
Press F6 to add a new group. Up to 200 user id\'s / groups can be entered. Fill in it\'s name, description, \
whether it\'s active yes/no, and a list of user id\'s and/or menu groups. Press Enter twice to save. The first \
Enter retrieves the user id / group descriptions.\
</p>\
<p>\
Group names must be explicitly denoted by prefixing them with a dash (-). A name that does not begin with a dash \
is considered to be a user id.\
</p>\
<p>\
<image class="screenshot" src="images/screen022.png">\
</p>\
<p>\
<image class="screenshot" src="images/screen023.png">\
</p>\
<p>\
Press F5 to refresh the list; the new groups will be listed.\
<image class="screenshot" src="images/screen024.png">\
</p>\
<p>\
Enter one or more of the displayed options before a line and press Enter to update, copy, delete or display groups. \
A line will be displayed in blue if the group has been updated, or red if it has been deleted.\
</p>\
</div>\
\
');
