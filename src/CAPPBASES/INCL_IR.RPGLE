
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CAPPBASE_INCL_IR)
      /EOF
      /ENDIF
      /DEFINE CAPPBASE_INCL_IR


       // INCLUDE: *SRVPGM CAPPBASE

       // Module IR: Interpret Raw input


       // Each procedure in this module:
       //   - Interprets one alpha-numeric field with raw data,
       //     e.g. a number, an amount or a date.
       //   - Returns *on if the field is correctly interpreted, or
       //     *off if the field contains invalid data.
       //   - Has an input parameter named "data" which contains the
       //     data to be interpreted.
       //   - Has an output parameter named "value" which contains
       //     the sanitized/normalized/canonical value of the data,
       //     IF the procedure returns *on.

       // NOTES:
       //   - For numeric data, a blank field is always interpreted as 0.
       //   - The group separator for numbers is given with NumSepGrp().
       //   - The decimal separator for numbers is  given with NumSepDec().


      /include CAPPBASES,INCL_DEFS


       // ----- Prototypes

       // IrNumber - Interpret Raw input: Number
       // Interpret a number which consists of digits, maybe a decimal/minus
       // sign, and zero or more group seperators.
       // The minus sign may appear as the first or the last character.
       // If given, parameter "digits" specifies the number of significant
       // digits that are allowed (the precision). This is the total number
       // of digits before and after the decimal sign not including any
       // leading zeros, and not including trailing zeros in case of a decimal
       // sign. A positive value specifies the maximum number of significant
       // digits that are allowed. If this value is negative it's absolute
       // value specifies that "data" must contain exactly that number of
       // significant digits.
       // If given, parameter "dec" specifies the number of significant
       // decimal digits that are allowed (i.e. the digits following the
       // decimal sign not including trailing zeros). A zero or positive
       // value specifies that "data" must contain at most "dec" significant
       // decimal digits. If this parameter's value is negative it's absolute
       // value specifies the exact number of significant decimal digits
       // that are allowed. If parameter "dec" is not given then up to 9
       // significant decimal digits are allowed.
       // Optional parameter "inpopt" may contain one or more of the following
       // input options:
       //   "+" - only a non-negative number is allowed (no minus sign);
       //   "g" - no group separators are allowed.
     d IrNumber        pr              n   extproc('IrNumber')
     d   data                        30    const
     d   value                       30  9
     d   digits                       1  0 const options(*nopass)
     d   dec                          1  0 const options(*nopass)
     d   inpopt                      10    const options(*nopass)

       // IrWkDate - Interpret Raw input: Week Date
       // Interpret a week number, given in the format "yywwd".
       // Any character that is not a digit is ignored. The numeric value
       // in "data" is left padded with zeros.
     d IrWkDate        pr              n   extproc('IrWkDate')
     d   data                        10    const
     d   value                         d

