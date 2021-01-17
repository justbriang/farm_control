import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/Widgets/loading_shimmer.dart';
import 'package:flutter_works1/Widgets/show_message.dart';
import 'package:flutter_works1/models/farm.dart';
import 'package:flutter_works1/screens/FarmerDetails.dart';

List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add Farms')
];

class FarmsPage extends StatefulWidget {
  FarmsPage({Key key}) : super(key: key);

  @override
  _FarmsPageState createState() => _FarmsPageState();
}

class _FarmsPageState extends State<FarmsPage> {
  final farmNameController = new TextEditingController();
  final locationController = new TextEditingController();
  final emailController = new TextEditingController();
  bool isUpdating = false;

  final _formKey = GlobalKey<FormState>();

  void _addFarmerWidget() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return _buildDialogContents();
        }).whenComplete(() {
      isUpdating = false;
    });
  }

  Widget _addBreedsBtn() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {}));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.cyan, width: 2),
        ),
        child: Text(
          'Add Animal Breed',
          style: TextStyle(fontSize: 20, color: Colors.cyan),
        ),
      ),
    );
  }

  Widget _addfarmbtn(
          TextEditingController farmNameController,
          TextEditingController locationController,
          TextEditingController emailController,
          BuildContext ctx) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Future<QuerySnapshot> document = FirebaseFirestore.instance
                  .collection('farmers')
                  .where('email',
                      isEqualTo: emailController.text.toString().trim())
                  .get();

              document.then((QuerySnapshot documentSnapshot) {
                if (documentSnapshot != null) {
                  var farmer_id;
                  documentSnapshot.docs.map((DocumentSnapshot document) {
                    farmer_id = document;
                    Map<String, dynamic> farmCredentials = {
                      'farmerId': farmer_id,
                      "farmName": farmNameController.text.toString().trim(),
                      "location": locationController.text.toString().trim(),
                    };
                    Farm _farmer = new Farm();
                    print('farmer credts are ${farmCredentials}');
                    _farmer.addFarm(farmCredentials);

                    Navigator.of(context).pop();
                  });
                  print('${farmer_id}');
                } else {
                  print('nonthing');
                }
              });
            }
          },
          color: Colors.blue,
          focusColor: Colors.blue,
          disabledColor: Colors.blue,
          padding: const EdgeInsets.all(13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Add Farm',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  Widget _buildDialogContents() => Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'Add Farm',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              entryField('Farmer Email', emailController),
                              entryField("Farm Name", farmNameController),
                              entryField("Location", locationController),
                            ],
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      _addBreedsBtn(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _addfarmbtn(farmNameController, locationController,
                          emailController, context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    Farm farm = new Farm();
    Stream collectionStream =
        FirebaseFirestore.instance.collection('farm').snapshots();
    CollectionReference farmers = FirebaseFirestore.instance.collection('farm');
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          actions: appBarIcons
              .map<Widget>((iconDetails) => IconButton(
                    onPressed: () {
                      _addFarmerWidget();
                    },
                    icon: Icon(
                      iconDetails.icon,
                      size: 24.0,
                      color: Colors.lightBlue,
                      semanticLabel: iconDetails.semanticLabel,
                    ),
                  ))
              .toList(),
          backgroundColor: Colors.white,
          title: const Text(
            "Farm",
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: farmers.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingProgressIndicator();
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              // print('=== data ===: ${farmer.toJson(snapshot.data);}');

              // return Text('${snapshot.data}');
              return new ListView(
                children: documents.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document.data()['farmName']),
                    subtitle: new Text(document.data()['location']),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        var doc_id2 = document.id;
                        Map<String, dynamic> farmerCredentials = {
                          "farmName": document.data()['farmName'],
                          'location': document.data()['location'],
                          'farmId': document.id
                        };
                        return FarmerDetail(farmerCredentials);
                      }));
                    },
                  );
                }).toList(),
              );
            }
            return Center(child: Text('empty'));
          },
        ));
  }
}
