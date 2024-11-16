import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/providers/cloud_messaging.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class LoginSellerController extends GetxController {
  var formkeyLogin = GlobalKey<FormState>();
  var formkeyResetPassword = GlobalKey<FormState>();

  var isHiddenPassword = true.obs;
  var errorMsg = ''.obs;

  var fieldEmail = TextEditingController();
  var fieldPassword = TextEditingController();

  void login() async {
    errorMsg.value = '';
    if(formkeyLogin.currentState!.validate()){
      try {
        DialogComponent().onLoadingDismissible();
        if(!await isEmailSeller()) return;
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: fieldEmail.text.toLowerCase(),
              password: fieldPassword.text
        );
        if(userCredential.user!.emailVerified){
          await LocalStorage().onSetUser(data: await onGetDocId());
          await FirebaseMessagingAPI.getDeviceTokenToSendNotification();
          await onUpdateToken();
          if(await LocalStorage().onGetUser() != ''){
            Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
            Get.offNamed(AppRoutes.sellerdashboard);
          }
        } else {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Peringatan',
              middleText: 'Akun memerlukan verifikasi via Email',
              textConfirm:'Ok',
              onConfirm: () async {
                await userCredential.user!.sendEmailVerification();
                Get.back();
              },
              textCancel: 'Batal',
          );
          errorMsg.value = 'Akun memerlukan verifikasi via Email';
        }
      } on FirebaseAuthException catch (e) {
        Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
        log(e.code);
        if (e.code == 'user-not-found') {
          errorMsg.value = 'Email tidak ditemukan';
        } else if (e.code == 'wrong-password') {
          errorMsg.value = 'Kata sandi salah';
        } else {
          errorMsg.value = 'Email atau Kata sandi salah';
        }
      }
    }
  }

  void resetPassword() async {
    if(formkeyResetPassword.currentState!.validate()){
      await FirebaseAuth.instance.sendPasswordResetEmail(email: fieldEmail.text.toLowerCase())
        .then((value) {
          Get.defaultDialog(
              title: 'Berhasil',
              middleText: 'Silakan periksa email untuk mengatur ulang kata sandi',
              textConfirm:'Ok',
              onConfirm: () {
                Get.back(); Get.back();
              }
          );
        })
        .catchError((onError) {
          log(onError.toString());
        });
    }
  }

  Future<String> onGetDocId() async {
    var data = '';
    try {
      CollectionReference storeCollection =
        FirebaseFirestore.instance.collection('stores');
      var datas = await storeCollection
        .where('email', isEqualTo: fieldEmail.text.toLowerCase()).limit(1).get();
      data = datas.docs[0].id;
    } catch(e) {}
    return data;  
  }

  Future<void> onUpdateToken() async {
    var storeId = await LocalStorage().onGetUser();
    var storeDoc = FirebaseFirestore.instance
      .collection('stores').doc(storeId);
    
    await storeDoc.update({
      'token': FirebaseMessagingAPI.fcmToken
    });
  }

  Future<bool> isEmailSeller() async {
    var storeCollection = await FirebaseFirestore.instance
        .collection('stores')
        .where('email'.toLowerCase(), isEqualTo: fieldEmail.text.toLowerCase())
        .get();

    if(storeCollection.docs.isEmpty){
      errorMsg.value = 'Email tidak terdaftar pada akun penjual';
      Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
      return false;
    }
    return true;
  }
}