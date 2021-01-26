import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';

import 'package:flutter_works1/models/farmer.dart';
import 'package:flutter_works1/screens/animals/animalpage.dart';
import 'package:flutter_works1/screens/farmer/FarmersPage.dart';
import 'package:flutter_works1/screens/farms/Addfarm.dart';

import 'package:flutter_works1/screens/farms/farmsPage.dart';

List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add Referee')
];

class FarmerDetail extends StatefulWidget {
  final Map<String, dynamic> farmerCredentials;
  FarmerDetail(this.farmerCredentials, {Key key}) : super(key: key);

  @override
  _FarmerDetailState createState() => _FarmerDetailState(farmerCredentials);
}

class _FarmerDetailState extends State<FarmerDetail> {
  @override
  void initState() {
    print(farmerCredentials);
    super.initState();
    _calcutefarms(this.farmerCredentials['farmerId']);
    _calcuteAnimals(this.farmerCredentials['farmerId']);
  }

  Map<String, dynamic> farmerCredentials;
  int farms, animals = 0;
  final globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final emailaddressController = new TextEditingController();
  final farmerNameController = new TextEditingController();
  final telephoneNoController = new TextEditingController();
  final countryNameController = new TextEditingController();
  _FarmerDetailState(this.farmerCredentials);

  @override
  Widget build(BuildContext context) {
    final farmerId = farmerCredentials['farmerId'];

    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.lightBlue,
              size: 24.0,
              semanticLabel: 'Go to settings',
            ),
            onPressed: () {
                  Navigator.push(
            context, MaterialPageRoute(builder: (context) => FarmersPage()));
            },
          ),
          elevation: 4,
          backgroundColor: Colors.white,
          title: const Text(
            "Farmer Detail",
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
        body: _buildContents(
            _formKey,
            farmerNameController,
            emailaddressController,
            countryNameController,
            telephoneNoController,
            farmerCredentials,
            farmerId,
            context));
  }

  Widget _editFarms(farmerId) {
    return InkWell(
      onTap: () {
        print('clicked on ${farmerId}');

        Map<String, dynamic> farmerCredentials = {'farmerId': farmerId};
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddFarm(farmerCredentials)));
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
          'Add Farm',
          style: TextStyle(fontSize: 20, color: Colors.cyan),
        ),
      ),
    );
  }

  Widget _buildContents(
      GlobalKey _formKey,
      TextEditingController farmerNameController,
      TextEditingController emailaddressController,
      TextEditingController countryNameController,
      TextEditingController telephoneNoController,
      Map<String, dynamic> farmerCredentials,
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
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    editextfield('Username', farmerCredentials['username'],
                        Icons.person, farmerNameController),
                    editextfield('Email Address', farmerCredentials['email'],
                        Icons.email, emailaddressController),
                    editextfield('Telephone', farmerCredentials['telephone'],
                        Icons.phone, telephoneNoController),
                    editextfield('Country', farmerCredentials['country'],
                        Icons.map, countryNameController),
                  ],
                )),
            SizedBox(
              height: 20.0,
            ),
            _profileSummary(context, farmerId),
            SizedBox(
              height: 30.0,
            ),
            //_editFarms(farmerId),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: _addfarmerbtn(
                      farmerNameController,
                      emailaddressController,
                      countryNameController,
                      telephoneNoController,
                      farmerId,
                      farmerCredentials,
                      context),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: _deletefarmerbtn(farmerId),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Widget _profileSummary(BuildContext context, farmerId) => Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 30),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FarmsPage(farmerId)));
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Farms',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        Text(
                          farms.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        )
                      ],
                    ))),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimalPage(farmerId,'farmer')));
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
                    ),
                  ))),
        ],
      );
  Future<void> _calcutefarms(farmerId) async {
    int counter = 0;
    FirebaseFirestore.instance
        .collection('farm')
        .where('farmerId', isEqualTo: farmerId)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                counter += 1;
              }),
              setState(() {
                farms = counter;
              })
            });
  }

  Future<void> _calcuteAnimals(farmerId) async {
    int counter = 0;
    FirebaseFirestore.instance
        .collection('animal')
        .where('farmerId', isEqualTo: farmerId)
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

  Widget _deletefarmerbtn(farmerId) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            Map<String, dynamic> farmerCredentials = {'farmerId': farmerId};
            Farmer farmer = new Farmer();

            farmer.deleteFarmer(farmerCredentials);

            Navigator.of(context).pop();
          },
          color: Colors.red,
          focusColor: Colors.blue,
          disabledColor: Colors.blue,
          padding: const EdgeInsets.all(13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Delete Farmer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  Widget _addfarmerbtn(
          TextEditingController usernamecontroller,
          TextEditingController emailaddressController,
          TextEditingController countryNameController,
          TextEditingController telephoneNoController,
          final farmerId,
          credentials,
          BuildContext contexst) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (usernamecontroller.text.toString().trim() == '' &&
                emailaddressController.text.toString().trim() == '' &&
                countryNameController.text.toString().trim() == '' &&
                telephoneNoController.text.toString().trim() == '') {
              final snackBar = SnackBar(
                  content: Text('No changes made'),
                  backgroundColor: Colors.red);
              globalKey.currentState.showSnackBar(snackBar);
            } else {
              if (usernamecontroller.text.toString() == '')
                usernamecontroller.text = credentials['username'];
              if (emailaddressController.text.toString() == '')
                emailaddressController.text = credentials['email'];
              if (telephoneNoController.text.toString().trim() == '')
                telephoneNoController.text = credentials['telephone'];
              if (countryNameController.text.toString().trim() == '')
                countryNameController.text = credentials['country'];

              if (_formKey.currentState.validate()) {
                Map<String, dynamic> farmerCredentials = {
                  "username": usernamecontroller.text.toString().trim(), 
                  "email": emailaddressController.text.toString().trim() ,
                  'farmerId': farmerId,
                  'country':countryNameController.text.toString().trim(),
                  'telephone':telephoneNoController.toString().trim()
                };
                Farmer farmer = new Farmer();

                farmer.updateFarmer(farmerCredentials);
                final snackBar = SnackBar(
                    content: Text('User Successfully Updated'),
                    backgroundColor: Colors.green);
                globalKey.currentState.showSnackBar(snackBar);
                Navigator.of(context).pop();
              }
            }
          },
          color: Colors.blue,
          focusColor: Colors.blue,
          disabledColor: Colors.blue,
          padding: const EdgeInsets.all(13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Update Farmer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
