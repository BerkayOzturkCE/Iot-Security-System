using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Google.Cloud.Firestore;

namespace apideneme
{
    [FirestoreData]
    public class Carts
    {
        [FirestoreProperty]
        public String id { get; set; }
        [FirestoreProperty]
        public String name { get; set; }


    }
}
