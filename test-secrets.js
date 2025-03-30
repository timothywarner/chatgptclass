// This is a test file for secret scanning
// The following line contains a fake secret that should be detected

const config = {
  apiKey: "AKIAIOSFODNN7EXAMPLE",
  endpoint: "https://api.example.com",
  username: "admin"
};

function getData() {
  // This function would use the API key to authenticate
  console.log("Fetching data with API key");
}

getData(); 