document.write('\
\
<h2 id="buildsrc">Build from source</h2>\
<div class="lvl2">\
<p>\
To build the CAF library from source, the source must first be uploaded to the target IBM i (the host). This is done \
through ftp with a bash script. So a bash shell is needed. And ftp needs to be installed. On Windows the "Windows \
Subsystem for Linux" could be used for this.\
</p>\
<p>\
Open a bash shell on a workstation.\
</p>\
<p>\
In the shell create a new directory and cd into it. Then execute the following command to clone the CAF repository.\
</p>\
<pre class="pcode">\
git clone https://github.com/jerps/CAF.git\
</pre>\
<p>\
Then cd into the <i>bash</i> directory of the repository. Execute the following commands.\
</p>\
<pre class="pcode">\
chmod +x upload.sh download.sh<br>\
./upload.sh &lt;host&gt; &lt;user&gt;\
</pre>\
<p>\
Execute the upload script without arguments to see a description of all parameters.\
</p>\
<p>\
The upload script generates an ftp script and then executes it. The ftp script executes a number of commands on the host \
to create the library and source files. Then it uploads all source members and for each source member executes CHGPFM to \
set the source member\'s type and text.\
</p>\
<p>\
When the script is done it writes a command to the screen which can be copy/pasted into a command line on the host. \
This command must be executed to build the library from source (i.e. compile all objects). The command executes a \
generated REXX script.\
</p>\
<pre class="pcode">\
STRREXPRC SRCMBR(CAFBUILD) SRCFILE(&lt;caflib&gt;/TOOLSRC)\
</pre>\
<p>\
The library and the objects within it all have the current user as their owner. *PUBLIC authority is set to the default. \
See <a href="#objauth">Setting object authorities</a> to change the owner and/or set other object authorities.\
</p>\
<p>\
To use CAF, add the library to the library list.\
</p>\
</div>\
\
');
