import 'package:flutter_works1/Api/api.dart';

class Farmer {
  String username;
  String email;
  List<String> farms;
  Api api = new Api();

  Farmer({this.username, this.email});

  Farmer.fromMap(Map snapshot)
      : username = snapshot['username'] ?? '',
        email = snapshot['email'] ?? '';
  // farms = snapshot['farms'] ?? '';

  toJson() {
    return {
      "username": username,
      "email": email,
      // "farms": farms,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email
      //'farms': farms
    };
  }

  Future<String> addFarmer(Map<String, dynamic> farmerCredentials) async {
    var result = await api.addFarm(Farmer(
        username: username, email: email)); // We need to add the current userId

    if (result is String) {
      
      return 'Error';
    } else {
      return 'success';
    }
  }
}
