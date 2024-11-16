import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/controllers/buyer_attacment_controller.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterBuyerController extends GetxController {
  var formkey = GlobalKey<FormState>();

  var isHiddenPassword = true.obs;

  var fieldName = TextEditingController();
  var fieldEmail = TextEditingController();
  var fieldPassword = TextEditingController();
  var fieldConfirmPassword = TextEditingController();
  var fieldPhoneNumber = TextEditingController();
  var attController = Get.put(BuyerAttachmentController());

  void register() async {
    if(attController.imgPath.value == ''){
      attController.errorMsg.value = 'Foto Profile dibutuhkan';
    }
    if(formkey.currentState!.validate()){
      DialogComponent().onLoadingDismissible();
      await attController.uploadFileToFirebase();
      if(attController.imgUrl.value == '') {
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
        Get.defaultDialog(
          title: 'Gagal',
          middleText: 'Foto gagal diunggah',
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
            title: 'Peringatan',
            middleText: 'Email telah digunakan.',
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
    CollectionReference stores = FirebaseFirestore.instance.collection('customers');

    stores.add({
      'name': fieldName.text,
      'email': fieldEmail.text.toLowerCase(),
      'phone_number': fieldPhoneNumber.text,
      'img_url': attController.imgUrl.value,
      'reset_date': Timestamp.fromDate(DateTime.now())
    })
        .then((value) {
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
        Get.defaultDialog(
            title: 'Berhasil',
            middleText: 'Data pengguna berhasil disimpan' 
            'Silakan periksa email untuk verifikasi',
            textConfirm:'Ok',
            onConfirm: () => Get.until((route) =>
            Get.currentRoute == AppRoutes.buyerlogin)
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
}