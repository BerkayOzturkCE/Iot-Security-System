using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FireSharp.Config;
using FireSharp.Interfaces;
using FireSharp.Response;

namespace apideneme
{
    public class firebaseConn
    {
        public IFirebaseConfig config = new FirebaseConfig()
        {
            AuthSecret = "Rx2o9Md7s6eosbLuFV3fw0MD9AP4WOryhB7YDUcH",
            BasePath= "https://bmut-3cc15-default-rtdb.firebaseio.com/",
            
        };
        public IFirebaseClient client;
        public FirebaseResponse response;    
    }
}
