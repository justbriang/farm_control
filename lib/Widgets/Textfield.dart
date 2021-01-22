import 'package:flutter/material.dart';
import 'package:flutter_works1/screens/Auth/validator.dart';


Widget entryField(String title, TextEditingController tcontroller,
    {bool isPassword = false}) {
  ValidatorClass validate = new ValidatorClass();
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            // keyboardType: TextInputType.phone,
            validator: (value) => validate.checker(title, value),
            obscureText: isPassword,
            controller: tcontroller,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}

Widget editextfield(
    String title, String textContent,icon, TextEditingController tcontroller,
    {bool isPassword = false}) {
  ValidatorClass validate = new ValidatorClass();
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueAccent),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            validator: (value) {
              if (value == '') {
            
                value = textContent;
              }
              print('value is ${value??textContent}');
              return validate.checker(title, value);
            },
            obscureText: isPassword,
            controller: tcontroller,
            
            decoration: InputDecoration(
               icon:Icon(icon,color: Colors.blue,),
                labelText: textContent,
                labelStyle:TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueAccent),
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}
