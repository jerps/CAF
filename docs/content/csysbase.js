document.write('\
\
<h3 id="csysbase"><span style="font-family: roboto mono; font-weight: bold;">CSYSBASE</span> (Base)</h3>\
<div class="lvl3">\
<p>\
Provides generic "base" functionality.\
</p>\
<p style="margin: 2rem 0 0 2rem;">\
<b>MODULES</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;CV</span>\
<span class="g12">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Conversions</span><br>\
For example, convert text to an integer and vice versa, or convert text from one CCSID to another.\
</span>\
<span class="g21"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;DF</span>\
<span class="g22">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">DisplayFile</span><br>\
Provides functionality and constants pertaining to the use of display files. For example, a workstation \
information ds, key scancode constants and procedures to retrieve cursor row/column.\
</span>\
<span class="g31"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;DT</span>\
<span class="g32">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Date/Time functions</span><br>\
Implements handling of dates and times. Dates can be represented as gregorian dates (year, month, day) and week dates \
(year, week number 1-53, weekday 1-7). Dates can be validated, converted between different formats, split into \
their components, etc. The module implements "Non-Workdays" and their types with which, for example, feast days and \
holidays can be registered. Procedure <code>AddWorkdays</code> is used to add a number of workdays to a date, <code>RtvNwdType</code> is \
used to query whether a date is a certain type of non-workday. Applications <a href="#cafnwd">CAFNWD</a> and <a href="#cafnwd">CAFNWDT</a> \
are used to register non-workdays and their types.\
</span>\
<span class="g41"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;RM</span>\
<span class="g42">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Resource Management</span><br>\
Use procedure <code>RlsSpCSYSBASE</code> to release all resources that are allocated by the service program.\
</span>\
<span class="g51"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;TU</span>\
<span class="g52">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Text Utilities</span><br>\
Provides basic text oriented functionality. For example convert to uppercase/lowercase, format integer, substitute specific \
locations in a text with given parameters, concatenate texts, etc.\
</span>\
<span class="g61"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;WM</span>\
<span class="g62">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Work Management</span><br>\
Provides functionality related to work management. For example, querying whether the current job is interactive.\
</span>\
<span class="g71"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;XD</span>\
<span class="g72">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">XML Document</span><br>\
This module can be used to dynamically create a representation of an XML Document in memory. The element contents and \
attribute values are produced by (user defined) delegate procedures. Several procedures are provided to conveniently \
create the document using pre-defined delegate procedures. The XML document can be traversed with <code>XML_Iter</code>, or a text \
representation may be produced with <code>XML_AsText</code>.\
</span>\
<span class="g81"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;XX</span>\
<span class="g82">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Miscellaneous</span><br>\
Implements procedures that are not categorized (yet) into another module. For example: <code>MinInt</code>/<code>MaxInt</code>, \
<code>ExecCmd</code>/<code>ExecCmdCE</code>, <code>SortBytes</code>, <code>CondValChar</code>/<code>CondValInt</code>/<code>CondValDec</code>, \
<code>RtvObjText</code>.\
</span>\
</span>\
</p>\
<p style="margin: 2.5rem 0 0 2rem;">\
<b>OTHER OBJECTS</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;F0</span>\
<span class="g12">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">File 0: SysBase Values</span><br>\
Contains arbitrary system wide values. It stores records with a key, a value and a description. Intended to be updated with \
an external utility such as UPDDTA. Use procedure <code>GetSysBaseValue</code> to read a value from the file.\
</span>\
<span class="g21"><span class="bullet1" style="font-family: roboto mono; font-weight: bold;">&#9679;</span>&nbsp;F1</span>\
<span class="g22">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">File 1: Non-Workday Types</span><br>\
Contains non-workday types. Used by module DT. Application <a href="#cafnwd">CAFNWDT</a> is used to maintain this file.\
</span>\
<span class="g31"><span class="bullet1" style="font-family: roboto mono; font-xweight: bold;">&#9679;</span>&nbsp;F2</span>\
<span class="g32">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">File 2: Non-Workdays</span><br>\
Contains non-workdays. Used by module DT. Application <a href="#cafnwd">CAFNWD</a> is used to maintain this file.\
</span>\
<span class="g41"><span class="bullet1" style="font-family: roboto mono; font-xweight: bold;">&#9679;</span>&nbsp;P0</span>\
<span class="g42">\
<span style="font-family: roboto mono; font-weight: bold; text-decoration-line: underline;">Program 0: Initial Data Load</span><br>\
When the service program is built then this program is called to load newly created files with initial data.\
</span>\
</span>\
</p>\
</div>\
\
');
