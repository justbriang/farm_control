import 'package:email_validator/email_validator.dart';

class ValidatorClass {
  final RegExp nameRegExp = RegExp('[a-zA-Z]');
  final RegExp passRegEcp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final RegExp telregExp =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

  checker(String label, var value) {
    switch (label) {
      case 'Username':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else if (value.length < 5) {
          return 'Name is to short';
        } else {
          return (nameRegExp.hasMatch(value)) ? null : 'Enter a valid name';
        }
        break;
      case 'Telephone':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else {
          return (telregExp.hasMatch(value))
              ? null
              : 'Enter a valid Phone Number';
        }
        break;
      case 'Email Address':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else {
          return EmailValidator.validate(value) ? null : 'Enter a valid email';
        }
        break;
      case 'Password':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else if (value.length < 8) {
          return 'Password is too short';
        } else {
          return (passRegEcp.hasMatch(value))
              ? null
              : 'Password is too weak. Should include uppercase, numbers and special chars.';
        }
        break;
      case 'Institution Name':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else if (value.length < 5) {
          return 'Institution name is too short';
        } else {
          return (nameRegExp.hasMatch(value))
              ? null
              : 'Enter a valid Institution name';
        }
        break;
      case 'Referee Name':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else if (value.length < 5) {
          return 'Referee Name is too short';
        } else {
          return (nameRegExp.hasMatch(value))
              ? null
              : 'Enter a valid Referee name';
        }
        break;
    }
  }
}
