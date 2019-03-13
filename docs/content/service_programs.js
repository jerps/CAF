document.write('\
\
<h1 id="service_programs">Service Programs</h1>\
<p>\
The service programs that are part of CAF provide common functionality. Service programs with \
a name starting with CSYS (common system) provide "system" level functionality. This is generic \
functionality such as date handling that is not specific for the application structure that \
is used by CAF. The ones with a name starting with CAPP provide "application" level functionality \
that is meant to be used for implementing (5250) applications that utilize the specific structuring \
of application code as is used by CAF. See the CAF* programs in QRPGLESRC as examples.\
</p>\
<p>\
All service programs, except <a href="#cappsqls">CAPPSQLS</a>, are activated in the activation group of the \
program that uses them (i.e. *CALLER).\
</p>\
<p>\
Note that if a reference is made to module XX this may mean any module (i.e. with any id consisting of \
two characters), or specifically module XX which is actually present in most service programs. This \
depends on the context.\
</p>\
\
');
