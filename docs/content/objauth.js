document.write('\
\
<h2 id="objauth">Setting object authorities</h2>\
<div class="lvl2">\
<p>\
After installing CAF the library and objects in it have a default owner and default authorities.\
</p>\
<p>\
Command SETCAFAUT is used to change the owner of the CAF library and all objects in it, or to set authorities \
for all or some of the objects in the CAF library. For more information about the command\'s functions see source \
member SETCAFAUT in source file TOOLSRC.\
</p>\
<div style="display: flex; font-family: Arial; height: 4em; font-size: 110%;">\
<div style="margin: auto 0.5em auto 2em; color: red; font-weight: bold; font-size: 200%;">!</div>\
<div style="margin: auto 0 auto 0;">\
Specify *DFT for keyword CAFLIB (the default) to specify the CAF library that is in the library list.\
</div>\
</div>\
<p>\
The following command sets the owner of the library and all objects in it to user profile ITDEPT.\
</p>\
<pre class="pcode">\
SETCAFAUT OWNER(ITDEPT)\
</pre>\
<p>\
The following command sets *PUBLIC authority of every object (except source files and the menu objects) that is not a \
physical file or logical file to *USE. And *PUBLIC authority for every physical or logical file (except source files and \
the menu files) is set to *CHANGE. Source files and the files and data area of the menu are not affected.\
</p>\
<pre class="pcode">\
SETCAFAUT PUBAUTNPL(*USE) PUBAUTPL(*CHANGE) INCLMN(*NO) INCLSF(*NO)\
</pre>\
<p>\
The following command sets *PUBLIC authority of the menu files and menu data area to *USE. It grants *CHANGE \
authority to user profile MENUADM for these menu files and data area. User profile MENUADM is added to the *ADMIN \
<a href="#cafmenug">menu group</a>. The menu files and data area contain all the data of the menu. Only menu \
administrators (which should be member of group *ADMIN) should have *CHANGE authority for these objects.\
</p>\
<pre class="pcode">\
SETCAFAUT PUBAUTNPL(*USE) PUBAUTPL(*USE) INCLMN(*ONLY) MNUADMAUT(*GRT/MENUADM)\
</pre>\
</div>\
\
');
