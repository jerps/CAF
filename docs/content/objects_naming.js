document.write('\
\
<h2 id="objects_naming">Objects & Naming</h2>\
<div class="lvl2">\
<p>\
CAF consists of one library named CAFmnnp, where m is the major version, nn is the minor version \
and p is the patch version (semantic versioning).\
</p>\
<p>\
Service programs are all named CSYSXXXX or CAPPXXXX. The modules of a service program have a two-letter \
id and the name of a module is always the name of the service program it belongs to appended with this id. For \
example module CSYSBASEDT is the name of the module in service program CSYSBASE that implements functionality \
for working with dates and times.\
</p>\
<p>\
Every service program has precisely one binding directory with the same name as the service program with \
the name of the service program as its only entry. To use a service program from an RPG program one should \
simply reference it using the <code>bnddir</code> keyword, and <code>/include</code> its INCL_API source member.\
</p>\
<p>\
Besides modules, several other objects are seen as being part of a service program, such as files. These \
objects are also identified with a two-character id. The id\'s of these objects always have a letter \
followed by a digit. For example object CAPPDISPF1 is file 1 containing help text that belongs to service \
program CAPPDISP.\
</p>\
<p>\
A service program may define a field reference file which defines all "attribute types" used by the service \
program. The id of this file is always FR.\
</p>\
<p>\
Besides modules, the following object types may be part of a service program and are identified with the \
service program\'s name and a two-character id:<br>\
<span class="bullet1">&#9679;</span>&nbsp;Fn : File n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Pn : Program n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Cn : Command n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Dn : DisplayFile n or DataArea n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Bn : CL Program n to build (part of) the service program\
</p>\
<p>\
The names of the application programs that are delivered as part of the framework all start with CAF.<br>\
<span style="display: grid; grid-template-columns: 13ch auto; grid-template-rows: auto;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;CAFMENU</span><span class="g12">: Display or Update the Menu</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;CAFMENUG</span><span class="g22">: Work with Menu Groups</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;CAFNWD</span><span class="g32">: Work with Non-Workdays</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;CAFNWDT</span><span class="g42">: Work with Non-Workday Types</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;CAFSQLS</span><span class="g52">: Work With SQL Statements</span>\
</span>\
</p>\
</div>\
\
');
