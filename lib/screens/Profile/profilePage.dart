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
        'https://images.all-free-download.com/images/graphiclarge/girl_portrait_514885.jpg';
    final _formKey = GlobalKey<FormState>();
    final breedNameController = new TextEditingController();

    Future<void> _signout() async {
      await FirebaseAuth.instance.signOut();
    }

    // Widget _addLogoutbtn() {
    //   return InkWell(
    //     onTap: () {
    //       _signout();
    //       Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(builder: (context) => LoginPage()),
    //           (Route<dynamic> route) => false);
    //     },
    //     child: Container(
    //       width: MediaQuery.of(context).size.width,
    //       padding: EdgeInsets.symmetric(vertical: 13),
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(Radius.circular(5)),
    //         border: Border.all(color: Colors.white, width: 2),
    //       ),
    //       child: Text(
    //         'Logout',
    //         style: TextStyle(fontSize: 20, color: Colors.white),
    //       ),
    //     ),
    //   );
    // }

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
              title: Center(child: Text('Profile Page')),
              centerTitle: false,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    _signout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                )
              ],
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
         
                  //TOdo: Move this elsewhere
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
