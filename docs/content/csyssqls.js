document.write('\
\
<h3 id="csyssqls"><span style="font-family: roboto mono; font-weight: bold;">CSYSSQLS</span> (SQL Statements)</h3>\
<div class="lvl3">\
<p>\
This service program is a simple API for the SQL Call Level Interface. SQL statements are stored in file F1. It\'s purpose is \
to function as a central store of SQL statements that must be retrieved and executed throughout the system. However, because \
its functionality is a bit crude and embedded SQL is often a more powerful and robust solution the role of this service \
program is narrowed to only store and execute the SQL SELECT statements (queries) that are used to select an item after pressing \
function key F4 (see service program <a href="#cappdisp">CAPPDISP</a>) or to fill the subfile of a "work with" program. As \
an example see application <a href="#cafsqls">CAFSQLS</a> which is used to maintain F1. This way every "select item" or subfile \
query is adaptable on-the-fly, without requiring recompilation, and there is no risk of disturbing critical parts of the system \
because a faulty query has no severe consequences.\
</p>\
<p>\
The service program is activated in named activation group CSYSSQLS because CLI resources are scoped to the job. Only call \
<code>RlsSpCSYSSQLS</code> when no other program in the job is using the service program. For example, program A is a "work with" \
program that is called from the menu (first program in the stack), which calls program B which is a "detail" program. Program \
B should NOT call <code>RlsSpCSYSSQLS</code>, or else program A would get an error when performing the next SQL CLI operation. \
However, because program A is the first in the program stack it should call <code>RlsSpCSYSSQLS</code> when it ends. See source \
member INCL_CI.\
</p>\
<p>\
By default server mode is not used, thus no separate job which executes the SQL CLI is started. See source member INCL_CI for \
info on how to enable server mode.\
</p>\
<p>\
The service program is normally used as follows. First procedure <code>SqlsDBExec</code> is called with an SQL SELECT statement \
(retrieved with <code>SqlsRtvStmt</code>) which returns a handle when successful. Then <code>SqlsBindCols</code> is called using \
the handle to bind the columns of the result set to program fields. Then <code>SqlsFetch</code> is called one or more times to \
retrieve the records of the result set. Procedure <code>SqlsStatus</code> returns a status code which describes the status of the \
last called procedure. It returns 100 when <code>SqlsFetch</code> has been called at the end of the result set. When all records \
have been fetched <code>SqlsCloseCurs</code> must be called to close the cursor and <code>SqlsDBExec</code> can be called again \
for the same connection. See application <a href="#cafsqls">CAFSQLS</a> for a "work with" example, and see procedure <code>SelSqlStmtId</code> \
in service program <a href="#cappdisp">CAPPDISP</a> (module SI) for a "select item" example.\
</p>\
<p class="spop1">\
<b>MODULES</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;CI</span>\
<span class="g12">\
<span class="spodesc">Call Interface</span><br>\
Implements the API for the SQL Call Level Interface.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;RM</span>\
<span class="g22">\
<span class="spodesc">Resource Management</span><br>\
If no other program in the same job is using SQL CLI resources, then procedure <code>RlsSpCSYSSQLS</code> can be called to \
release all resources that are allocated by the service program.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;SS</span>\
<span class="g32">\
<span class="spodesc">Statement Storage</span><br>\
Provides access to the stored SQL statements. Procedure <code>SqlsRtvStmt</code> returns an SQL statement which has been \
stripped of blank lines and comment lines. Comment lines are lines where the first two non-blank characters are "//".\
</span>\
</span>\
</p>\
<p class="spop2">\
<b>OBJECTS</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;C1</span>\
<span class="g12">\
<span class="spodesc">Command 1: Edit SQL Statement</span><br>\
Command to add or edit SQL statements in file F1 (with EDTF). Program 1 is the command processor. The command has one \
keyword, ID, which is the id of the new or existing SQL statement.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;FR</span>\
<span class="g22">\
<span class="spodesc">Field Reference File</span><br>\
Defines attribute types <code>TSQLS_ID</code> (Stmt ID), <code>TSQLS_LNO</code> (Stmt Lineno), <code>TSQLS_LINE</code> (Stmt Line).\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;F1</span>\
<span class="g32">\
<span class="spodesc">File 1: SQL Statements</span><br>\
Contains SQL Statements. Application <a href="#cafsqls">CAFSQLS</a> is used to maintain this file. SQL statements can also be added \
or edited with command C1.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;P0</span>\
<span class="g42">\
<span class="spodesc">Program 0: Initial Data Load</span><br>\
When the service program is built then this program is called to load file F1 with initial data. \
Files that already exist when build program CSYSSQLSB1 is called are not affected.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;P1</span>\
<span class="g52">\
<span class="spodesc">Program 1: Edit SQL Statement</span><br>\
Add or edit an SQL statement in file F1 (with EDTF). This program is the command processor for C1.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;P8</span>\
<span class="g62">\
<span class="spodesc">Program 8: Release SP/RCLACTGRP CSYSSQLS</span><br>\
Call this program to release all allocated resources of the service program (i.e. it calls program P9), and reclaim (remove) \
activation group CSYSSQLS. This does not release CLI resources such as open cursors, just the service program\'s resources. \
CLI resources are released explicitly, e.g. by calling <code>SqlsCloseCurs</code>, or when the job ends.\
</span>\
<span class="g71"><span class="bullet1">&#9679;</span>&nbsp;P9</span>\
<span class="g72">\
<span class="spodesc">Program 9: Release SP CSYSSQLS</span><br>\
Call this program to release all allocated resources of the service program (it calls <code>RlsSpCSYSSQLS</code>).\
</span>\
</span>\
</p>\
</div>\
\
');
