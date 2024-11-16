import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projek_skripsi/core/const/app_function.dart';

class SellerAttachmentController extends GetxController {
  var isUpload = false.obs;
  var errorMsg = ''.obs;
  var imgUrl = ''.obs;
  var imgPath = ''.obs;

  late File selectedFile;
  final storageRef = FirebaseStorage.instance.ref()
      .child('store').child('profile_account');

  void getPhotoFromCamera() async {
    XFile? img = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear
    );
    if(img == null){
      Get.back();
    } else {
      Get.back();
      imgUrl.value = '';
      selectedFile = File(img.path);
      imgPath.value = selectedFile.path;
    }
  }

  void getPhotoFromGalery() async {
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    Get.back();
    imgUrl.value = '';
    selectedFile = File(img!.path);
    imgPath.value = selectedFile.path;
  }

  Future<void> uploadFileToFirebase() async {
    String fileName = "${DateTime.now().toIso8601String()}.jpg";
    if(!await AppFunctions().checkConnection()){
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Koneksi Internet terputus',
        textCancel: 'Ok'
      );
      return;
    }
    try {
      isUpload(true);
      var imgRef = storageRef.child(fileName);
      var compressedFile = await testCompressAndGetFile(selectedFile, fileName);
      await imgRef.putFile(compressedFile);
      imgUrl.value = await imgRef.getDownloadURL();
      isUpload(false);
    } catch (e) {
      errorMsg.value = 'Foto gagal diunggah';
      isUpload(false);
      log(e.toString());
    }
  }
  Future<File> testCompressAndGetFile(File file, String filename) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.path,
      quality: 16,
    );
    return uint8ListToFile(result!, filename);
  }
  File uint8ListToFile(Uint8List bytes, String fileName) {
    // Create a temporary directory
    Directory tempDir = Directory.systemTemp;

    // Create a temporary file
    File tempFile = File('${tempDir.path}/$fileName');

    // Write the bytes to the temporary file
    tempFile.writeAsBytesSync(bytes);

    return tempFile;
  }
}