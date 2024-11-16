import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> saveQR(Uint8List bytes) async{
  await [Permission.storage].request();
  final time = DateTime.now();
  final filename = 'screenshot_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: filename);
  return result['filePath'];
}