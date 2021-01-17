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

   addFarmer(Map<String, dynamic> farmerCredentials) async {
   
    var result = await api.addFarmer(farmerCredentials); // We need to add the current userId

    if (result is String) {
      
      print( 'Error');
    } else {
      print('success');
    }
  }
   updateFarmer(Map<String, dynamic> farmerCredentials) async {
   
    await api.updateFarmer(farmerCredentials); // We need to add the current userId

  }
 deleteFarmer(Map<String, dynamic> farmerCredentials) async {
   
    await api.deleteFarmer(farmerCredentials); // We need to add the current userId

  }
}
