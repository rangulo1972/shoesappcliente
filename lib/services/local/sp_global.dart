import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {
  //**---- inicio de Singleton */
  static final SPGlobal _instance = SPGlobal._();
  SPGlobal._();

  factory SPGlobal() {
    return _instance;
  }
  //**------ fin de Singleton  */

  late SharedPreferences prefs;

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  //**---------------------------------------------- */
  set name(String value) {
    prefs.setString("name", value);
  }

  set mail(String value) {
    prefs.setString("mail", value);
  }

  set phone(String value) {
    prefs.setString("phone", value);
  }

  set isLogin(bool value) {
    prefs.setBool("isLogin", value);
  }

  //**-------------------------------------- */

  String get name => prefs.getString("name") ?? "";
  String get mail => prefs.getString("mail") ?? "";
  String get phone => prefs.getString("phone") ?? "";
  bool get isLogin => prefs.getBool("isLogin") ?? false;
}
