document.write('\
\
<h1 id="compobj">Compiling Objects</h1>\
<p>\
Command CO (Compile Object) is used to compile objects from a source member. See source member CO in sourcefile TOOLSRC \
for more information.\
</p>\
<p>\
Command CO compiles objects of type *PGM (CLP, CLLLE, RPG, RPGLE), *MODULE, *FILE (DSPF, PF, LF), and *CMD. The object type \
is determined using the source member type. Use *MODULE for keyword TGTOBJTYPE to compile a module.\
</p>\
<p>\
An RPG or RPGLE source may contain <i>before</i> commands and/or <i>after</i> commands which are executed *before* an \
object is compiled and *after*, resp. For example to override a file before compiling and removing the override when compiling \
ends. A command can occupy at most one line which must be a comment. A <i>before</i> command must start with "*$B" in positions \
7-9 for an RPG source, or it must start with any number of blanks followed by "//$B" for an RPGLE source. An <i>after</i> command \
is specified by using an A instead of a B, i.e. "*$A" and "//$A". A source may contain multiple <i>before</i> and <i>after</i> \
commands.\
</p>\
\
');
