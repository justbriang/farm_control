import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/Widgets/loading_shimmer.dart';


List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add Referee')
];

class AnimalPage extends StatefulWidget {
  final String farmerId;
  final String checker;
  AnimalPage(this.farmerId, this.checker, {Key key}) : super(key: key);

  @override
  _AnimalPageState createState() =>
      _AnimalPageState(this.farmerId, this.checker);
}

class _AnimalPageState extends State<AnimalPage> {
  final String farmerId, checker;

  var selectedbreed;
  final animalCountController = new TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  _AnimalPageState(this.farmerId, this.checker);

  
  @override
  Widget build(BuildContext context) {
    Query collectionStream;
    if (checker == 'farmer') {
      collectionStream = FirebaseFirestore.instance
          .collection('animal')
          .where('farmerId', isEqualTo: farmerId);
    } else {
      collectionStream = FirebaseFirestore.instance
          .collection('animal')
          .where('farmId', isEqualTo: farmerId);
    }
    
   

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightBlue,
            size: 24.0,
            semanticLabel: 'Go to settings',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        title: const Text(
          "Animal List",
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionStream.get().asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingProgressIndicator();
          }

          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;

            return new ListView(
              children: documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document.data()['breed']),
                  subtitle:
                      new Text(document.data()['Animal Count'].toString()),
                  onTap: () {},
                );
              }).toList(),
            );
          } else {
            return Text(' No animal');
          }
        },
      ),

    );
  }
  
}
