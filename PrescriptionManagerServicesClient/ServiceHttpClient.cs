using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace PrescriptionManagerServicesClient
{
    public class ServiceHttpClient
    {
        //private const string AppId = "<app-id>";
        //private const string SubscriptionKey = "<key>";

        private static readonly HttpClient Client;

        #region Fields

        private readonly string _baseUri;

        #endregion

        static ServiceHttpClient()
        {
            Client = new HttpClient();
            //Client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", SubscriptionKey);
        }

        public ServiceHttpClient(string baseUri)
        {
            _baseUri = baseUri;
        }

        public async Task<TModel> Delete<TModel>(string relativePath, int id) where TModel : class
        {
            try
            {
                var request = BuildDeleteRequest($"{_baseUri}/{relativePath}/{id}");
                var result = await GetStringResult(request);
                return JsonConvert.DeserializeObject<TModel>(result);
            }
            catch
            {
                return null;
            }
        }

        public async Task<TModel> Get<TModel>(string relativePath) where TModel : class
        {
            try
            {
                var request = BuildGetRequest($"{_baseUri}/{relativePath}");
                var result = await GetStringResult(request);
                var data = JsonConvert.DeserializeObject<TModel>(result);
                return data;
            }
            catch
            {
                return null;
            }
        }

        public async Task<TModel> GetById<TModel>(string relativePath, int id) where TModel : class
        {
            try
            {
                var request = BuildGetRequest($"{_baseUri}/{relativePath}/{id}");
                var result = await GetStringResult(request);
                return JsonConvert.DeserializeObject<TModel>(result);
            }
            catch
            {
                return null;
            }
        }

        public async Task<TModel> Post<TModel>(string relativePath, TModel model) where TModel : class
        {
            var serializeObject = JsonConvert.SerializeObject(model);
            var request = BuildPostRequest($"{_baseUri}/{relativePath}", serializeObject);
            var result = await GetStringResult(request);
            try
            {
                var response = JsonConvert.DeserializeObject<TModel>(result);
                return response;
            }
            catch
            {
                return null;
            }
        }

        public async Task Put<TModel>(string relativePath, TModel model, int id) where TModel : class
        {
            var serializeObject = JsonConvert.SerializeObject(model);
            var request = BuildPutRequest($"{_baseUri}/{relativePath}/{id}", serializeObject);
            request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var responseMessage = await Client.SendAsync(request);
            responseMessage.EnsureSuccessStatusCode();
        }

        private HttpRequestMessage BuildDeleteRequest(string url)
        {
            var request = new HttpRequestMessage
            {
                RequestUri = new Uri(url),
                Method = HttpMethod.Delete
            };
            request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            return request;
        }

        private HttpRequestMessage BuildGetRequest(string url)
        {
            var request = new HttpRequestMessage
            {
                RequestUri = new Uri(url),
                Method = HttpMethod.Get
            };
            request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            return request;
        }

        private HttpRequestMessage BuildPostRequest(string url, string content)
        {
            var request = BuildGetRequest(url);
            request.Method = HttpMethod.Post;
            request.Content = new StringContent(content, Encoding.UTF8, "application/json");
            request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            return request;
        }

        private HttpRequestMessage BuildPutRequest(string url, string content)
        {
            var request = BuildGetRequest(url);
            request.Method = HttpMethod.Put;
            request.Content = new StringContent(content, Encoding.UTF8, "application/json");
            request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            return request;
        }

        private static async Task<string> GetStringResult(HttpRequestMessage request)
        {
            var responseMessage = await Client.SendAsync(request);
            responseMessage.EnsureSuccessStatusCode();
            return await responseMessage.Content.ReadAsStringAsync();
        }
    }
}