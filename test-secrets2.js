// This is another test file for secret scanning
// The following line contains a fake secret that should be detected

const config = {
  awsSecretKey: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
  endpoint: "https://api.example.com",
  password: "SuperSecretPassword123!"
};

function authenticate() {
  // This function would use the secret key to authenticate
  console.log("Authenticating with AWS Secret Key");
}

authenticate(); 