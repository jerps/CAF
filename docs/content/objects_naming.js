document.write('\
\
<h2 id="objects_naming">Objects & Naming</h2>\
<div class="lvl2">\
<p>\
CAF consists of one library named CAFvmmp, where v is the major version, mm is the minor version \
and p is the patch version.\
</p>\
<p>\
Service programs are all named CSYS???? or CAPP????. The modules of a service program have a two-letter \
id and the name of a module is always the name of the service program it belongs to appended with this id. For \
example module CSYSBASEDT is the name of the module in service program CSYSBASE that implements functionality \
for working with dates and times.\
</p>\
<p>\
Every service program has one binding directory with the same name as the service program. The binding \
directory has this same name as its only entry. To use a service program from an RPG program one should simply \
reference its binding directory using the <code>bnddir</code> control header keyword, and <code>/include</code> \
its INCL_API source member.\
</p>\
<p>\
Besides modules, several other objects can be seen as being part of a service program, such as files and programs. \
These objects are also identified with a two-character id. In principle, the id\'s of these objects consist of a \
letter followed by a digit. For example object CAPPDISPF1 is file 1, with id F1, containing help text that belongs \
to service program CAPPDISP.\
</p>\
<p>\
A service program may define a field reference file which defines all "attribute types" used by the service \
program. The id of this file is always FR.\
</p>\
<p>\
Besides modules and FRF\'s, the following types of objects can be seen as part of a service program. They are \
identified with the service program\'s name and a two-character id:<br>\
<span class="bullet1">&#9679;</span>&nbsp;An : DataArea n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Bn : Build program n to build (part of) the service program<br>\
<span class="bullet1">&#9679;</span>&nbsp;Cn : Command n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Dn : DisplayFile n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Fn : File n<br>\
<span class="bullet1">&#9679;</span>&nbsp;Pn : Program n\
</p>\
<p>\
The names of the application programs that are delivered as part of the framework all start with CAF.<br>\
<span style="display: grid; grid-template-columns: 13ch auto; grid-template-rows: auto;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;<a href="#cafmenu">CAFMENU</a></span><span class="g12">: Display or Update the Menu</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;<a href="#cafmenug">CAFMENUG</a></span><span class="g22">: Work with Menu Groups</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;<a href="#cafnwd">CAFNWD</a></span><span class="g32">: Work with Non-Workdays</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;<a href="#cafnwdt">CAFNWDT</a></span><span class="g42">: Work with Non-Workday Types</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;<a href="#cafsqls">CAFSQLS</a></span><span class="g52">: Work With SQL Statements</span>\
</span>\
</p>\
</div>\
\
');
