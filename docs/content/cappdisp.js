document.write('\
\
<h3 id="cappdisp"><span style="font-family: roboto mono; font-weight: bold;">CAPPDISP</span> (Display)</h3>\
<div class="lvl3">\
<p>\
This service program implements generic "display" functions, for example to display a list of items from which the user may choose.\
</p>\
<p class="spop1">\
<b>MODULES</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;HD</span>\
<span class="g12">\
<span class="spodesc">Handle Display</span><br>\
This module only contains internal procedures. The actual implementation of all display functions is concentrated in this module.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;RM</span>\
<span class="g22">\
<span class="spodesc">Resource Management</span><br>\
Call procedure <code>RlsSpCAPPDISP</code> to release all resources that are allocated by this service program.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;SI</span>\
<span class="g32">\
<span class="spodesc">Select Item</span><br>\
Provides procedures that can be called to present a list of items to choose from. Procedure <code>SelectSimpleValue</code> is a generic \
procedure to present an arbitrary list of values from which one value can be chosen. For example <SelNwdType> is a specific \
procedure to present a list of non-work day types to choose from.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;XX</span>\
<span class="g42">\
<span class="spodesc">Miscellaneous</span><br>\
For example, procedure <code>DspHelp</code> to display help text, or procedure <code>PresentConfWdw</code> to present a \
confirmation window.\
</span>\
</span>\
</p>\
<p class="spop2">\
<b>OBJECTS</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;D1</span>\
<span class="g12">\
<span class="spodesc">DisplayFile 1: Display Help</span><br>\
Defines the records to display help text.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;D2</span>\
<span class="g22">\
<span class="spodesc">DisplayFile 2: Select Item</span><br>\
Defines the records to display and select items.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;D3</span>\
<span class="g32">\
<span class="spodesc">DisplayFile 3: Display Messages (*NORMAL)</span><br>\
Defines the records to display application messages in *NORMAL mode (80 columns).\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;D4</span>\
<span class="g42">\
<span class="spodesc">DisplayFile 4: Display Messages (*WIDE)</span><br>\
Defines the records to display application messages in *WIDE mode (132 columns).\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;D9</span>\
<span class="g52">\
<span class="spodesc">DisplayFile 9: Miscellaneous</span><br>\
Defines miscellaneous records.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;F1</span>\
<span class="g62">\
<span class="spodesc">File 1: Help Texts</span><br>\
Contains help texts. Each record has a "context" attribute, a line number and the text of the line. The "context" \
attribute is used to select the correct help text. The default help text has a blank context.\
</span>\
<span class="g71"><span class="bullet1">&#9679;</span>&nbsp;P0</span>\
<span class="g72">\
<span class="spodesc">Program 0: Load Initial Data</span><br>\
When the service program is built then this program is called to load file F1 with \
initial data. I.e. the default help text (with blank context).\
</span>\
</span>\
</p>\
</div>\
\
');
