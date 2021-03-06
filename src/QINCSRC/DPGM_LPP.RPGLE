
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // L_SetErr - Set Error
       // Set "Err.e" to *on, set "DspMsg" to "msg", and set
       // "Err.flds" to field names "fld1" .. "fld7".
       // If "fld1" .. "fld7" is not given then "Err.flds" is cleared.
     d L_SetErr        pr
     d   msg                        130    const
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

       // L_SetErrQds - Set Error with "Qds" data structure
       // Set "Err.e" to *on, and set "DspMsg" and "Err.flds" using
       // the "msg" and "dbf" subfields of the data structure provided
       // with "qds". Then, add the field names provided with parameters
       // "fld1" .. "fld7" that were not already in "Qds" to "Err.flds".
       // See "SetQdsDs" in service program CAPPBASE for more info about
       // the "Qds" data structure and it's format.
     d L_SetErrQdsDs   pr
     d   qds                      30000          options(*varsize)
     d   fld1                        12    const options(*nopass)
     d   fld2                        12    const options(*nopass)
     d   fld3                        12    const options(*nopass)
     d   fld4                        12    const options(*nopass)
     d   fld5                        12    const options(*nopass)
     d   fld6                        12    const options(*nopass)
     d   fld7                        12    const options(*nopass)

       // L_AddErrFld - Add Error Field
       // Add field name "fld" to array "Err.flds", if not already added.
     d L_AddErrFld     pr
     d   fld                         12    const

