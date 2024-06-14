1. lets do create account with google now
   1. data source method that will first get id token from google sign in wrapper
   2. data source method that will send id token to the server and get back the user data
   3. repository method that is called authenticate with google
      1. it will get authenticated player data and pass it to the database 
   4. use case that is called to call method authenticate with google
   5. then redirection should happen automatically