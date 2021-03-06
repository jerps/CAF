
       // (c) 2019 John Erps
       // This software is licensed under the MIT license (see LICENSE)


       // TO BE INCLUDED IN CAPPSS* SERVICE PROGRAMS, module DC.


       // Check if any errors (i.e. fatal messages) were added.
       // If so, set return code "rc" to the preferred return code
       // "prc" or, if "prc" is 0, to -30 and return.
       // An error is any message with character "F" at position 3.
       begsr return_on_error;

         // Retrieve current message count.
         mc = GetDspMsgListCount();
         if mc <= imc;
           // No messages were added.
           leavesr;
         endif;

         for i = imc + 1 to mc;
           if IsAMsgFatal(DspMsgList(i));
             // FATAL MESSAGE: RETURN
             if prc = 0;
               rc = -30;
             else;
               rc = prc;
             endif;
             exsr exit;
           endif;
         endfor;

       endsr;

