document.write('\
\
<h2 id="cafnwd">CAFNWD (Work with Non-Workdays)</h2>\
<div class="lvl2">\
<p>\
This application is used to specify non-workdays, i.e. days no work is being performed such as christmas and sundays. \
Non-workdays can be specified with (part of) a gregorian date, format yyyymmdd, or a week date, format yyyywwd, where ww is a number \
from 1 to 53 and d is 1 for monday and 7 for sunday. For example, to specify that all weekends are non-workdays one would \
add two records, specifying a week date consisting of only day number 6 and 7.\
</p>\
<p>\
When specifying a gregorian or week date, the year, month and week number are optional.\
</p>\
<p>\
Non-workdays have a predefined type, such as W for week-end or H for holiday. The list of non-workday types is maintained \
with application <a href="#cafnwdt">CAFNWDT</a>. There is a special non-workday type, identified with an asterisk (*), which \
indicates that a non-workday is actually a workday. With this type one can make an exception. For example, suppose every 25th of \
december is a non-workday. To make an exception for 2019, specify non-workday 20191225 with type * to indicate that this specific \
day is NOT a non-workday; it is a normal workday.\
</p>\
<p>\
Non-workdays are stored in file CSYSBASEF2.\
</p>\
<p>\
Execute "CAFNWD *EDIT". If file CSYSBASEF2 did not change since the installation of CAF then the following screen is displayed.\
<image class="screenshot" src="images/screen001.png">\
</p>\
<p>\
The current year is automatically filled in on the position field, and the list positions from that year. There are no records \
with year 2019 and further. Blank the position field (or enter 0) and press Enter to reposition the list from the start (year 0). \
The following screen is shown.\
<image class="screenshot" src="images/screen002.png">\
</p>\
<p>\
Now we see the initial data in the non-workday file, which specifies that every saturday and sunday is a week-end, and every 25st \
of december is a feast day, and every 1st of january is a holiday.\
</p>\
<p>\
When F9 is pressed (switch to 132 columns, wide mode) an extra "Day" column is displayed which shows a description of the specified \
day.\
<image class="screenshot" src="images/screen003.png">\
</p>\
<p>\
To specify a new non-workday, for example 20191101, press F6 to add an empty line to the list, enter the date on the line and press \
F4 with the cursor on the "Type" column to select the type.\
<image class="screenshot" src="images/screen004.png">\
</p>\
<p>\
Press Enter to save. An <b>A</b> appears to the right to indicate that the line was just added. Column "A/U" indicates the lines \
that were added or updated.\
<image class="screenshot" src="images/screen005.png">\
</p>\
<p>\
In the list only the "Type" attribute can be changed. The other attributes are part of the record key and can not be changed. \
To change these one must first delete the record and then add it again. For illustration, to change the type of the new non-workday \
to feast enter a "F" in the type attribute and press Enter. Now a <b>U</b> is displayed at the right to indicate that the line was \
updated.\
<image class="screenshot" src="images/screen006.png">\
</p>\
<p>\
To delete the line again, enter a "4" at the beginning of the line and press Enter. A confirmation is shown, choose "Y" and press Enter. \
The record is deleted. This is shown by displaying the line in red.\
<image class="screenshot" src="images/screen007.png">\
</p>\
<p>\
Press F5 to refresh the screen. The red line is now gone.\
</p>\
</div>\
\
');
