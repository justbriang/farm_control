import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/models/animalBreed.dart';
import 'package:flutter_works1/screens/Auth/LoginPage.dart';


class ProfileUI2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey<ScaffoldState>();
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl =
        'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';
    final _formKey = GlobalKey<FormState>();
    final breedNameController = new TextEditingController();

    Widget _addBreedbtn(breedNameController, ctx) => Padding(
          padding: const EdgeInsets.only(top: 25),
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Map<String, dynamic> breedCredentials = {
                  "breed": breedNameController.text.toString().trim()
                };
                AnimalBreed breed = new AnimalBreed();

                breed.addAnimal(breedCredentials);
                final snackBar = SnackBar(
                    content: Text('breed Successfully Updated'),
                    backgroundColor: Colors.green);
                globalKey.currentState.showSnackBar(snackBar);
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
    Future<void> _signout() async {
      await FirebaseAuth.instance.signOut();
    }

    Widget _addLogoutbtn() {
      return InkWell(
        onTap: () {
          _signout();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    Widget _buildDialogContents() => Container(
          color: Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0))),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding:  EdgeInsets.only(left: _width / 8, right: _width / 8),
                      child: Text(
                        'Add Farm',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  entryField("Farm Name", breedNameController),
                                ],
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          _addBreedbtn(breedNameController, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    void _addBreedWidget() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return _buildDialogContents();
          }).whenComplete(() {});
    }

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.blue,
        ),
        Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
        BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )),
        Scaffold(
            appBar: AppBar(
              title: Center(child: Text('profile')),
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height / 12,
                  ),
                  CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  SizedBox(
                    height: _height / 25.0,
                  ),
                  Text(
                    'Master Wong',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width / 15,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                    child: Text(
                      'Senior vertinary at Fuga.\nSometime I work at my clinic in Kirinyaga ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: _width / 25,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    height: _height / 30,
                    color: Colors.white,
                  ),
                  Row(
                    children: <Widget>[
                      rowCell('Title', 'CHO'),
                      rowCell('Availability', 'Always'),
                      rowCell(' Experience', '7 years'),
                    ],
                  ),
                  Divider(height: _height / 30, color: Colors.white),
                  _addLogoutbtn(),
                  //TOdo: Move this elsewhere
                  Padding(
                    padding:
                        EdgeInsets.only(left: _width / 8, right: _width / 8),
                    child: FlatButton(
                      onPressed: () => _addBreedWidget(),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.person),
                          SizedBox(
                            width: _width / 30,
                          ),
                          Text('Add Breed')
                        ],
                      )),
                      color: Colors.blue[50],
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget rowCell(count, String type) => Expanded(
          child: Column(
        children: <Widget>[
          Text(
            '$count',
            style: TextStyle(color: Colors.white),
          ),
          Text(type,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}
