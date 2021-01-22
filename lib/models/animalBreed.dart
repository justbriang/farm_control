import 'package:flutter_works1/Api/api.dart';

class AnimalBreed{
  String animalBreed;
  String number;
  String farmerId;
 
  Api api = new Api();

  AnimalBreed({this.animalBreed, this.number,this.farmerId});

  AnimalBreed.fromMap(Map snapshot)
      : animalBreed = snapshot['animalBreed'] ?? '',
        number = snapshot['number'] ?? '',
        farmerId = snapshot['farmerId']??'';
  

  toJson() {
    return {
      "animalBreed": animalBreed,
      "number": number,
      'farmerId':farmerId
      
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'animalBreed': animalBreed,
      'number': number,
      'farmerId':farmerId
       
    };
  }
  addAnimal(Map<String, dynamic> farmCredentials) async {
   
    var result = await api.addBreed(farmCredentials); // We need to add the current userId

    if (result is String) {
      
      print( 'Error');
    } else {
      print('success');
    }
  }
   updateAnimal(Map<String, dynamic> farmCredentials) async {
   
    await api.updateBreed(farmCredentials); // We need to add the current userId

  }
 deleteAnimal(Map<String, dynamic> farmCredentials) async {
   
    await api.deleteBreed(farmCredentials); // We need to add the current userId

  }
}
