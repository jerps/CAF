document.write('\
\
<h2 id="rstsavf">Restore from save file</h2>\
<div class="lvl2">\
<p>\
Directory <i>dist</i> in the GitHub repository contains save files in which a version of the CAF library \
for a specific IBM i release is stored. For example, CAF1000R72.SAVF contains library CAF1000 and objects \
are compiled for IBM i release 7.2 (TGTRLS V7R2M0).\
</p>\
<p>\
On a workstation, either directly download a save file from the repository\'s <i>dist</i> directory, or clone \
the repository using the following command.\
</p>\
<pre class="pcode">\
git clone https://github.com/jerps/CAF.git\
</pre>\
<p>\
Assuming we want to use save file CAF1000R72.SAVF, on the target IBM i (the host) create a new save file in library QGPL.\
</p>\
<pre class="pcode">\
CRTSAVF FILE(QGPL/CAF1000R72)\
</pre>\
<p>\
On the workstation where the save file is located, start ftp and logon to the host.\
</p>\
<pre class="pcode">\
ftp &lt;host&gt;\
</pre>\
<p>\
In ftp, issue the following commands to upload the save file to the host. The save file is assumed to be \
in local directory &lt;savefiledir&gt;.\
</p>\
<pre class="pcode">\
bin<br>\
lcd &lt;savefiledir&gt;<br>\
cd QGPL<br>\
put CAF1000R72.SAVF CAF1000R72<br>\
quit\
</pre>\
<p>\
Now, on the host, restore the CAF library.\
</p>\
<pre class="pcode">\
RSTLIB SAVLIB(CAF1000) DEV(*SAVF) SAVF(QGPL/CAF1000R72)\
</pre>\
<p>\
The restored library and the objects within it all have QPGMR as their owner. *PUBLIC authority of the objects \
is set to *CHANGE. See <a href="#objauth">Setting object authorities</a> to change the owner and/or set other \
object authorities.\
</p>\
<p>\
To use CAF, add the library to the library list.\
</p>\
</div>\
\
');
