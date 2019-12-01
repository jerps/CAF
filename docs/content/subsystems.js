document.write('\
\
<h2 id="subsystems">SubSystems</h2>\
<div class="lvl2">\
<p>\
The layers above <a href="#cappbase">CAPPBASE</a> and below <a href="#cappdisp">CAPPDISP</a> are the "subsystem" layers. \
Service programs that are part of these layers are named CAPPSS?? where SS stands for SubSystem.\
</p>\
<p>\
A subsystem represents a well defined part of the domain or business. A specific service program named CAPPSS?? provides \
functionality that pertains to the subsystem or business domain identified with the two-character id ??. As an example, a \
subsystem with id OP (implemented with a serviceprogram named CAPPSSOP) would provide OrderProcessing functionality. CAF \
comes with one subsystem, <a href="#cappssam">AM</a> (AppMenu), which implements a menu system.\
</p>\
<p>\
Subsystems implement the "business logic". They typically access files that are managed independently from service \
program CAPPSS??. These files already exist and/or are part of a bigger system and also need to be accessed from (externa) \
applications (such as excel) and have names other than CAPPSS??F?. Subsystem <a href="#cappssam">AM</a> (AppMenu), however, \
has it\'s own files which are part of the service program (CAPPSSAMF?). Subsystems should only access the files that belong \
to the subsystem\'s business domain. If, for example, subsystem OP needs to add a new order and it must first query the \
customer data to check whether the customer is blocked then it should do this through, for example, subsystem CM (customer \
master) instead of directly accessing the customer file(s).\
</p>\
<p>\
As described above a subsystem has an "id" which is character 7 and 8 of the service program name. To avoid name clashes, \
Messages (in module AM, procedure <code>RtvAMsg??</code>), query procedures (in module DQ), command procedures (in module DC) \
and value arrays (in module VA) have names with the subsystem\'s id in it.\
</p>\
<p>\
Service program CAPPBASE contains base code for all subsystems and therefore also has a subsystem id: AB (AppBase).<br>\
</p>\
<p>\
<b><span class="bullet1">&#9679;</span>&nbsp;Do not use id AB for any subsystem.</b>\
</p>\
<p>\
<b><span class="bullet1">&#9679;</span>&nbsp;When creating a new subsystem service program, CAPPSS??, in module AM, make sure to set the value of constant <code>Subsysid</code> \
to the subsystem id and name procedure <code>RtvAMsg??</code> such that <code>??</code> is the subsystem id.</b>\
</p>\
<p>\
The names of the attributes defined in the field reference file of a subsystem (CAPPSS??FR) always begins with <code>T??_</code> \
where <code>??</code> is the subsystem id.\
</p>\
<p>\
Every subsystem has a set of "application messages" which are defined in module AM in the service program. They apply to the subsystem \
and can be retrieved by calling procedure <code>RtvAMsg??</code> where <code>??</code> is the subsystem id. For example for displaying \
error messages. Service program CAPPBASE also has an AM module, with procedure <code>RtvAMsgAB</code>, containing generic messages that \
apply to all subsystems. A message always has format <b>iisnnnn: xxxxxx</b> where <b>ii</b> is the subsystem id, <b>s</b> is the message \
severity and <b>nnnn</b> is the message number which is unique within a subsystem. The severity can be one of the constants <code>CAmsInfo</code> \
("I"), <code>CAmsWarning</code> ("W") or <code>CAmsFatal</code> ("F."). For example: "ABF1003: Invalid option.".\
</p>\
<p>\
The code needed to read or write/update the files for a specific subsystem is always in module DQ (Database Queries) or module DC (Database \
Commands). A DQ module can have many queries. The typical query consists of a procedure named <code>Qds_??_...</code> where <code>??</code> \
is the subsystem id. The first parameter (output) is always a data structure having the same name as the procedure appended with a dollar \
sign ($), which is defined just before the prototype of the query procedure. The first three fields of this "query data structure" is always \
a return code (<code>rc</code>: 2,0) indicating the result of the query (0 = ok, <0 = error) which is also returned by the procedure, an \
errormessage (<code>msg</code>: 200A) and an array (<code>dbf</code>: 7&times;10A) containing up to 7 database fields that are related to \
the error.\
</p>\
<p>\
Module DC of a subsystem service program contains the code to write / update the database files associated with the subsystem (commands). \
Before a command writes or updates the database it validates the operation. Every command exists of a procedure named <code>DC_??_...</code> \
where <code>??</code> is the subsystem id. The first parameter (input) is always a 10-character field containing <code>\'*ADD\'</code>, \
<code>\'*UPDATE\'</code> or <code>\'*DELETE\'</code>. The second parameter (input/output) is always a data structure, which is defined just \
before the procedure prototype. This data structure has the same name as the procedure appended with a dollar sign ($). It usually contains \
the database fields that must be written or updated. The procedure returns a 2-digit code indicating: 0 = success, <0 = error, >0 = success \
with issues. The procedure has a specific structure (see for example <code>DC_AM_Group</code> in module CAPPSSAMDC). When the procedure \
detects errors (or issues) during the validating step it calls one or more times procedure <code>AddDCVMsg</code> (defined in module CAPPBASEMS) \
to add a message and associated database field names to array <code>DspMsgList</code>, defined in module CAPPBASEMS. Applications read this \
array to display the messages and to "reverse image" the display fields associated with the database fields. See compile-time array <code>FEMap</code> \
in for example application CAFMENUGD (and subroutine <code>AddAssocErrFlds</code> in source member QINCSRC,DPGM_SUBR).\
</p>\
<p>\
Service programs CAPPBASE and CAPPSS?? all have a module VA containing "value arrays". These are simply compile-time arrays containing \
<u>constant</u> values. For example the values that can be entered for an attribute. Each value array is named <code>VA??_...</code> where <code>??</code> \
is the subsystem id (<code>AB</code> for CAPPBASE). Value arrays are exported from module VA and imported by including INCL_VA.\
</p>\
</div>\
\
');
