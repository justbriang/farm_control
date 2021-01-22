import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_works1/models/farm.dart';
import 'package:flutter_works1/screens/animals/addAnimal.dart';
import 'package:flutter_works1/screens/animals/animalpage.dart';

class FarmDetail extends StatefulWidget {
  final Map<String, dynamic> farmCredentials;
  FarmDetail(this.farmCredentials, {Key key}) : super(key: key);

  @override
  _FarmDetailState createState() => _FarmDetailState(this.farmCredentials);
}

class _FarmDetailState extends State<FarmDetail> {
  Map<String, dynamic> farmCredentials;
  _FarmDetailState(this.farmCredentials);
  @override
  void initState() {
    super.initState();
    _calcuteAnimals(this.farmCredentials['farmId']);
  }

  int animals = 0;
  DateTime scheduledVisit;
    
  final _formKey = GlobalKey<FormState>();
  final locationController = new TextEditingController();
  final farmNameController = new TextEditingController();
  final animalCountController = new TextEditingController();
  String breedId = 'breed';

  Widget _addfarmbtn(final farmcredentials) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print(scheduledVisit.toString());
              Farm farm = new Farm();

              if (scheduledVisit == null) {
                farmCredentials = {
                  "farmName": farmcredentials['farmName'],
                  "location": farmcredentials['location'],
                  'farmerId': farmcredentials['farmerId'],
                  'farmId': farmCredentials['farmId']
                };
              } else {
                farmCredentials = {
                  "farmName": farmcredentials['farmName'],
                  "location": farmcredentials['location'],
                  'farmerId': farmcredentials['farmerId'],
                  'scheduled Visit': scheduledVisit,
                  'farmId': farmCredentials['farmId']
                };
              }
              farm.updateFarm(farmCredentials);

              Navigator.pop(context);
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
                        key:_formKey,
                          child: Column(
                        children: <Widget>[
                          Text('Next Schedule'),
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
                      _addfarmbtn(farmCredentials),
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
    
    final farmerId = farmCredentials['farmerId'];
    void _addFarmerWidget() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return _buildDialogContents();
          }).whenComplete(() {});
    }

    Widget _farmSummary(BuildContext context, farmId) => Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 30),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AnimalPage(farmId, 'farm')));
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Animals',
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          Text(
                            animals.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          )
                        ],
                      ))),
            ),
          ],
        );

    Widget _deletefarmbtn(farmId) => Padding(
          padding: const EdgeInsets.only(top: 25),
          child: RaisedButton(
            onPressed: () {
              Map<String, dynamic> farmerCredentials = {'farmId': farmId};
              Farm farmer = new Farm();

              farmer.deleteFarm(farmerCredentials);

              Navigator.of(context).pop();
            },
            color: Colors.red,
            focusColor: Colors.blue,
            disabledColor: Colors.blue,
            padding: const EdgeInsets.all(13),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Delete Farm',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
    Widget _editFarms(Map<String, dynamic> farmCredentials) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddAnimalPage(farmCredentials)));
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
            'Add Animal',
            style: TextStyle(fontSize: 20, color: Colors.cyan),
          ),
        ),
      );
    }

    String _dateChecker(scheduled) {
      if (scheduled == null)
        return '';
      else
        return scheduled.toDate().toString();
    }

    Widget _buildContents(
        TextEditingController farmNameController,
        TextEditingController locationController,
        Map<String, dynamic> farmCredentials,
        final farmerId,
        BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 10),
                          child: ListTile(
                            leading: Text(
                              'Farm Name :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            title: Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 10),
                              child: Text(
                                farmCredentials['farmName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 10),
                          child: ListTile(
                            leading: Text(
                              'Location :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            title: Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 10),
                              child: Text(
                                farmCredentials['location'],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 10),
                        child: ListTile(
                          leading: Text(
                            'Scheduled Visit :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          title: Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 10),
                            child: Text(
                              _dateChecker(
                                farmCredentials['scheduled Visit'],
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          )),
                        ),
                      )),
                    ],
                  ),
                ],
              )),
              SizedBox(
                height: 20.0,
              ),
              _farmSummary(context, farmCredentials['farmId']),
              SizedBox(
                height: 30.0,
              ),
              _editFarms(farmCredentials),
              Row(children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: _deletefarmbtn(farmCredentials['farmId']),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
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
          "Farm Details",
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
      body: _buildContents(farmNameController, locationController,
          farmCredentials, farmerId, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> farmerCredentials = {'farmerId': farmerId};
          _addFarmerWidget();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Future<void> _calcuteAnimals(farmId) async {
    int counter = 0;
    FirebaseFirestore.instance
        .collection('animal')
        .where('farmId', isEqualTo: farmId)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(int.parse(doc.data()['Animal Count']));
                counter += int.parse(doc.data()['Animal Count']);
              }),
              setState(() {
                animals = counter;
              })
            });
  }
}
