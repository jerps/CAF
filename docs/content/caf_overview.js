document.write('\
\
<h1 id="caf_overview">CAF Overview</h1>\
<p>\
CAF (Common Application Framework) is a framework for building IBM i (AS/400) ILE RPGIV \
programs. It consists of several service programs in a layered structure containing common \
code (components / generic functions) for (interactive) applications, providing an extensible \
structure on which applications can be build. Part of the common code is generic and can be \
used in any program, such as date handling. Other common code is specifically geared towards \
implementing interactive 5250 applications utilizing a specific code structure and organization.\
</p>\
<p>\
Several 5250 applications are included, such as a menu system, which utilize the framework. \
Besides providing useful functionality these applications can be used as examples and as \
copy-source (templates) for new applications.\
</p>\
<p>\
The sources have lots of comments which, in addition to the docs, give detailed information \
about the code.\
</p>\
<p>\
CAF is compatible with V5R4 and up.\
</p>\
<p>\
CAF has the following components:\
</p>\
<br>\
<div style="position: relative; left: 5%;">\
<img src="images/caf_overview.png">\
</div>\
\
');
