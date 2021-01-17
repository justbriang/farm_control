import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/models/farmer.dart';

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
  Map<String, dynamic> farmerCredentials;

  final _formKey = GlobalKey<FormState>();
  final emailaddressController = new TextEditingController();
  final farmerNameController = new TextEditingController();
  _FarmerDetailState(this.farmerCredentials);

  @override
  Widget build(BuildContext context) {
    final farmerId = farmerCredentials['farmerId'];
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          title: const Text(
            "Farmer Detail",
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
        body: _buildContents(_formKey, farmerNameController,
            emailaddressController, farmerCredentials, farmerId));
  }

  Widget _editFarms() {
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
          'Add Farms',
          style: TextStyle(fontSize: 20, color: Colors.cyan),
        ),
      ),
    );
  }

  Widget _buildContents(
      GlobalKey _formKey,
      TextEditingController farmerNameController,
      TextEditingController emailaddressController,
      Map<String, dynamic> farmerCredentials,
      final farmerId) {
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
                    editextfield(
                        'username',
                        farmerCredentials['username'].toString(),
                        farmerNameController),
                    editextfield(
                        'Email Address',
                        farmerCredentials["email"].toString(),
                        emailaddressController),
                  ],
                )),
            SizedBox(
              height: 20.0,
            ),
            _editFarms(),
            SizedBox(
              height: 30.0,
            ),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: _addfarmerbtn(
                      farmerNameController, emailaddressController, farmerId),
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

  Widget _deletefarmerbtn(farmerId) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            
              Map<String, dynamic> farmerCredentials = {'farmerId': farmerId};
              Farmer farmer = new Farmer();
              print('farmer credts are ${farmerCredentials}');
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

  Widget _addfarmerbtn(TextEditingController usernamecontroller,
          TextEditingController emailaddressController, final farmerId) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map<String, dynamic> farmerCredentials = {
                "username": usernamecontroller.text.toString().trim(),
                "email": emailaddressController.text.toString().trim(),
                'farmerId': farmerId
              };
              Farmer farmer = new Farmer();
              print('farmer credts are ${farmerCredentials}');
              farmer.updateFarmer(farmerCredentials);

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
}
