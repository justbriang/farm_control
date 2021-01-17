import 'package:flutter/material.dart';
import 'package:flutter_works1/screens/FarmersPage.dart';

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
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Agriculture',
      style: optionStyle,
    ),
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
          icon: Icon(Icons.explore,color: Colors.lightBlue),
          label: 'Farmers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.update,color: Colors.lightBlue),
          label: 'Farms',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,color: Colors.lightBlue),
          label: 'School',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.agriculture,color: Colors.lightBlue),
          label: 'Agriculture',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: _onItemTapped,
    ),
    );
  }
}
