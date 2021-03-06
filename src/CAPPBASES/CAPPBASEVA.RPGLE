
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Module VA for *SRVPGM CAPPBASE

       // Service Program: Common App Services / Base
       // Module         : Value Arrays


       // Each value array is a compile-time array that is EXPORTed from
       // this module AND service program (they are public). As such each
       // value array name must be included in the binder source of the
       // service program.

       // IMPORTANT NOTE:
       // By encapsulating the value arrays into this module, changes to
       // these values are more easily implemented because in many cases
       // it only requires changing and recompiling this module, e.g. when
       // a specific value needs to be changed. However, more work can be
       // needed when a value array is added or removed, or when a value
       // is added to or removed from a value array (the array becomes
       // bigger or smaller). This is because these changes affect the
       // public interface of the module (service program) and thus requires
       // recompilation of all client programs. This can be somewhat miti-
       // gated using the rules below.
       //   1) When adding a new value array, add the name at the very end
       //      of the binder source. This way existing programs do not have
       //      to be recompiled.
       //   2) When adding a new value to the end of an existing array, only
       //      those programs that really need to know about the new values
       //      must be recompiled. Existing programs will work without recom-
       //      pilation; they can't access the new values.


      /DEFINE CAPPBASE_MODULE
      /DEFINE CAPPBASE_CAPPBASEVA

      /include CAPPBASES,INCL__MODH


      /include CAPPBASES,INCL__VA

      /include CAPPBASES,INCL__MODD


       // ----- Value Arrays

     d*VAAB_XXX         s              1  0    dim(  5) export ctdata
     d*                                     perrcd(  5)


       // ----- Implementation - Internal


     pI_RlsModVA       b                   export
     dI_RlsModVA       pi

      /free

       return;

      /end-free
     p                 e


**XXX *
12345
