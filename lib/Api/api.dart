import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_works1/models/farmer.dart';

class Api {
  CollectionReference _farmerCollectionReference =
      FirebaseFirestore.instance.collection('farmer');
  CollectionReference _farmCollectionReference =
      FirebaseFirestore.instance.collection('farm');
  Future addFarmer(Map<String, dynamic> farmerCredentials) async {
    try {
  
      await _farmerCollectionReference.add(farmerCredentials);
      return true;
    } catch (e) {
      return e.toString();
    }
  }
 Future<void> updateFarmer(Map<String, dynamic> farmerCredentials) {
  return _farmerCollectionReference
    .doc(farmerCredentials['farmerId'])
    .update({'email':farmerCredentials['email'] ,'username':farmerCredentials['username']})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}

Future<void> deleteFarmer(Map<String, dynamic> farmerCredentials) {
  return _farmerCollectionReference
    .doc(farmerCredentials['farmerId'])
    .delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete user: $error"));
}

Future addFarm(Map<String, dynamic> farmCredentials) async {
    try {
  
      await _farmCollectionReference.add(farmCredentials);
      return true;
    } catch (e) {
      return e.toString();
    }
  }
   Future<void> updateFarm(Map<String, dynamic> farmCredentials) {
  return _farmCollectionReference
    .doc(farmCredentials['farmerId'])
    .update({'email':farmCredentials['email'] ,'username':farmCredentials['username']})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}
Future<void> deleteFarm(Map<String, dynamic> farmCredentials) {
  return _farmCollectionReference
    .doc(farmCredentials['farmerId'])
    .delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete user: $error"));
}

}
