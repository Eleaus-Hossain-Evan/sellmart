class SSLCredential {

  String storeID;
  String storePassword;

  SSLCredential({this.storeID, this.storePassword});

  SSLCredential.fromJson(Map<String, dynamic> json) {

    try {
      storeID = json['ssl_store_id'];
    }
    catch(error) {}

    try {
      storePassword = json['ssl_store_password'];
    }
    catch(error) {}
  }
}