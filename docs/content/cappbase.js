document.write('\
\
<h3 id="cappbase"><span style="font-family: roboto mono; font-weight: bold;">CAPPBASE</span> (Base)</h3>\
<div class="lvl3">\
<p>\
Provides application "base" functionality.\
</p>\
<p class="spop1">\
<b>MODULES</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;AM</span>\
<span class="g12">\
<span class="spodesc">Application Messages</span><br>\
Contains messages for subsystem AB.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;IR</span>\
<span class="g22">\
<span class="spodesc">Interpret Raw Input</span><br>\
Procedures to interpret a field with alphanumeric "raw" input data. For example <code>IrNumber</code> interprets alphanumeric input \
parameter <code>data</code>. Numeric output parameter <code>value</code> contains the interpreted numeric value.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;MS</span>\
<span class="g32">\
<span class="spodesc">Message Support</span><br>\
Implements support for handling application messages. Array <code>DspMsgList</code> is exported which contains \
a list of messages to be displayed by an application. Procedure <code>AddToDspMgList</code> adds a message \
(optionally with associated data) to <code>DspMsgList</code>.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;PT</span>\
<span class="g42">\
<span class="spodesc">Presentation Texts</span><br>\
Implements procedures which have as input a value, such as a number, and return the text that represents the value which \
can be presented to users. For example <code>PtNumber</code> returns a presentation text for a number.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;RM</span>\
<span class="g52">\
<span class="spodesc">Resource Management</span><br>\
Call procedure <code>RlsSpCAPPBASE</code> to release all resources that are allocated by the service program.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;VA</span>\
<span class="g62">\
<span class="spodesc">Value Arrays</span><br>\
Exports constant values.\
</span>\
<span class="g71"><span class="bullet1">&#9679;</span>&nbsp;XX</span>\
<span class="g72">\
<span class="spodesc">Miscellaneous</span><br>\
Implements procedures that are not categorized (yet) into another module. For example: <code>NumSepDec</code>, <code>NumSepGrp</code>, \
<code>SetQdsDs</code>, <code>AddToAppOpts</code>.\
</span>\
</span>\
</p>\
</div>\
\
');
