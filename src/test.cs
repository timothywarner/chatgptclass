using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

class Program
{
  private static readonly HttpClient client = new HttpClient();

  

  static async Task Main(string[] args)
  {
    var requestBody = new { input = "Hello, world!" };

    var content = new StringContent(
      Newtonsoft.Json.JsonConvert.SerializeObject(requestBody),
      Encoding.UTF8,
      "application/json");

    client.DefaultRequestHeaders.Add("Authorization", "Bearer YOUR_API_KEY");

    var response = await client.PostAsync("YOUR_ENDPOINT", content);

    var responseString = await response.Content.ReadAsStringAsync();

    Console.WriteLine(responseString);
  }
}