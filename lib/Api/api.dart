
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_works1/models/farmer.dart';



class Api{
    CollectionReference _farmerCollectionReference = FirebaseFirestore.instance.collection('farmer');

    Future addFarm(Farmer farmer) async {
    try {
      await _farmerCollectionReference.add(farmer.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }
 
}