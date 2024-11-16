import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> onSetUser({required String data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', data);
  }

  Future<String> onGetUser() async {
    String data = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString('user') ?? '';
    return data;
  }
}