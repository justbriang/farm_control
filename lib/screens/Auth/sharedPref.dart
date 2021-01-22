import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  void signedin(bool _signedin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('signedin', _signedin);
  }

  // Future<bool> clearAuthDetails() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.clear();
  // }
  Future<bool> checkauth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool authstatus = preferences.getBool('signedin');
    return authstatus;
  }
}
