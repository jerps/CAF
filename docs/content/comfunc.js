document.write('\
\
<h2 id="comfunc">Common Functionality</h2>\
<div class="lvl2">\
<p>\
Applications <a href="#cafnwd">CAFNWD</a>, <a href="#cafnwdt">CAFNWDT</a>, <a href="#cafmenug">CAFMENUG</a> and <a href="#cafsqls">CAFSQLS</a> \
are "work with" applications. I.e. they present a list of items (records) which can be created, displayed, updated and deleted. Application \
<a href="#cafmenu">CAFMENU</a> is different in that it displays or updates the menu. There is only one menu which is always present.\
</p>\
<p>\
Depending on the application, the presented list shows more columns in 132 column (or wide) mode.\
<p>\
Usually the presented list in a "work with" application can be sorted on one or more attributes. Below the column headers \
a value can be entered after which, when pressing Enter, the list is positioned on that value (or values).\
</p>\
<p>\
A new item or record is always created by pressing <b>F6</b>.\
</p>\
<p>\
Above the column headers of the presented list are usually one or more options displayed. One can enter an option \
before one or more lines in the list to take an action on that item or record, after pressing Enter. The following \
options are common.\
<div class="item1-h">2=Update</div>\
<div class="item1-d">\
Update the item or record.\
</div>\
<div class="item1-h">3=Copy</div>\
<div class="item1-d">\
Copy the item or record.\
</div>\
<div class="item1-h">4=Delete</div>\
<div class="item1-d">\
Delete the item or record.\
</div>\
<div class="item1-h">5=Display</div>\
<div class="item1-d">\
Display the item or record.\
</div>\
</p>\
<p>\
The applications are run with commands CAFNWD, CAFNWDT, CAFMENU, CAFMENUG and CAFSQLS. Each command has \
two parameters, which are both optional.\
<div class="item1-h">MODE</div>\
<div class="item1-d">\
Is <code>*DISPLAY</code> when records only need to be displayed. Editing or updating is not allowed. Is \
<code>*EDIT</code>, or <code>*UPDATE</code> for CAFMENU, if records need to be created, updated or deleted. \
Is <code>*SELECT</code> to select one item from the list and fill the corresponding RPGLE return parameter \
with the selected value (the commands have no return parameter for selection). The default is <code>*DISPLAY</code>.\
</div>\
<div class="item1-h">SPCBHVR</div>\
<div class="item1-d">\
Zero or more special behavior codes. Each has some specific effect to the application\'s behavior. For example, when \
code <code>X</code> is used then function key F9 (resize screen) is not allowed. See the RPGLE sources for a \
complete list of possible codes.\
</div>\
</p>\
<p>\
See the RPGLE source code for detailed information.\
</p>\
</div>\
\
');
