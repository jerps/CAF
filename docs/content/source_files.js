document.write('\
\
<h2 id="source_files">Source Files</h2>\
<div class="lvl2">\
<p>\
All source members to create the modules and other associated objects for a service program are \
contained in one source file. The name is the same as the service program but with an "S" appended \
to it. For example the sources for service program CSYSBASE are all in source file CSYSBASES.\
</p>\
<p>\
Besides the source files for the service programs the following source files are used:<br>\
<span style="display: grid; grid-template-columns: 15ch auto; grid-template-rows: auto;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;TOOLSRC</span>\
<span class="g12">\
Contains the sources for the compile/build tools, such as command CO (Compile Object), and \
some utilities. It also contains the REXX build script CAFBUILD which builds the whole library.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;QRPGLESRC</span>\
<span class="g22">\
Contains the RPGLE source member for each application.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;QDDSSRC</span>\
<span class="g32">\
Contains the DDS (DisplayFile) source member for each application.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;QCLLESRC</span>\
<span class="g42">\
Contains the CLLE source member for each application to implement the command processor \
for the command used to start the application.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;QCMDSRC</span>\
<span class="g52">\
Contains the CMD source member for each application for the command used to start the application.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;QINCSRC</span>\
<span class="g62">\
Contains <code>/include</code> sources.\
</span>\
</span>\
</p>\
</div>\
\
');
