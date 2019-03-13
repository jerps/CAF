document.write('\
\
<h3 id="csyssqls"><span style="font-family: roboto mono; font-weight: bold;">CSYSSQLS</span> (SQL Statements)</h3>\
<div class="lvl3">\
<p>\
This service program is a simple API for the SQL Call Level Interface. SQL statements can be stored in and retrieved from file F1. \
The main purpose of this service program is to store and execute all SQL SELECT statements that are used to fill a subfile to select \
an item with F4 (see service program <a href="#cappdisp">CAPPDISP</a>) or to fill the subfile for a "work with" program. As an example \
see application <a href="#cafsqls">CAFSQLS</a> which is used to maintain F1.\
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
By default server mode is not used, thus no separate job which executes the SQL CLI is started. See source member INCL_CI for info \
on how to enable server mode.\
</p>\
<p>\
The service program is normally used as follows. First procedure <code>SqlsDBExec</code> is called with an SQL SELECT statement (retrieved \
with <code>SqlsRtvStmt</code>). Note that the SQL statement text MUST start with "SELECT" to use a cursor (i.e. only then a "handle" \
is returned that can be used for fetching). Then <code>SqlsBindCols</code> is called to bind the columns of the result set to program fields. \
Then <code>SqlsFetch</code> is called one or more times to retrieve the records of the result set. Procedure <code>SqlsStatus</code> returns \
a status code which describes the status of the last called procedure. It returns 100 when <code>SqlsFetch</code> has been called at the end of \
the result set. When all records have been fetched <code>SqlsCloseCurs</code> can be called to close the cursor and <code>SqlsDBExec</code> \
can be called again for the same connection. See application <a href="#cafsqls">CAFSQLS</a> for an example.\
</p>\
</div>\
\
');

