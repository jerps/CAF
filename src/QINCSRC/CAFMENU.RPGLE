
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Include: prototype for program CAFMENU

       // Pass 0-5 parameters.


     d PgmCAFMENU      pr                  extpgm('CAFMENU')
     d   @@Mode                      10    const options(*nopass)
     d   @@Spcbhvr                   10    const options(*nopass)
     d   @@Rtncd                      2  0       options(*nopass)
     d   @@Rtnmsg1                  100          options(*nopass)
     d   @@Rtnmsg2                  100          options(*nopass)

