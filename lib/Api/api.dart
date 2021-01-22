import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_works1/models/farmer.dart';

class Api {
  CollectionReference _farmerCollectionReference =
      FirebaseFirestore.instance.collection('farmer');
  CollectionReference _farmCollectionReference =
      FirebaseFirestore.instance.collection('farm');
  CollectionReference _animalCollectionReference =
      FirebaseFirestore.instance.collection('animal');
  CollectionReference _animalBreedReference=
      FirebaseFirestore.instance.collection('animalBreed');
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
        .update({
          'email': farmerCredentials['email'],
          'username': farmerCredentials['username']
        })
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
      print('called add farm');

      await _farmCollectionReference.add(farmCredentials);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateFarm(Map<String, dynamic> farmCredentials) {
    return _farmCollectionReference
        .doc(farmCredentials['farmId'])
        .update(farmCredentials)
        .then((value) => print("Farm Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteFarm(Map<String, dynamic> farmCredentials) {
    return _farmCollectionReference
        .doc(farmCredentials['farmId'])
        .delete()
        .then((value) => print("Farm Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  Future addAnimal(Map<String, dynamic> animalCredentials) async {
    try {


      await _animalCollectionReference.add(animalCredentials);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateAnimal(Map<String, dynamic> animalCredentials) {
    return _animalCollectionReference
        .doc(animalCredentials['farmerId'])
        .update({
          'email': animalCredentials['email'],
          'username': animalCredentials['username']
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteAnimal(Map<String, dynamic> animalCredentials) {
    return _animalCollectionReference
        .doc(animalCredentials['farmerId'])
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  Future addBreed(Map<String, dynamic> animalCredentials) async {
    try {


      await _animalBreedReference.add(animalCredentials);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateBreed(Map<String, dynamic> animalCredentials) {
    return _animalBreedReference
        .doc(animalCredentials['breedId'])
        .update({
          'breed': animalCredentials['breed'],
         
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteBreed(Map<String, dynamic> animalCredentials) {
    return _animalBreedReference
        .doc(animalCredentials['breedId'])
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
