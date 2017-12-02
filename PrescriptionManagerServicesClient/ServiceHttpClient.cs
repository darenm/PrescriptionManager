using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

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

        public async Task<TModel> Get<TModel>(string relativePath) where TModel : class
        {
            try
            {
                var request = BuildGetRequest($"{_baseUri}/{relativePath}");
                var result = await GetStringResult(request);
                var data = JsonConvert.DeserializeObject<TModel>(result, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                return data;
            }
            catch
            {
                return null;
            }
        }



        /// <summary>
        ///     Builds the get request.
        /// </summary>
        /// <param name="url">The URL.</param>
        /// <returns>HttpRequestMessage.</returns>
        private HttpRequestMessage BuildGetRequest(string url)
        {
            var request = new HttpRequestMessage
            {
                RequestUri = new Uri(url),
                Method = HttpMethod.Get
            };
            //request.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            return request;
        }

        /// <summary>
        ///     Builds the post request.
        /// </summary>
        /// <param name="url">The URL.</param>
        /// <param name="content">The content.</param>
        /// <returns>HttpRequestMessage.</returns>
        private HttpRequestMessage BuildPostRequest(string url, string content)
        {
            var request = BuildGetRequest(url);
            request.Method = HttpMethod.Post;
            request.Content = new StringContent(content, Encoding.UTF8, "application/json");
            return request;
        }

        /// <summary>
        /// Gets the string result.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <returns>Task&lt;System.String&gt;.</returns>
        private static async Task<string> GetStringResult(HttpRequestMessage request)
        {
            var responseMessage = await Client.SendAsync(request);
            responseMessage.EnsureSuccessStatusCode();
            return await responseMessage.Content.ReadAsStringAsync();
        }

    }
}