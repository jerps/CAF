
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPSSAM_INCL_VA)
      /EOF
      /ENDIF
      /DEFINE CAPPSSAM_INCL_VA


       // INCLUDE: *SRVPGM CAPPSSAM

       // Module VA: Value Arrays


       // This module encapsulates all "value arrays" for this subsystem.
       // A "value array" is simply an array containing a list of values,
       // e.g. the allowable values for a database field.

       // Each value array is publicly defined in this member and IMPORTed
       // from the service program which actually fills these arrays when
       // it is initialized.

       // The name of a value array always starts with "VA.._", where ..
       // is the subsystem id.


      /include CAPPSSAMS,INCL_DEFS


       // ----- Value Arrays

       // XXX - Xxx
     d*VAAM_XXX         s                   dim(  5) import like(TAM_XXX)

