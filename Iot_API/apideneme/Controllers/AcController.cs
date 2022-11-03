using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace apideneme.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ac : ControllerBase
    {
        firebaseConn firebase = new firebaseConn();

        // GET: api/<AcController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public Action Get(String id)
        {
            Action action = new Action();
            List<Action> liste = new List<Action>();
          //  string[] veriler = id.Split('&');
                firebase.client = new FireSharp.FirebaseClient(firebase.config);
                firebase.response = firebase.client.Get("Users/" + id + "/Actions/");
            action = firebase.response.ResultAs<Action>();
            liste.Add(action);
                return action;

            
        }

            // POST api/<AcController>
            [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<AcController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<AcController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
