import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/models/farm.dart';


List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add Referee')
];

class FarmerDetail extends StatefulWidget {
  final Map<String, dynamic> farmCredentials;
  FarmerDetail(this.farmCredentials, {Key key}) : super(key: key);

  @override
  _FarmerDetailState createState() => _FarmerDetailState(farmCredentials);
}

class _FarmerDetailState extends State<FarmerDetail> {
  Map<String, dynamic> farmCredentials;

  final _formKey = GlobalKey<FormState>();
  final farmNameController = new TextEditingController();
  final locationController = new TextEditingController();
  _FarmerDetailState(this.farmCredentials);

  @override
  Widget build(BuildContext context) {
    final farmId = farmCredentials['farmId'];
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          title: const Text(
            "Farmer Detail",
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
        body: _buildContents(_formKey, farmNameController,
            locationController, farmCredentials, farmId));
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
      TextEditingController farmNameController,
      TextEditingController locationController,
      Map<String, dynamic> farmCredentials,
      final farmId) {
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
                        'Farm Name',
                        farmCredentials['farmName'].toString(),
                        farmNameController),
                    editextfield(
                        'location',
                        farmCredentials["location"].toString(),
                        locationController),
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
                  child: _addfarmbtn(
                      farmNameController, locationController, farmId),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: _deletefarmbtn(farmId),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Widget _deletefarmbtn(farmId) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            
              Map<String, dynamic> farmerCredentials = {'farmId': farmId};
              Farm farm = new Farm();
              print('farmer credts are ${farmerCredentials}');
              farm.deleteFarm(farmerCredentials);

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

  Widget _addfarmbtn(TextEditingController farmNameController,
          TextEditingController locationController, final farmId) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map<String, dynamic> farmCredentials = {
                "farmName": farmNameController.text.toString().trim(),
                "location": locationController.text.toString().trim(),
                'farmId': farmId
              };
              Farm farm= new Farm();
              print('farmer credts are ${farmCredentials}');
              farm.updateFarm(farmCredentials);

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
            'Add Farm',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
