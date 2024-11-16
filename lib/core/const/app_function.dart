
import 'package:encrypt/encrypt.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppFunctions {
  Future<bool> checkConnection() async {
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }
}