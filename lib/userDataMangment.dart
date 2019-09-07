import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
class SharedPreferencesTest {

   Future<List<String>> getOrganization() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'org';
    List<String> value = prefs.getStringList(key);
    return value;
  }
  setOrganization(List<String> value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'org';

    prefs.setStringList(key, value);
  }

  Future<String> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'token';
    String value = prefs.getString(key);
    return value;
  }
  setToken(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'token';

    prefs.setString(key, value);
  }
  Future<bool> getlogincheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'logincheck';
    bool value = prefs.getBool(key);
    return value;
  }

  setlogincheck(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final key = 'logincheck';

    prefs.setBool(key, value);
    print('saved $value');
    prefs.setBool("logincheck", value);
  }
}