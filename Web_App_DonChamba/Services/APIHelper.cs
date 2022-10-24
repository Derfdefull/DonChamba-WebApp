using Newtonsoft.Json;
using NPOI.SS.Formula.Functions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Web_App_DonChamba.Models;
using WebAPIDonChamba.Models;

namespace Web_App_DonChamba.Services
{
    public class APIHelper
    {
        protected readonly string API_SERVER_URL = "http://localhost:44386/";
        protected HttpClient client;

        public APIHelper()
        {
            this.client = new HttpClient();
        }
        public async Task<bool> AuthUserAsync(object userData)
        {
            try
            {
                Uri request = new Uri(String.Format("{0}api/Usuarios/Auth", API_SERVER_URL));

                var body = new StringContent(JsonConvert.SerializeObject((Auth)userData), Encoding.UTF8, "application/json");
                   
                var response = await client.PostAsync(request, body);
                    
                if (response.StatusCode != System.Net.HttpStatusCode.Created)
                    return false;
                        
                var content = await response.Content.ReadAsStringAsync();
   
                Auth.user = JsonConvert.DeserializeObject<Usuario>(content);
                        
                request = new Uri(String.Format("{0}api/Sucursales/{1}",
                            API_SERVER_URL, Auth.user.FkIdSucursal));    

                        
                response = await client.GetAsync(request);   

                if (response.StatusCode != System.Net.HttpStatusCode.OK)    
                    return false;
        
                Auth.sucursal = JsonConvert.DeserializeObject<Sucursal>(         
                    await response.Content.ReadAsStringAsync());

                Auth.Logged = true;

                return true;
  
                }
                catch (Exception ex) {
                
                var message = ex.Message;
                return false;  }
            }
        
        

        public List<T> getAsync<T>(string schema) where T : new()
        {
            try
            { 
                Uri request = new Uri(String.Format("{0}api/{1}", API_SERVER_URL, schema));
                 
                Task<HttpResponseMessage> response = client.GetAsync(request);

                if (response.Result.StatusCode != System.Net.HttpStatusCode.OK)
                    return null;

                Task<string> content = response.Result.Content.ReadAsStringAsync(); 

                return JsonConvert.DeserializeObject<List<T>>(content.Result);

            }
            catch (Exception ex)
            {  
                return null;
            }
        }

        public bool deleteAsync(string schema, string id)
        {
            try
            {
                Uri request = new Uri(String.Format("{0}api/{1}/{2}", API_SERVER_URL, schema, id));

                Task<HttpResponseMessage> response = client.DeleteAsync(request);

                if (response.Result.StatusCode != System.Net.HttpStatusCode.OK)
                    return false;
                 
                return true;

            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool saveAsync(string schema, object obj)
        {
            try
            {
                Uri request = new Uri(String.Format("{0}api/{1}", API_SERVER_URL, schema));
                var body = new StringContent(JsonConvert.SerializeObject(obj),
                    Encoding.UTF8, "application/json");

                Task<HttpResponseMessage> response = client.PostAsync(request,body);

                if (response.Result.StatusCode != System.Net.HttpStatusCode.Created)
                    return false;

                return true;

            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool editAsync(string schema, object obj, string id)
        {
            try
            {
                Uri request = new Uri(String.Format("{0}api/{1}/{2}", 
                    API_SERVER_URL, schema, id));

                var body = new StringContent(JsonConvert.SerializeObject(obj),
                    Encoding.UTF8, "application/json");

                Task<HttpResponseMessage> response = client.PutAsync(request, body);

                if (response.Result.StatusCode != System.Net.HttpStatusCode.OK)
                    return false;

                return true; 

            }
            catch (Exception ex)
            {
                return false;
            }
        }
 

    }

    }

 