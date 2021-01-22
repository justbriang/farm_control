import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/Widgets/loading_shimmer.dart';

import 'package:flutter_works1/models/farm.dart';

import 'package:flutter_works1/screens/farms/Addfarm.dart';
import 'package:flutter_works1/screens/farms/farmdetail.dart';

List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add Farms')
];

class FarmsPage extends StatefulWidget {
  final String farmerId;
  FarmsPage(this.farmerId, {Key key}) : super(key: key);

  @override
  _FarmsPageState createState() => _FarmsPageState(farmerId);
}

class _FarmsPageState extends State<FarmsPage> {
  String farmerId;
  final farmNameController = new TextEditingController();
  final locationController = new TextEditingController();
  final emailController = new TextEditingController();
  bool isUpdating = false;
  DateTime scheduledVisit;
  final _formKey = GlobalKey<FormState>();

  _FarmsPageState(this.farmerId);

  
  Widget _addfarmbtn(TextEditingController farmNameController,
          TextEditingController locationController, final farmerId) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map<String, dynamic> farmCredentials;

              if (scheduledVisit == null) {
                farmCredentials = {
                  "farmName": farmNameController.text.toString().trim(),
                  "location": locationController.text.toString().trim(),
                  'farmerId': farmerId
                };
              } else {
                farmCredentials = {
                  "farmName": farmNameController.text.toString().trim(),
                  "location": locationController.text.toString().trim(),
                  'farmerId': farmerId,
                  'scheduled Visit': scheduledVisit
                };
              }
              Farm farm = new Farm();

              farm.addFarm(farmCredentials);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FarmsPage(farmerId)));
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
                              entryField("Farm Name", farmNameController),
                              entryField("Location", locationController),
                              DateTimePicker(
                                initialValue: '',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: 'scheduled Visit',
                                onChanged: (val) => print(val),
                                validator: (val) {
                                  if (val != null && val != '') {
                                    scheduledVisit = DateTime.parse(val);
                                    print(val);
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  print(val);
                                },
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      _addfarmbtn(
                          farmNameController, locationController, farmerId),
                      SizedBox(
                        height: 30.0,
                      ),
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
    print('im at farms oage');
    Farm farm = new Farm();
    Query collectionStream = FirebaseFirestore.instance
        .collection('farm')
        .where('farmerId', isEqualTo: farmerId);
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
          "Farm",
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
                  title: new Text(document.data()['farmName']),
                  subtitle: new Text(document.data()['location']),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      var doc_id2 = document.id;
                      Map<String, dynamic> farmerCredentials = {
                        "farmName": document.data()['farmName'],
                        'location': document.data()['location'],
                        'farmId': document.id,
                        'farmerId': document.data()['farmerId'],
                        'scheduled Visit': document.data()['scheduled Visit']
                      };
                      return FarmDetail(farmerCredentials);
                    }));
                  },
                );
              }).toList(),
            );
          }
          return Center(child: Text('empty'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> farmerCredentials = {'farmerId': farmerId};
          _addFarmerWidget();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => AddFarm(farmerCredentials)));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
