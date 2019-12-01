
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_TU)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_TU


       // INCLUDE: *SRVPGM CSYSBASE

       // Module TU: Text Utilities


      /include CSYSBASES,INCL_DEFS


       // ----- Prototypes

       // ToUppercase - To Uppercase
     d ToUppercase     pr          1000    varying extproc('ToUppercase')
     d   text                      1000    const varying

       // ToLowercase - To Uppercase
     d ToLowercase     pr          1000    varying extproc('ToLowercase')
     d   text                      1000    const varying

       // CharIsLetter - Character is A Letter
       // Return *on if "char" is a letter (a-z, A-Z), else return *off.
       // If "option" is given with value "*UCASE" or "*LCASE" then return
       // *on if "char" is an uppercase or lowercase letter, resp., else
       // return *off.
     d CharIsLetter    pr              n   extproc('CharIsLetter')
     d   char                         1    const
     d   option                      10    const options(*nopass)

       // CharIsDigit - Character is A Digit
       // Return *on if "char" is a digit (0-9), else return *off.
     d CharIsDigit     pr              n   extproc('CharIsDigit')
     d   char                         1    const

       // ContainsDigitsOnly - Contains Digits Only
       // Return *on if "text" contains digits only, else return *off.
       // If "option" is given with value "*ANDSPACES" then "text" may
       // contain spaces also.
     d ContainsDigitsOnly...
     d                 pr              n   extproc('ContainsDigitsOnly')
     d   text                      1000    const varying
     d   option                      10    const options(*nopass)

       // FmtInt - Format Integer
       // Format "int" using formatting string "fmt".
       // Return "fmt" after replacing spaces and zero's with the
       // significant digits of "int". The spaces (" ") and zero's ("0")
       // in "fmt" are replaced from right to left. The least significant
       // digit replaces the first space or zero from the right. Then the
       // second least significant digit replaces the second space or zero
       // from the right, etc, until all significant digits have been used.
       // Leading zeros in "int" are not used.
       // The last (far right) occurrence in "fmt" of the tilde character
       // ("~") is replaced with a space if "int" is positive, or a minus
       // sign ("-") if "int" is negative. This happens after all digits
       // of "int" have been used. If this tilde has been replaced with a
       // minus sign, and this minus sign occurs before the last replaced
       // space or zero (the most left which has been replaced with the
       // most significant digit) and inbetween are only spaces, then these
       // spaces are removed.
       // If "option" is given with value "*RSPACES" then replace ONLY the
       // spaces in "fmt", NOT the zero's. Alternatively, if "option" is
       // given with value "*RZEROS" then replace ONLY the zeros, NOT the
       // spaces.
       // Examples:
       //   FmtInt(      2:'00')             --> '02'
       //   FmtInt(    123:'00')             --> '23'
       //   FmtInt(2012051:'000000-0')       --> '201205-1'
       //   FmtInt( -12345:'~    0000000')   --> '-0012345'
       //   FmtInt( -12345:'~           ')   --> '-12345'
       //   FmtInt( -12345:'~ XX  XX    ')   --> '- XX 1XX2345'
       //   FmtInt( -12345:'~~~~~0000000')   --> '~~~~-0012345'
       //   FmtInt(  12345:'~~~~~0000000')   --> '~~~~ 0012345'
       //   FmtInt( -12345:'    .00 ~')      --> ' 123.45 -'
       //   FmtInt(  12345:'~   .00 ~')      --> '~123.45  '
       //   FmtInt(  12345:'~A00B 00-0')     --> ' A01B234-5'
       //   FmtInt(      0:'~A00B 00-0')     --> ' A00B 00-0'
     d FmtInt          pr           100    varying extproc('FmtInt')
     d   int                         20i 0 const
     d   fmt                        100    const varying
     d   option                      10    const options(*nopass)

       // SubstText - Substitute Text
       // Return "text" with substitution markers %1..%9 replaced with
       // parameters "subst1".."subst9". If a substitution parameter is
       // *OMITted or not given, the associated substitution marker is
       // not replaced. All occurrences of the same substitution marker
       // are replaced with the same text.
     d SubstText       pr          3000    varying extproc('SubstText')
     d   text                      2000    const varying
     d   subst1                     200    const varying options(*omit:*nopass)
     d   subst2                     200    const varying options(*omit:*nopass)
     d   subst3                     200    const varying options(*omit:*nopass)
     d   subst4                     200    const varying options(*omit:*nopass)
     d   subst5                     200    const varying options(*omit:*nopass)
     d   subst6                     200    const varying options(*omit:*nopass)
     d   subst7                     200    const varying options(*omit:*nopass)
     d   subst8                     200    const varying options(*omit:*nopass)
     d   subst9                     200    const varying options(*omit:*nopass)

       // EnumValues - Enumerate Values
       // Return all the values in the array pointed to by "values", separated
       // with "sep" and a space. Each element is appended to the result in the
       // order as they appear in "values".
       // Array "values" has "enum" elements, with fixed length "elen".
       // By default, each value is appended without trailing blanks (leading
       // blanks are preserved), unless parameter "option" is given with
       // value "*NOTRIMR".
     d EnumValues      pr          2000    varying extproc('EnumValues')
     d   values                        *   const
     d   enum                        10i 0 const
     d   elen                        10i 0 const
     d   sep                          1    const
     d   option                      10    const options(*nopass)

       // CharInText - Character In Text
       // Return *on if "text" contains at least one of the characters in
       // "chars", else return *off.
       // If "option" is given with value '*ALL' then return *on if ALL
       // characters in "chars" are in "text".
     d CharInText      pr              n   extproc('CharInText')
     d   chars                       50    const varying
     d   text                      1000    const varying
     d   option                      10    const         options(*nopass)

       // ConcatText - Concatenate Text
       // Return the result of concatenating "text1" and "text2".
       // If "text1" is empty ('') or "sep" is not given or is empty then
       // "text2" is simply appended to "text1", with the same result as
       // evaluating expression "text1 + text2". However, if "sep" is given
       // and is not empty and "text1" is not empty then the result is the
       // same as evaluating expression "text1 + sep + text2".
     d ConcatText      pr          2000    varying extproc('ConcatText')
     d   text1                     1000    const varying
     d   text2                     1000    const varying
     d   sep                       1000    const varying options(*nopass)

       // RepeatText - Repeat Text
       // Return "text" repeated "num" times.
       // Return '' if "num" is 0 or less.
     d RepeatText      pr          2000    varying extproc('RepeatText')
     d   text                        50    const varying
     d   num                         10i 0 const

       // RepeatCharsInText - Repeat Characters In Text
       // Return "text" with each occurrence of a character that also
       // exists in "chars" (including space!) is repeated "num" times.
       // Simply return "text" if "num" is 1.
       // If "num" is 0 or less, this will result in removing each
       // occurrence of a character in "chars" from "text".
     d RepeatCharsInText...
     d                 pr          2000    varying extproc('RepeatCharsInText')
     d   text                      1000    const varying
     d   chars                       50    const varying
     d   num                         10i 0 const

       // OrdinalNumText - Ordinal Number Text
       // Return the text for ordinal number "onum", like "1st", "2nd", etc.
       // Return '' if "onum" is less than 1.
     d OrdinalNumText  pr            15    varying extproc('OrdinalNumText')
     d   onum                        10i 0 const

       // PluralNoun - Plural Noun
       // Return the plural form of "noun" for "num".
     d PluralNoun      pr           100    varying extproc('PluralNoun')
     d   noun                       100    const varying
     d   num                         10i 0 const

       // XMLCharData - XML Character Data
       // Convert "text" into "xmltext" such that "xmltext" can be used as
       // XML character data by escaping characters as necessary.
     d XMLCharData     pr                  extproc('XMLCharData')
     d   text                     16383c   varying ccsid(13488)
     d   xmltext                  16383c   varying ccsid(13488)

       // XMLCharData_S - XML Character Data (Single-byte)
       // Convert "text" into "xmltext" such that "xmltext" can be used as
       // XML character data by escaping characters as necessary.
     d XMLCharData_S   pr                  extproc('XMLCharData_S')
     d   text                     32767    varying
     d   xmltext                  32767    varying

