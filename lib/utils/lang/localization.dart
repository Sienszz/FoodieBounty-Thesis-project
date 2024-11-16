import 'package:get/get.dart';
import 'package:projek_skripsi/utils/lang/en.dart';
import 'package:projek_skripsi/utils/lang/id.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': En().messages,
    'id_ID': Id().messages
  };
}