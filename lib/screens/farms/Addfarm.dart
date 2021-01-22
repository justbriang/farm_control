import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/models/farm.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_works1/screens/farms/farmsPage.dart';

List<AppIcons> appBarIcons = [
  AppIcons(icon: Icons.add, semanticLabel: 'Add farm')
];

class AddFarm extends StatefulWidget {
  final Map<String, dynamic> farmCredentials;
  AddFarm(this.farmCredentials, {Key key}) : super(key: key);

  @override
  _AddFarmState createState() => _AddFarmState(farmCredentials);
}

class _AddFarmState extends State<AddFarm> {
  Map<String, dynamic> farmCredentials;
  DateTime scheduledVisit;
  final _formKey = GlobalKey<FormState>();
  final farmNameController = new TextEditingController();
  final locationController = new TextEditingController();
  _AddFarmState(this.farmCredentials);

  @override
  Widget build(BuildContext context) {
    final farmerId = farmCredentials['farmerId'];

    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          title: const Text(
            "Farmer Detail",
            style: TextStyle(color: Colors.lightBlue),
          ),
        ),
        body: _buildContents(_formKey, farmNameController, locationController,
            farmCredentials, farmerId));
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
                    entryField('Farm Name', farmNameController),
                    entryField('location', locationController),
                    DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'scheduled Visit',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        scheduledVisit = DateTime.parse(val);
                        print(val);
                        return null;
                      },
                      onSaved: (val) {
                        print(val);
                      },
                    ),
                  ],
                )),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: _addfarmbtn(
                      farmNameController, locationController, farmerId),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: _deletefarmbtn(farmerId),
                ),
              ),
            ]),
            SizedBox(
              height: 20.0,
            ),
            _editFarms(),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _deletefarmbtn(farmerId) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            Map<String, dynamic> farmerCredentials = {'farmerId': farmerId};
            Farm farm = new Farm();

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
              Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FarmsPage(farmerId)));
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
