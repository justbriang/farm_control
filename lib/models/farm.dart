import 'package:flutter_works1/Api/api.dart';

class Farm {
  String farmName;
  String location;
  String farmerId;

  Api api = new Api();

  Farm({this.farmName, this.location, this.farmerId});

  Farm.fromMap(Map snapshot)
      : farmName = snapshot['farmName'] ?? '',
        location = snapshot['location'] ?? '',
        farmerId = snapshot['farmerId'] ?? '';

  toJson() {
    return {"farmName": farmName, "location": location, 'farmerId': farmerId};
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'farmName': farmName,
      'location': location,
      'farmerId': farmerId
    };
  }

  addFarm(Map<String, dynamic> farmCredentials) async {
    var result =
        await api.addFarm(farmCredentials); // We need to add the current userId

    if (result is String) {
      print('Error');
    } else {
      print('success');
    }
  }

  updateFarm(Map<String, dynamic> farmCredentials) async {
    Map<String, dynamic> farmUpdate;
    if (farmCredentials['scheduled Visit'] == null) {
      farmUpdate = {
        "farmName": farmCredentials['farmName'],
        "location": farmCredentials['location'],
        'farmerId': farmCredentials['farmerId'],
        'farmId':farmCredentials['farmId']
      };
    } else {
      farmUpdate = {
        "farmName": farmCredentials['farmName'],
        "location": farmCredentials['location'],
        'farmerId': farmCredentials['farmerId'],
        'farmId':farmCredentials['farmId'],
        'scheduled Visit': farmCredentials['scheduled Visit'],
      };
    }

    await api.updateFarm(farmUpdate); // We need to add the current userId
  }

  deleteFarm(Map<String, dynamic> farmCredentials) async {
    await api.deleteFarm(farmCredentials); // We need to add the current userId
  }
}
