document.write('\
\
<h3 id="csysbase"><span style="font-family: roboto mono; font-weight: bold;">CSYSBASE</span> (Base)</h3>\
<div class="lvl3">\
<p>\
Provides system "base" functionality.\
</p>\
<p class="spop1">\
<b>MODULES</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;CV</span>\
<span class="g12">\
<span class="spodesc">Conversions</span><br>\
For example, convert text to an integer and vice versa, or convert text from one CCSID to another.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;DF</span>\
<span class="g22">\
<span class="spodesc">DisplayFile</span><br>\
Provides functionality and constants pertaining to the use of display files. For example, a workstation \
information ds, key scancode constants and procedures to retrieve cursor row/column.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;DT</span>\
<span class="g32">\
<span class="spodesc">Date/Time functions</span><br>\
Implements handling of dates and times. Dates can be represented as gregorian dates (year, month, day) and week dates \
(year, week number 1-53, weekday 1-7). Dates can be validated, converted between different formats, split into \
their components, etc. The module implements "Non-Workdays" and their types with which, for example, feast days and \
holidays can be registered. Procedure <code>AddWorkdays</code> is used to add a number of workdays to a date, <code>RtvNwdType</code> is \
used to query whether a date is a certain type of non-workday. Applications <a href="#cafnwd">CAFNWD</a> and <a href="#cafnwd">CAFNWDT</a> \
are used to register non-workdays and their types.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;RM</span>\
<span class="g42">\
<span class="spodesc">Resource Management</span><br>\
Call procedure <code>RlsSpCSYSBASE</code> to release all resources that are allocated by this service program.\
</span>\
<span class="g51"><span class="bullet1">&#9679;</span>&nbsp;TU</span>\
<span class="g52">\
<span class="spodesc">Text Utilities</span><br>\
Provides basic text oriented functionality. For example convert to uppercase/lowercase, format integer, substitute specific \
locations in a text with given parameters, concatenate texts, etc.\
</span>\
<span class="g61"><span class="bullet1">&#9679;</span>&nbsp;WM</span>\
<span class="g62">\
<span class="spodesc">Work Management</span><br>\
Provides functionality related to work management. For example, querying whether the current job is interactive.\
</span>\
<span class="g71"><span class="bullet1">&#9679;</span>&nbsp;XD</span>\
<span class="g72">\
<span class="spodesc">XML Document</span><br>\
This module can be used to dynamically create a representation of an XML document in memory. The element contents and \
attribute names and values are produced by (user defined) delegate procedures. Several procedures are provided to conveniently \
create an XML document using pre-defined delegate procedures. The XML document can be traversed with <code>XML_Iter</code>, \
or a text representation may be produced with <code>XML_AsText</code>. The following code (in **free RPG) creates an XML document \
and assigns it to variable <code>xml</code>. The document consists of root element "Order" with two "Line" elements, each having \
an "Item" and a "Qty" element. Then it creates creates a text representation of the XML encoded in UTF-8, with indentation, assigns \
it to pointer-to-array-of-pointers-to-C-string <code>text</code>, and releases the XML document. Then it displays the text document \
by displaying (with <code>DSPLY</code>) each line, while letting RPG automatically convert from UTF-8 to EBCDIC, while also releasing \
each displayed line. Lastly it releases <code>text</code>. Because DSPLY can only display 52 characters the XML declaration will be \
truncated. Note that older versions of IBM i do not support **free RPG, or automatic CCSID conversion between fields (need %ucs2 for \
assigning literal to UCS-2 field), or <code>CCSID(*UTF8)</code>/<code>CCSID(*UTF16)</code>. However, <code>CCSID(*UTF16)</code> is \
practically the same as <code>CCSID(*UCS2)</code>. Assigning to <code>d52</code> is not really necessary.<br>\
</span>\
</span>\
<pre class="spopcode">\
// Define needed variables.<br>\
dcl-s xml pointer;<br>\
dcl-s textlines pointer dim(100) based(text);<br>\
dcl-s numlines int(10);<br>\
dcl-s i int(10);<br>\
dcl-s d52 char(52);<br>\
dcl-ds *n;<br>\
  line1 varchar(100);<br>\
  line2 varchar(100) ccsid(*utf8) pos(1);<br>\
end-ds;<br>\
<br>\
// Create XML document.<br>\
xml = XML_AddE(XML_R(\'Order\')<br>\
          :XML_AddE(XML_E(\'Line\')<br>\
            :XML_EC(\'Item\':\'Hammer\'):XML_EC(\'Qty\':\'1\'))<br>\
          :XML_AddE(XML_E(\'Line\')<br>\
            :XML_EC(\'Item\':\'Nail\'):XML_EC(\'Qty\':\'100\')));<br>\
<br>\
// Create text lines.<br>\
text = XML_AsText(xml:\'UTF-8\':numlines:\'  \');<br>\
// Release XML document.<br>\
XML_Release(xml);<br>\
<br>\
// Display text lines.<br>\
for i = 1 to numlines;<br>\
  // Display text line i.<br>\
  line1 = %str(textlines(i));<br>\
  d52 = line2; // utf-8 -> ebcdic<br>\
  dsply d52;<br>\
  // Release text line i.<br>\
  dealloc textlines(i);<br>\
endfor;<br>\
// Release text.<br>\
dealloc text;<br>\
</pre>\
</p>\
<p class="spop0">\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;XX</span>\
<span class="g12">\
<span class="spodesc">Miscellaneous</span><br>\
Implements procedures that are not categorized (yet) into another module. For example: <code>MinInt</code>, <code>MaxInt</code>, \
<code>ExecCmd</code>, <code>ExecCmdCE</code>, <code>SortBytes</code>, <code>CondValChar</code>, <code>CondValInt</code>, \
<code>CondValDec</code>, <code>RtvObjText</code>.\
</span>\
</span>\
</p>\
<p class="spop2">\
<b>OBJECTS</b>:<br>\
<br>\
<span style="display: grid; grid-template-columns: 7ch auto; grid-template-rows: auto; grid-gap: 0.8rem;">\
<span class="g11"><span class="bullet1">&#9679;</span>&nbsp;F0</span>\
<span class="g12">\
<span class="spodesc">File 0: SysBase Values</span><br>\
Contains arbitrary system wide values. It stores records with a key, a value and a description. Intended to be updated with \
an external utility such as UPDDTA. Use procedure <code>GetSysBaseValue</code> to read a value from the file.\
</span>\
<span class="g21"><span class="bullet1">&#9679;</span>&nbsp;F1</span>\
<span class="g22">\
<span class="spodesc">File 1: Non-Workday Types</span><br>\
Contains non-workday types. Used by module DT. Application <a href="#cafnwd">CAFNWDT</a> is used to maintain this file.\
</span>\
<span class="g31"><span class="bullet1">&#9679;</span>&nbsp;F2</span>\
<span class="g32">\
<span class="spodesc">File 2: Non-Workdays</span><br>\
Contains non-workdays. Used by module DT. Application <a href="#cafnwd">CAFNWD</a> is used to maintain this file.\
</span>\
<span class="g41"><span class="bullet1">&#9679;</span>&nbsp;P0</span>\
<span class="g42">\
<span class="spodesc">Program 0: Load Initial Data</span><br>\
When the service program is built then this program is called to load files F0, F1 and F2 with initial data. \
Files that already exist when build program CSYSBASEB1 is called are not affected.\
</span>\
</span>\
</p>\
</div>\
\
');
