import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/Widgets/loading_shimmer.dart';
import 'package:flutter_works1/models/farmer.dart';
import 'package:flutter_works1/screens/farmer/FarmerDetails.dart';

List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add Referee')
];

class FarmersPage extends StatefulWidget {
  FarmersPage({Key key}) : super(key: key);

  @override
  _FarmersPageState createState() => _FarmersPageState();
}

class _FarmersPageState extends State<FarmersPage> {
  final emailaddressController = new TextEditingController();
  final farmerNameController = new TextEditingController();
  final telephoneNoController = new TextEditingController();
  bool isUpdating = false;
  String prefix, countryName;
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

  Widget _addfarmerbtn(
          TextEditingController usernamecontroller,
          TextEditingController emailController,
          TextEditingController telephoneNoController) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map<String, dynamic> farmerCredentials = {
                "username": usernamecontroller.text.toString().trim(),
                "email": emailaddressController.text.toString().trim(),
                "telephone":
                    prefix + telephoneNoController.text.toString().trim(),
                'country': countryName
              };
              Farmer farmer = new Farmer();
              print('farmer credts are ${farmerCredentials}');
              farmer.addFarmer(farmerCredentials);

              Navigator.of(context).pop();
            }
          },
          color: Colors.blue,
          focusColor: Colors.blue,
          disabledColor: Colors.blue,
          padding: const EdgeInsets.all(13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Add Farmer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
  Widget _buildDropdownItem(Country country) {
    //print('${country.phoneCode}');
    return Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}(${country.isoCode})"),
        ],
      ),
    );
  }

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
                    'Add Farmer',
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
                              entryField("Username", farmerNameController),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: CountryPickerDropdown(
                                      initialValue: 'in',
                                      itemBuilder: _buildDropdownItem,
                                      onValuePicked: (Country country) {
                                        prefix = country.phoneCode;
                                        countryName = country.name;
                                        setState(() {
                                          countryName = country.name;
                                        });
                                        print("country is ${country.name}");
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: entryField(
                                          'Telephone', telephoneNoController)),
                                ],
                              ),
                              entryField(
                                  "Email Address", emailaddressController),
                            ],
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      _addfarmerbtn(farmerNameController,
                          emailaddressController, telephoneNoController),
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
    CollectionReference farmers =
        FirebaseFirestore.instance.collection('farmer');
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
          "Farmers",
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: farmers.snapshots(),
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
                  title: new Text(document.data()['username']),
                  subtitle: new Text(document.data()['country']),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      Map<String, dynamic> farmerCredentials = {
                        "username": document.data()['username'],
                        'email': document.data()['email'],
                        'farmerId': document.id,
                        'telephone': document.data()['telephone'],
                         'country': document.data()['country'],
                         
                      };
                      return FarmerDetail(farmerCredentials);
                    }));
                  },
                );
              }).toList(),
            );
          }
          return Text('nothing');
        },
      ),
    );
  }
}
