
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // Include: prototype for program CAFNWD

       // Pass 0-10 parameters.


     d PgmCAFNWD       pr                  extpgm('CAFNWD')
     d   @@Mode                      10    const options(*nopass)
     d   @@Spcbhvr                   10    const options(*nopass)
     d   @@Rtncd                      2  0       options(*nopass)
     d   @@Rtnmsg1                  100          options(*nopass)
     d   @@Rtnmsg2                  100          options(*nopass)
     d   @@SelYear                    4  0       options(*nopass)
     d   @@SelMonth                   2  0       options(*nopass)
     d   @@SelDay                     2  0       options(*nopass)
     d   @@SelWeek                    2  0       options(*nopass)
     d   @@SelDNum                    1  0       options(*nopass)

