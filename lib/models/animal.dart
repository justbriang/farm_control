import 'package:flutter_works1/Api/api.dart';

class Animal {
  String animalBreed;
  String number;

  Api api = new Api();

  Animal({this.animalBreed, this.number});

  Animal.fromMap(Map snapshot)
      : animalBreed = snapshot['animalBreed'] ?? '',
        number = snapshot['number'] ?? '';

  toJson() {
    return {"animalBreed": animalBreed, "number": number};
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'animalBreed': animalBreed,
      'number': number,
     
    };
  }

  addAnimal(Map<String, dynamic> farmCredentials) async {
    var result =
        await api.addAnimal(farmCredentials); // We need to add the current userId

    if (result is String) {
      print('Error');
    } else {
      print('success');
    }
  }

  updateAnimal(Map<String, dynamic> farmCredentials) async {
    await api.updateAnimal(farmCredentials); // We need to add the current userId
  }

  deleteAnimal(Map<String, dynamic> farmCredentials) async {
    await api.deleteAnimal(farmCredentials); // We need to add the current userId
  }
}
