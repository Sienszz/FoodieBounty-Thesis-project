
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/authorization/modules/register/seller_register/controllers/seller_attachment_controller.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/components/map/controllers/maps_controller.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterSellerController extends GetxController {
  var formkey = GlobalKey<FormState>();

  var isHiddenPassword = true.obs;
  var errorMsg = ''.obs;
  var countTag = 0.obs;

  var fieldName = TextEditingController();
  var fieldEmail = TextEditingController();
  var fieldPassword = TextEditingController();
  var fieldConfirmPassword = TextEditingController();
  var fieldPhoneNumber = TextEditingController();
  var fieldAddress = TextEditingController();
  var fieldTag = TextEditingController();

  var mapController = Get.put(MapsController());
  var attController = Get.put(SellerAttachmentController());

  var lsTag = List<dynamic>.empty(growable: true).obs;

  @override
  void onInit() {
    initTag();
    super.onInit();
  }

  void initTag(){
    var temp = ['Minuman', 'Kopi', 'Cepat Saji', 'Daging', 'Mie',
      'Kacang', 'Kue', 'Nasi', 'Makanan Laut', 'Ceminal', 'Manis', 'Sayuran'];
    for(var e in temp) {
      lsTag.add({
        'isClick': false,
        'name': e
      });
    }
  }

  void register() async {
    errorMsg.value = '';
    if(!isTagValidate()) {
      errorMsg.value = 'Label wajib diisi minimal satu';
    }
    if(attController.imgPath.value == ''){
      attController.errorMsg.value = 'Foto toko wajib diisi';
    }
    if(formkey.currentState!.validate() && errorMsg.value == ''){
      DialogComponent().onLoadingDismissible();
      await attController.uploadFileToFirebase();
      if(attController.imgUrl.value == '') {
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
        Get.defaultDialog(
            title: 'Gagal',
            middleText: 'Gagal mengunggah foto',
            textCancel:'Ok',
        );
        return;
      }
      if(await authentication()) {
        await saveToCloudFirestore();
      }
    }
  }
  
  Future<bool> authentication() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: fieldEmail.text.toLowerCase(),
            password: fieldPassword.text
      );
      await userCredential.user!.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;       
        Get.defaultDialog(
            title: 'Peringatan',
            middleText: 'Kata sandi terlalu lemah',
            textConfirm:'Ok',
            onConfirm: () => Get.back()
        );
      } else if (e.code == 'email-already-in-use') {
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
        Get.defaultDialog(
            title: 'Warning',
            middleText: 'Email telah digunakan',
            textConfirm:'Ok',
            onConfirm: () => Get.back()
        );
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> saveToCloudFirestore() async {
    CollectionReference stores = FirebaseFirestore.instance.collection('stores');

    await stores.add({
      'name': fieldName.text,
      'email': fieldEmail.text.toLowerCase(),
      'phone_number': fieldPhoneNumber.text,
      'address': fieldAddress.text,
      'img_url': attController.imgUrl.value,
      'tag': getTag(),
      'latitude': mapController.latitude.value.toString(),
      'longitude': mapController.longitude.value.toString(),
    })
        .then((value) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Berhasil',
              middleText: 'Data pengguna berhasil disimpan. '
                  'Silahkan periksa email untuk verifikasi',
              textConfirm:'Ok',
              onConfirm: () => Get.until((route) =>
                Get.currentRoute == AppRoutes.sellerlogin)
          );})
        .catchError((error) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Gagal',
              middleText: 'Data pengguna gagal disimpan',
              textConfirm:'Ok',
              onConfirm: () => Get.back()
          );});
  }

  void onGetAddress(){
    fieldAddress.text = mapController.address.value;
  }

   bool isTagValidate(){
    var check = lsTag.firstWhereOrNull((element) => element['isClick'] == true);
    return check == null ? false : true;
  }

  List getTag(){
    var temp = [];
    for(var e in lsTag){
      if(e['isClick']) {
        temp.add(e['name']);
      }
    }
    return temp;
  }
}