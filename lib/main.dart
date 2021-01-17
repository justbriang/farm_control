import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_works1/screens/auth.dart';
import 'package:flutter_works1/screens/landingpage.dart';
import 'package:flutter_works1/screens/sharedPref.dart';
import 'package:flutter_works1/screens/welcomePage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool authstatus=false;
    //   void _authcheck() async {

    //   SharedPrefs _prefs = new SharedPrefs();
    //   authstatus = await _prefs.checkauth();

    // }

    return MultiProvider(
        providers: [
          Provider<Auth>(
            create: (_) => Auth(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<Auth>().authStateChanges,
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // routes: {
          //   Login.name: (context) => Login(),
          //   welcome.name:(context)=>WelcomePage()
          // },
          title: 'Fuga',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthCheck(),
        ));
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();

    if (firebaseuser != null)
     return LandingPage();
    else
     return WelcomePage();
  }
}
