
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // IFS constants


       // Flags for use in open()
       //
       // Reading Only
     d O_RDONLY        c                   1
       // Writing Only
     d O_WRONLY        c                   2
       // Reading & Writing
     d O_RDWR          c                   4
       // Create File if not exist
     d O_CREAT         c                   8
       // Exclusively create
     d O_EXCL          c                   16
       // Truncate File to 0 bytes
     d O_TRUNC         c                   64
       // Append to File
     d O_APPEND        c                   256
       // Convert text by code-page
     d O_CODEPAGE      c                   8388608
       // Open in text-mode
     d O_TEXTDATA      c                   16777216


       // Mode Flags.
       //   basically, the mode parm of open(), creat(), chmod(),etc
       //   uses 9 least significant bits to determine the
       //   file's mode. (peoples access rights to the file)
       //
       //     user:       owner    group    other
       //     access:     R W X    R W X    R W X
       //     bit:        8 7 6    5 4 3    2 1 0
       //
       // (This is accomplished by adding the flags below to get the mode)

       // Owner authority
     d S_IRUSR         c                   256
     d S_IWUSR         c                   128
     d S_IXUSR         c                   64
     d S_IRWXU         c                   448
       // Group authority
     d S_IRGRP         c                   32
     d S_IWGRP         c                   16
     d S_IXGRP         c                   8
     d S_IRWXG         c                   56
       // Other
     d S_IROTH         c                   4
     d S_IWOTH         c                   2
     d S_IXOTH         c                   1
     d S_IRWXO         c                   7


       // Access mode flags for access()
       //
       //   F_OK = File Exists
       //   R_OK = Read Access
       //   W_OK = Write Access
       //   X_OK = Execute or Search
     d F_OK            c                   0
     d R_OK            c                   4
     d W_OK            c                   2
     d X_OK            c                   1


       // Object attribute id's
     d OBJATTR_CCSID   c                   27

