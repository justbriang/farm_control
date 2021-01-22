import 'package:flutter/material.dart';

import 'package:flutter_works1/screens/Profile/profilePage.dart';
import 'package:flutter_works1/screens/farmer/FarmersPage.dart';
import 'package:flutter_works1/screens/farms/Schedules.dart';
import 'package:flutter_works1/screens/farms/farmsPage.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:Colors.lightBlue);


 List<Widget> _widgetOptions = <Widget>[
   FarmersPage(),
 
    SchedulePage(),
    ProfileUI2(),
  ];


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      
      body:_widgetOptions.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.agriculture_rounded,color: Colors.lightBlue),
          label: 'Farmers',
        ),
       
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today,color: Colors.lightBlue),
          label: 'Schedules',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,color: Colors.lightBlue),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: _onItemTapped,
    ),
    );
  }
}
