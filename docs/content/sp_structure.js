document.write('\
\
<h2 id="sp_structure">SP Structure</h2>\
<div class="lvl2">\
<p>\
All source members of a service program are contained within one source physical file which has the \
same name as the service program name appended with "S", The service programs all have the same organization \
of source members. There is always one source member named AAAA_BBBB that contains the binder source, \
where AAAA is the first part of the service program name (CSYS or CAPP) and BBBB is the second part of \
the name. For example for service program CSYSBASE (source file CSYSBASES) the binder source is in \
source member CSYS_BASE.\
</p>\
<p>\
For every object that is part of a service program there is one source member having the same name as \
the object. These names consist of the service program name appended with a two-character id. These objects \
are the modules that make up the service program object itself and other objects that are seen as being part \
of the service program such as files and programs. When there are files or data areas then there is probably \
also a P0 program which loads the files and data areas with initial data when applicable. These "load initial \
data" programs are always called from build program B1 (prereqs). Only the files or data areas that \
did not already exist (and were created by B1) are loaded with initial data.\
</p>\
<p>\
The other source members are all include members with names that start with INCL_ or INCL__. The first, \
with one underscore, are "public" and are included by the consumers of the service program, i.e. applications, \
other service programs or modules / programs that are part of the service program itself. The include members \
with two underscores are "private" and only included by modules of the service program itself. Private means \
that it only contains definitions that are used by the service program itself, i.e. its modules. Private include \
members should never be included by consumers of the service program.\
</p>\
<p>\
The following is a list of include member names and their function.<br>\
<br>\
<span style="display: grid; grid-template-columns: 15ch auto; grid-template-rows: auto; grid-gap: 0.6rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;INCL_DEFS</span>\
<span class="g12">\
Contains public definitions, mostly constants and data fields/structures, that are not specific for \
a module. These definitions pertain to the service program as a whole. A service program always has a \
INCL_DEFS member. Should always be included by INCL_?? members of the service program.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;INCL_??</span>\
<span class="g22">\
Contains public definitions, mostly prototypes, that are specific for module ??. To be included by \
consumers of the service program that only need functionality provided by that module. Is also always \
included by the module itself. Always includes INCL_DEFS.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;INCL_API</span>\
<span class="g32">\
Contains all public definitions (i.e. API) of the service program, i.e. it includes INCL_DEFS (not really \
necessary because already included with the INCL_?? members) and all INCL_?? members. Included by consumers of the service program that are not modules of \
the service program itself. It provides a practical way of including the complete API of a service program \
without having to list all individual INCL_ members.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;INCL__MODH</span>\
<span class="g42">\
Contains header specs for all modules of the service program. Is always included by every module of the service \
program.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;INCL__MODD</span>\
<span class="g52">\
Contains definitions such as constants or data fields / structures that are private to the service program \
and which do not pertain to one specific module. It also always includes member INCL_DEFS. Is always included \
by every module of the service program, even when no definitions are actually used.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;INCL__??</span>\
<span class="g62">\
Contains private definitions, mostly prototypes, that are specific for module ??. To be included by modules \
of the service program which needs to use "internal" (see below) procedures (or data definitions) of that module. \
Is also always included by the module itself.\
</span>\
</span>\
</p>\
<p>\
Each INCL_DEFS member should include the INCL_DEFS members of all prerequisite service programs. For example CAPPSSAM \
uses CAPPBASE and CSYSBASE. It\'s INCL_DEFS member should include CAPPBASES,INCL_DEFS and CSYSBASES,INCL_DEFS.\
</p>\
<p>\
A service program may define a field reference file which defines all "attribute types" that are used by the \
service program. The field names always start with T, one or more letters, and an underscore (T..._). If the \
attribute types are public then member INCL_DEFS should define an external data structure based on this file, \
which name should be <code>Erf????????FR</code>. If the attribute types are private and should only be visible \
within the service program then the "Erf" external data structure should be defined in the INCL__MODD member. \
As an example see CAPPSSAMS,INCL_DEFS.\
</p>\
<p>\
Procedures can be "public", "internal" or "local". Public procedures can be used by other consumers than just \
the service program\'s modules. Their prototypes are defined in the INCL_?? member of the module. Internal \
procedures are only used by modules of the service program itself. Their names are prefixed with "I_". Their \
prototypes are defined in the INCL__?? member of the module. Unlike public and internal procedures, local procedures \
are not exported and are ony used in the module where they\'re implemented. Their names are prefixed with "L_".\
</p>\
<p>\
The public procedures of a service program are categorized into different modules, each having an id that \
identifies the category. For example DT for date/time functions, TU for text utilities, etc. Most service programs \
also have an XX (miscellaneous) module. Module XX of a service program contains the procedures that are not (yet) \
put into a specific category. Applications should not include INCL_XX as these procedures may eventually be moved \
to a specific category. Instead, INCL_API should (always) be included.\
</p>\
<p>\
Every service program has an RM module (Resource Management). It must always provide public procedure <code>RlsSp????????</code> \
which releases all resources managed by the service program. For example to close all open files or to release allocated \
memory. It does this by calling procedure <code>I_RlsMod??</code> for every module in the service program. Thus, every module \
must implement this internal procedure to release all resources that are managed by that module (even if there are \
no resources to release). When an application ends it should call <code>RlsSp????????</code> (e.g. <code>RlsSpCSYSBASE</code>) \
for every service program that is used by the application. It should do this in a specific order, namely from top to bottom. \
The last one released must always be CSYSBASE which is at the bottom of the service program stack. CAPPDISP is always \
at the top of the stack and should be released first if it\'s used.<br>\
The complete ordering is: CSYSBASE&nbsp;&lt;&nbsp;CSYSSQLS&nbsp;&lt;&nbsp;CAPPBASE&nbsp;&lt;&nbsp;CAPPSSAM&nbsp;&lt;&nbsp;CAPPDISP.\
</p>\
</div>\
\
');
