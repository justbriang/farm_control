import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/app_icons.dart';
import 'package:flutter_works1/models/farmer.dart';

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

  Widget _addfarmsBtn() {
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

  Widget _addfarmerbtn(TextEditingController usernamecontroller,
          TextEditingController emailController) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map<String, dynamic> farmerCredentials = {
                "username": usernamecontroller.text.toString().trim(),
                "email": emailaddressController.text.toString().trim(),
              };
              Farmer farmer = new Farmer();
              Future<String> result= farmer.addFarmer(farmerCredentials);
              

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
                              entryField(
                                  "Email Address", emailaddressController),
                            ],
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      _addfarmsBtn(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _addfarmerbtn(
                          farmerNameController, emailaddressController),
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
    ));
  }
}
