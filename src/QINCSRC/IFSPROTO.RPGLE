
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // IFS prototypes


       // Data structure to specify a NLS-enabled path.
     d IFS_DS_NLSPath  ds                  qualified inz
     d   ccsid                       10i 0
     d   cty_reg_id                   2    inz(*allx'00')
     d   lang_id                      3    inz(*allx'00')
     d   reserved01                   3    inz(*allx'00')
     d   path_type                   10i 0
     d   path_length                 10i 0
     d   path_delim                   2    inz('/')
     d   reserved02                  10    inz(*allx'00')
     d   path                       200

       // Data structure to contain file status information.
     d IFS_DS_Stat     ds                  qualified inz
     d   mode                        10u 0
     d   ino                         10u 0
     d   nlink                        5u 0
     d   reserved2                    5u 0
     d   uid                         10u 0
     d   gid                         10u 0
     d   size                        10i 0
     d   atime                       10i 0
     d   mtime                       10i 0
     d   ctime                       10i 0
     d   dev                         10u 0
     d   blksize                     10u 0
     d   allocsize                   10u 0
     d   objtype                     11
     d   reserved3                    1
     d   codepage                     5u 0
     d   ccsid                        5u 0
     d   rdev                        10u 0
     d   nlink32                     10u 0
     d   rdev64                      20u 0
     d   dev64                       20u 0
     d   reserved1                   36
     d   ino_gen_id                  10u 0

     d IFS_Access      pr            10i 0 extproc('access')
     d   path                          *   value options(*string)
     d   mode                        10i 0 value

     d IFS_Close       pr            10i 0 extproc('close')
     d   fd                          10i 0 value

     d IFS_Chdir       pr            10i 0 extproc('chdir')
     d   path                          *   value options(*string)

     d IFS_Open        pr            10i 0 extproc('open')
     d   path                          *   value options(*string)
     d   oflag                       10i 0 value
     d   mode                        10u 0 value options(*nopass)
     d   codepage                    10u 0 value options(*nopass)

     d IFS_Read        pr            10i 0 extproc('read')
     d   fd                          10i 0 value
     d   buf                           *   value
     d   nbyte                       10u 0 value

       // "newpath" can not be an existing path.
     d IFS_Rename      pr            10i 0 extproc('Qp0lRenameKeep')
     d   oldpath                       *   value options(*string)
     d   newpath                       *   value options(*string)

     d IFS_SetAttr     pr            10i 0 extproc('Qp0lSetAttr')
     d   pathds                        *   value
     d   attrbuf                       *   value
     d   attrbufsz                   10u 0 value
     d   follow_syml                 10u 0 value

     d IFS_Stat        pr            10i 0 extproc('stat')
     d   path                          *   value options(*string)
     d   sbuf                              likeds(IFS_DS_Stat)

     d IFS_Unlink      pr            10i 0 extproc('unlink')
     d   path                          *   value options(*string)

     d IFS_Write       pr            10i 0 extproc('write')
     d   fd                          10i 0 value
     d   buf                           *   value
     d   nbyte                       10u 0 value

