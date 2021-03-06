
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


      /IF DEFINED(CSYSBASE_INCL_XD)
      /EOF
      /ENDIF
      /DEFINE CSYSBASE_INCL_XD


       // INCLUDE: *SRVPGM CSYSBASE

       // Module XD: XML Document


       // Create an XML document.

       // The structure of an XML document is represented with one instance
       // of data structure XML$ROOT and zero or more (nested) instances of
       // XML$ELEM.

       // Character data (content and attributes) contained in the root and
       // the elements is represented with instances of data structure XML$DATA.

       // The character data contained in instances of XML$DATA need not to
       // be escaped. This is done when the XML document is converted to text
       // with procedure "XML_AsText".

       // The first subfields of XML$ROOT and XML$ELEM are the same, so that
       // these subfields can be accessed without first querying the type of
       // the data structure.

       // Internally, XML character data is encoded in UCS-2 (CCSID 13488).
       // When the document is actually produced with "XML_AsText" the data is
       // converted to the encoding as specified with parameter "encoding".

       // Header spec CCSID(*UCS2:13488) is used in this module to explicitly
       // specify the default CCSID for all UCS-2 (c) character fields to be
       // UCS-2 (which is not really necessary as 13488 is the default).


       // The basing pointers XML$ROOT@, XML$ELEM@ and XML$DATA@ are never
       // affected by calling procedures in this module.


      /include CSYSBASES,INCL_DEFS


       // ----- Constants

       // Number of elements in array "elems" in procedure "XML_AddE2".
     dCNumElemsAddE2   c                   70


       // ----- Data Structures

       // An instance of XML$ROOT represents the root of an XML document.
     d XML$ROOT        ds                  qualified based(XML$ROOT@)
         // Type. Is always set to 0 to identify a "root".
         // DO NOT CHANGE.
     d   t                           10i 0
         // Tag name.
     d   tname                       50c   varying
         // Pointer to an instance of XML$DATA with application specific
         // data (content & attributes) for the root.
         // Is *null if the root has no content and no attributes.
     d   data                          *
         // Pointer to the first element (XML$ELEM) in the root.
         // Is *null if the root has no elements.
     d   first                         *
         // Standalone indication (is always set to *on for now).
     d   standalone                    n

       // An instance of XML$ELEM represents an element within an instance
       // of XML$ROOT or a nested element within another XML$ELEM.
     d XML$ELEM        ds                  qualified based(XML$ELEM@)
         // Type. Is always set to 1 to identify an "element".
         // DO NOT CHANGE.
     d   t                           10i 0
         // Tag name.
     d   tname                       50c   varying
         // Pointer to an instance of XML$DATA with application specific
         // data (content & attributes) for this element.
         // Is *null if this element has no content and no attributes.
     d   data                          *
         // Pointer to the first nested element (XML$ELEM) in this element.
         // Is *null if this element has no nested elements.
     d   first                         *
         // Pointer to the next (child) element in the root (XML$ROOT) or
         // (parent) element.
         // Is *null if this element is the last one.
     d   next                          *

       // An instance of XML$DATA contains character data for an element.
     d XML$DATA        ds                  qualified based(XML$DATA@)
         // Pointer to application specific data.
         // If *null, there is no application specific data.
     d   appdata                       *
         // Pointer to the delegate procedure (prototype "XML_DP_AppData")
         // that is called just before pointer "appdata" is deallocated.
         // This procedure is then able to deallocate pointers contained
         // within the application specific data, before the application
         // specific data itself is deallocated.
         // If *null, there is no such procedure to call (i.e. there are
         // no pointers contained in the application specific data).
     d   dp_reladata                   *   procptr
         // Pointer to the delegate procedure (prototype "XML_DP_ProdAttrs")
         // that is called to produce attribute names and values.
         // If *null, there is no such procedure and no attributes will be
         // produced.
     d   dp_prodattrs                  *   procptr
         // Pointer to the delegate procedure (prototype "XML_DP_ProdContent")
         // that is called to produce the text between the start and end tags
         // of an element.
         // If *null, there is no such procedure and no content will be
         // produced.
     d   dp_prodcont                   *   procptr


       // ----- Prototypes for Delegates

       // Prototypes beginning with XML_DP_ are for delegate procedures.
       // These are to be used as templates for the actual prototypes.

       // XML_DP_AppData - AppData
       // Prototype for delegates with just one parameter, "appdata", and
       // no return type.
       // Parameter "appdata" is a pointer to application specific data.
       // It is the value of subfield "appdata" in an instance of XML$DATA.
     d XML_DP_AppData...
     d                 pr
     d   appdata                       *   const

       // XML_DP_ProdAttrs - Produce Attributes
       // Prototype for delegates to produce the attributes of the root or
       // an element.
       // Return the text for the name and value of the attribute with ordinal
       // "num". If parameter "name" is *on then return the attribute's name,
       // else return the attribute's value. Return '' when "name" is *on to
       // stop querying the attributes.
       // For the root and each element, this procedure is first called with
       // "num" 1 and "name" *on, then "num" 1 and "name" *off, then "num" 2
       // and "name" *on, etc.
       // If no attributes should be produced then return '' immediately when
       // called with "num" 1 and "name" *on.
       // Parameter "appdata" is a pointer to application specific data.
       // It is the value of subfield "appdata" in an instance of XML$DATA.
       // The returned text is escaped before it's used as XML character data.
     d XML_DP_ProdAttrs...
     d                 pr         16383c   varying
     d   appdata                       *   const
     d   num                         10i 0 const
     d   name                          n   const

       // XML_DP_ProdContent - Produce Content
       // Prototype for delegates to produce the content of the root or
       // an element.
       // Return the text for the root or an element's content.
       // Parameter "appdata" is a pointer to application specific data.
       // It is the value of subfield "appdata" in an instance of XML$DATA.
       // The returned text is escaped before it's used as XML character data.
     d XML_DP_ProdContent...
     d                 pr         16383c   varying
     d   appdata                       *   const

       // XML_DP_VisitNode - Visit Node
       // Delegate prototype for the procedure that is called each time
       // a node is visited.
       // Parameter "cnl" is the current nesting level of "node".
       // See procedure "XML_Iter".
     d XML_DP_VisitNode...
     d                 pr              n
     d   node                          *   const
     d   cnl                         10i 0 const
     d   ddata                    32767          options(*varsize:*nopass)


       // ----- Prototypes

       // XML_R - Root
       // Return a pointer to a new instance of XML$ROOT, representing
       // an XML document (with no elements yet).
     d XML_R           pr              *   extproc('XML_R')
     d   tname                       50c   const varying
     d   data                          *   const options(*nopass)

       // XML_E - Element
       // Return a pointer to a new instance of XML$ELEM, representing
       // an element.
     d XML_E           pr              *   extproc('XML_E')
     d   tname                       50c   const varying
     d   data                          *   const options(*nopass)

       // XML_EC - Element with Content
       // Return a pointer to a new instance of XML$ELEM with a new
       // instance of XML$DATA which produces "content" and/or attribute
       // names and values "attrn0".."attrn9" and "attrv0".."attrv9".
     d XML_EC          pr              *   extproc('XML_EC')
     d   tname                       50c   const varying
     d   content                  16383c   const varying options(*omit:*nopass)
     d   attrn0                      50c   const varying options(*omit:*nopass)
     d   attrv0                     100c   const varying options(*omit:*nopass)
     d   attrn1                      50c   const varying options(*omit:*nopass)
     d   attrv1                     100c   const varying options(*omit:*nopass)
     d   attrn2                      50c   const varying options(*omit:*nopass)
     d   attrv2                     100c   const varying options(*omit:*nopass)
     d   attrn3                      50c   const varying options(*omit:*nopass)
     d   attrv3                     100c   const varying options(*omit:*nopass)
     d   attrn4                      50c   const varying options(*omit:*nopass)
     d   attrv4                     100c   const varying options(*omit:*nopass)
     d   attrn5                      50c   const varying options(*omit:*nopass)
     d   attrv5                     100c   const varying options(*omit:*nopass)
     d   attrn6                      50c   const varying options(*omit:*nopass)
     d   attrv6                     100c   const varying options(*omit:*nopass)
     d   attrn7                      50c   const varying options(*omit:*nopass)
     d   attrv7                     100c   const varying options(*omit:*nopass)
     d   attrn8                      50c   const varying options(*omit:*nopass)
     d   attrv8                     100c   const varying options(*omit:*nopass)
     d   attrn9                      50c   const varying options(*omit:*nopass)
     d   attrv9                     100c   const varying options(*omit:*nopass)

       // XML_D - Data
       // Return a pointer to a new instance of XML$DATA.
     d XML_D           pr              *   extproc('XML_D')
     d   appdata                       *   const         options(*omit:*nopass)
     d   dp_prodcont                   *   const procptr options(*omit:*nopass)
     d   dp_prodattrs                  *   const procptr options(*omit:*nopass)
     d   dp_reladata                   *   const procptr options(*omit:*nopass)

       // XML_C - Content
       // Return a pointer to a new instance of XML$DATA which produces
       // "content" and/or attribute names and values "attrn0".."attrn9"
       // and "attrv0".."attrv9".
     d XML_C           pr              *   extproc('XML_C')
     d   content                  16383c   const varying options(*omit:*nopass)
     d   attrn0                      50c   const varying options(*omit:*nopass)
     d   attrv0                     100c   const varying options(*omit:*nopass)
     d   attrn1                      50c   const varying options(*omit:*nopass)
     d   attrv1                     100c   const varying options(*omit:*nopass)
     d   attrn2                      50c   const varying options(*omit:*nopass)
     d   attrv2                     100c   const varying options(*omit:*nopass)
     d   attrn3                      50c   const varying options(*omit:*nopass)
     d   attrv3                     100c   const varying options(*omit:*nopass)
     d   attrn4                      50c   const varying options(*omit:*nopass)
     d   attrv4                     100c   const varying options(*omit:*nopass)
     d   attrn5                      50c   const varying options(*omit:*nopass)
     d   attrv5                     100c   const varying options(*omit:*nopass)
     d   attrn6                      50c   const varying options(*omit:*nopass)
     d   attrv6                     100c   const varying options(*omit:*nopass)
     d   attrn7                      50c   const varying options(*omit:*nopass)
     d   attrv7                     100c   const varying options(*omit:*nopass)
     d   attrn8                      50c   const varying options(*omit:*nopass)
     d   attrv8                     100c   const varying options(*omit:*nopass)
     d   attrn9                      50c   const varying options(*omit:*nopass)
     d   attrv9                     100c   const varying options(*omit:*nopass)

       // XML_AddE  - Add Element(s)
       // Add elements "elem01".."elem70" as children to "node", and return
       // "node".
       // Parameter "node" points to an instance of XML$ROOT or XML$ELEM.
       // If an "elem*" parameter is *null it is simply ignored.
     d XML_AddE        pr              *   extproc('XML_AddE')
     d   node                          *   const
     d   elem01                        *   const options(*nopass)
     d   elem02                        *   const options(*nopass)
     d   elem03                        *   const options(*nopass)
     d   elem04                        *   const options(*nopass)
     d   elem05                        *   const options(*nopass)
     d   elem06                        *   const options(*nopass)
     d   elem07                        *   const options(*nopass)
     d   elem08                        *   const options(*nopass)
     d   elem09                        *   const options(*nopass)
     d   elem10                        *   const options(*nopass)
     d   elem11                        *   const options(*nopass)
     d   elem12                        *   const options(*nopass)
     d   elem13                        *   const options(*nopass)
     d   elem14                        *   const options(*nopass)
     d   elem15                        *   const options(*nopass)
     d   elem16                        *   const options(*nopass)
     d   elem17                        *   const options(*nopass)
     d   elem18                        *   const options(*nopass)
     d   elem19                        *   const options(*nopass)
     d   elem20                        *   const options(*nopass)
     d   elem21                        *   const options(*nopass)
     d   elem22                        *   const options(*nopass)
     d   elem23                        *   const options(*nopass)
     d   elem24                        *   const options(*nopass)
     d   elem25                        *   const options(*nopass)
     d   elem26                        *   const options(*nopass)
     d   elem27                        *   const options(*nopass)
     d   elem28                        *   const options(*nopass)
     d   elem29                        *   const options(*nopass)
     d   elem30                        *   const options(*nopass)
     d   elem31                        *   const options(*nopass)
     d   elem32                        *   const options(*nopass)
     d   elem33                        *   const options(*nopass)
     d   elem34                        *   const options(*nopass)
     d   elem35                        *   const options(*nopass)
     d   elem36                        *   const options(*nopass)
     d   elem37                        *   const options(*nopass)
     d   elem38                        *   const options(*nopass)
     d   elem39                        *   const options(*nopass)
     d   elem40                        *   const options(*nopass)
     d   elem41                        *   const options(*nopass)
     d   elem42                        *   const options(*nopass)
     d   elem43                        *   const options(*nopass)
     d   elem44                        *   const options(*nopass)
     d   elem45                        *   const options(*nopass)
     d   elem46                        *   const options(*nopass)
     d   elem47                        *   const options(*nopass)
     d   elem48                        *   const options(*nopass)
     d   elem49                        *   const options(*nopass)
     d   elem50                        *   const options(*nopass)
     d   elem51                        *   const options(*nopass)
     d   elem52                        *   const options(*nopass)
     d   elem53                        *   const options(*nopass)
     d   elem54                        *   const options(*nopass)
     d   elem55                        *   const options(*nopass)
     d   elem56                        *   const options(*nopass)
     d   elem57                        *   const options(*nopass)
     d   elem58                        *   const options(*nopass)
     d   elem59                        *   const options(*nopass)
     d   elem60                        *   const options(*nopass)
     d   elem61                        *   const options(*nopass)
     d   elem62                        *   const options(*nopass)
     d   elem63                        *   const options(*nopass)
     d   elem64                        *   const options(*nopass)
     d   elem65                        *   const options(*nopass)
     d   elem66                        *   const options(*nopass)
     d   elem67                        *   const options(*nopass)
     d   elem68                        *   const options(*nopass)
     d   elem69                        *   const options(*nopass)
     d   elem70                        *   const options(*nopass)

       // XML_AddE  - Add Element(s) (2)
       // Like "XML_AddE", but with an array.
     d XML_AddE2       pr              *   extproc('XML_AddE2')
     d   node                          *   const
     d   elems                         *   const dim(CNumElemsAddE2)

       // XML_Release - Release
       // Release (deallocate) all memory that is occupied by "node" and all
       // (nested) elements it contains.
       // Parameter "node" must be the root (XML$ROOT) or an element
       // (XML$ELEM).
     d XML_Release     pr                  extproc('XML_Release')
     d   node                          *   const

       // XML_Iter - Iterate
       // Iterate over "node" and all (nested) elements contained within.
       // Parameter "node" must be the root (XML$ROOT) or an element (XML$ELEM).
       // The nodes are visited in breadth-first order if "option" is "*BREADTH"
       // or depth-first order if "option" is "*DEPTH". If "option" is none of
       // these then nothing happens and the procedure simply returns with *on.
       // Call delegate procedure "dp_visit" for each visited node (the root
       // or an element) with a pointer to the visited "node" as the first
       // argument argument and parameter "ddata" as the second parameter. The
       // prototype used to call these procedures is like "XML_DP_VisitNode",
       // defined in this member.
       // Iterating over "node" and it's children continues as long as
       // "dp_visit" returns *on. If it returns *off, the iteration is immedi-
       // ately stopped and this procedure returns *off. If there are no more
       // nodes to visit then this procedure returns *on.
       // Parameter "ddata" as passed around as-is (if given) and is a mecha-
       // nism to pass data to/from the delegate procedure.
       // The "current nesting level" is the number of (grand)parent nodes that
       // are above the node that is currently visited. Parameter "snl" is the
       // start nesting level, i.e. the nesting level of "node". If not given
       // it defaults to 0. So if "snl" is not given then "node" is at nesting
       // 0 and the elements directly below it are at level 1.
       // Parameter "mnl" is the maximum nesting level, which determines how
       // deep the hierarchy is traversed. If not given then there is no limit.
       // The current nesting level never exceeds "mnl". If "mnl" is equal to
       // "snl" then only "node" is visited.
       // Do nothing and return *on if "mnl" is less than "snl".
     d XML_Iter        pr              n   extproc('XML_Iter')
     d   node                          *   const
     d   dp_visit                      *   const procptr
     d   option                      10    const
     d   ddata                    32767                  options(*varsize
     d                                                          :*nopass:*omit)
     d   snl                         10i 0 const         options(*nopass:*omit)
     d   mnl                         10i 0 const         options(*nopass:*omit)

       // XML_IsRoot - Is Root?
       // Return *on if the data structure to which "node" points is an
       // instance of XML$ROOT, else return *off.
       // Parameter "node" must point to either a instance of XML$ROOT
       // or XML$ELEM.
     d XML_IsRoot      pr              n   extproc('XML_IsRoot')
     d   node                          *   const

       // XML_AsText - as Text
       // Return "node" as a text document, represented with a dynamically
       // allocated array of pointers to C-style (null terminated) strings
       // which - when concatenated together separated with LF's - form the
       // document.
       // Return a pointer that points to an array of pointers to strings.
       // If "node" is the root (instance of XML$ROOT) then the first line
       // that is produced is the XML declaration.
       // The strings in the returned array are encoded according to "encoding"
       // which must have one of the following values (in uppercase): "UTF-8",
       // "UTF-16", "ISO-8859-1" or "Windows-1252". It defaults to "UTF-16".
       // Parameter "lines" - if given - contains the number of lines (strings
       // or elements) in the array.
       // Optional parameter "indent" is prefixed n-times to each line, where
       // "n" is the nesting level. Node "node" is at nesting level 0. If not
       // given it defaults to ''.
       // Return *null in case of an error.
     d XML_AsText      pr              *   extproc('XML_AsText')
     d   node                          *   const
     d   encoding                    20    const
     d   lines                       10i 0       options(*nopass:*omit)
     d   indent                      20    const varying
     d                                           options(*nopass:*omit)

