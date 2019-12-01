document.write('\
\
<h3 id="cappssam"><span style="font-family: roboto mono; font-weight: bold;">CAPPSSAM</span> (SubSys AppMenu)</h3>\
<div class="lvl3">\
<p>\
This service program contains the "business logic" for the application menu, subsystem "AM". Module MO implements all menu functionality.\
</p>\
<p>\
Files F1 and F2 are maintained through module MO (instead of module DC). This is because the code to maintain these files is very specific \
to the menu implementation.\
</p>\
<p class="spop1">\
<b>MODULES</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;AM</span>\
<span class="g12">\
<span class="spodesc">Application Messages</span><br>\
Contains messages for subsystem AM.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;DC</span>\
<span class="g22">\
<span class="spodesc">Database Commands</span><br>\
Implements procedure <code>DC_AM_Group</code> to add/update/delete menu groups. Menu data is read/written/updated in module MO.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;DQ</span>\
<span class="g32">\
<span class="spodesc">Database Queries</span><br>\
Implements procedures to query menu groups. For example, <code>IsGrpMember</code> tests whether a user or group is a member of one or more groups. \
Procedure <code>Qds_AM_GroupAll</code> retrieved all data, such as description and members, related to a group. Menu data is read/written/updated \
in module MO.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;MO</span>\
<span class="g42">\
<span class="spodesc">Menu Operations</span><br>\
Implements all operations pertaining to the menu. This module reads/updates/writes files F1 and F2.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;RM</span>\
<span class="g52">\
<span class="spodesc">Resource Management</span><br>\
Call procedure <code>RlsSpCAPPSSAM</code> to release all resources that are allocated by this service program.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;VA</span>\
<span class="g62">\
<span class="spodesc">Value Arrays</span><br>\
Exports constant values.\
</span>\
<span class="g71"><span class="bullet1">&#9679;</span>&nbsp;XX</span>\
<span class="g72">\
<span class="spodesc">Miscellaneous</span><br>\
Implements procedures that are not categorized (yet) into another module. For example: <code>IsGrpSpecial</code>, <code>GetSpGrpText</code>.\
</span>\
</span>\
</p>\
<p class="spop2">\
<b>OBJECTS</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;CH</span>\
<span class="g12">\
<span class="spodesc">Command Handler Program</span><br>\
When performing a menu option, a command can be executed directly (<code>QCMDEXC</code>) or by calling intermediate program CAPPSSAMCH.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;FR</span>\
<span class="g22">\
<span class="spodesc">Field Reference File</span><br>\
Defines attribute types <code>TAM_...</code>.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;F1</span>\
<span class="g32">\
<span class="spodesc">File 1: Slots</span><br>\
Contains all slots (headers & options) of the menu, the menu attributes and the attributes of all pages. This file is maintained through module MO.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;F2</span>\
<span class="g42">\
<span class="spodesc">File 2: Slot/Groups</span><br>\
Contains the groups of all slots (headers & options), the menu and all pages. This file is maintained through module MO.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;F3</span>\
<span class="g52">\
<span class="spodesc">File 3: Groups</span><br>\
Contains all groups. This file is maintained through module DC.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;F4</span>\
<span class="g62">\
<span class="spodesc">File 4: Members/Groups (Group Members)</span><br>\
Contains all group members. This file is maintained through module DC.\
</span>\
<span class="g71"><span class="bullet1">&#9679;</span>&nbsp;F5</span>\
<span class="g72">\
<span class="spodesc">File 5: Index on F2</span><br>\
Key: bin, group, page, slot.\
</span>\
<span class="g81"><span class="bullet1">&#9679;</span>&nbsp;F6</span>\
<span class="g82">\
<span class="spodesc">File 6: Index on F4</span><br>\
Key: group, member type, member name.\
</span>\
<span class="g91"><span class="bullet1">&#9679;</span>&nbsp;P0</span>\
<span class="g92">\
<span class="spodesc">Program 0: Load Initial Data</span><br>\
When the service program is built then this program is called to load files F3 and F4 with \
initial data. I.e. group <b>*ADMIN</b> is created with user <b>QSECOFR</b>. Files that already \
exist when build program CAPPSSAMB1 is called are not affected.\
</span>\
<span class="g101"><span class="bullet1">&#9679;</span>&nbsp;P1</span>\
<span class="g102">\
<span class="spodesc">Program 1: Add user to group</span><br>\
Utility program that can be called to add a user to a group.\
</span>\
</span>\
</p>\
</div>\
\
');
