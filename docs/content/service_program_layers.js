document.write('\
\
<h1 id="service_program_layers">Service Program Layers</h1>\
<p>\
The service programs that are part of CAF provide common functionality that is structured into layers. \
The lower a layer the more primitive the functionality it provides. All service programs are either \
part of the "system" layers or the "application" layers. The former constitute the lower layers and \
are named CSYS???? (common system) and the latter constitute the higher layers and are named CAPP???? \
(common application). The CSYS service programs provide generic functionality such as date handling that \
is not specific for the application structure that is used by CAF. The CAPP service programs provide \
"application" level functionality that is focused on implementing (5250) applications that utilize the \
specific CAF application code structure. See the CAF* programs in QRPGLESRC as examples.\
</p>\
<p>\
Service program <a href="#csysbase">CSYSBASE</a> represents the bottom layer and provides the most generic \
functionality. Service program <a href="#cappbase">CAPPBASE</a> represents the lowest "application" layer. It \
provides the most generic CAF application functionality. For example it implements the handling of errors that \
is needed when validating input. The top layer is represented by service program <a href="#cappdisp">CAPPDISP</a> \
which implements high level "display" functionality such as displaying the items which the user can choose after \
pressing function key F4. Inbetween the "base" and "display" application layers are the "<a href="#subsystems">SubSystem</a>" \
layers.\
</p>\
<p>\
This layered structure can be easily extended and modified by adding more layers or splitting existing ones, \
as needed. For example CAPPDISP now implements display functionality for all subsystems but it may be better \
to split that out into seperate "display" service programs that are subsystem specific. Part of the functionalty \
of CAPPDISP would move to a new service program, CSYSDISP, which becomes the highest "system" layer and would \
implement generic display functionality such as providing the mechanism to display a list of items. The higher \
level display service programs would collect the data and use CSYSDISP to display a list of items.\
</p>\
<p>\
All service programs, except <a href="#csyssqls">CSYSSQLS</a>, are activated in the activation group of the \
program that uses them (i.e. *CALLER).\
</p>\
\
');
