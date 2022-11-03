using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Google.Cloud.Firestore;

namespace apideneme.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        firebaseConn firebase = new firebaseConn();
        // GET api/values
        [HttpGet]
        public Carts Get()
        {
            firebase.client = new FireSharp.FirebaseClient(firebase.config);
            firebase.response = firebase.client.Get("Carts1");
            Carts action = firebase.response.ResultAs<Carts>();
            return action;
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public async Task<Carts> GetAsync(String id)
        {
            Carts carts = new Carts();
            string[] veriler = id.Split('&');

            string path = AppDomain.CurrentDomain.BaseDirectory + @"bmut-3cc15.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
            FirestoreDb db = FirestoreDb.Create("bmut-3cc15");

            if (veriler[0] == "0")
            {

                DocumentReference coll = db.Collection("Users").Document(veriler[1]).Collection("Carts").Document(veriler[2]);
                DocumentSnapshot snapshot = await coll.GetSnapshotAsync();
                if (snapshot.Exists)
                {
                    carts = snapshot.ConvertTo<Carts>();
                }
                else { carts.id = "0";
                    carts.name = null;
                }
                
            }
            else if (veriler[0] == "1")
            {
              

                CollectionReference coll = db.Collection("Users").Document(veriler[1]).Collection("Actions");
                Dictionary<string, object> data1 = new Dictionary<string, object>()
                { 
                    {"cartId",veriler[2]},
                    {"durum",veriler[3]},
                    {"tarih",Timestamp.FromDateTime(DateTime.UtcNow)}

                };
                coll.AddAsync(data1);


            }
            else if (veriler[0] == "2")
            {
                CollectionReference coll = db.Collection("Users").Document(veriler[1]).Collection("Carts");
                Dictionary<string, object> data1 = new Dictionary<string, object>()
                {
                    {"id",veriler[2]},
                    {"name",veriler[2]},

                };
                coll.Document(veriler[2]).CreateAsync(data1);
            }

                return carts;


        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody] Action action)
        {
            firebase.client = new FireSharp.FirebaseClient(firebase.config);
            action.tarih = DateTime.Now.ToString();
            firebase.response = firebase.client.Set("Actions/"+action.cartId, action);
        }
        

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
