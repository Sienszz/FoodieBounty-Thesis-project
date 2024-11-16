

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/dashboard_buyer_controller.dart';
import 'package:projek_skripsi/authorization/modules/register/buyer_register/controllers/buyer_attacment_controller.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/providers/local_storage.dart';
import 'package:projek_skripsi/utils/routes.dart';

class EditAccountController extends GetxController {
  var formKey = GlobalKey<FormState>();
  
  var fieldName = TextEditingController();
  var fieldEmail = TextEditingController();
  var fieldPassword = TextEditingController();
  var fieldConfirmPassword = TextEditingController();
  var fieldPhoneNumber = TextEditingController();

  var attController = Get.put(BuyerAttachmentController());
  var dashboardController = Get.find<DashboardBuyerController>();

  @override
  void onInit() async {
    onInitForm();
    super.onInit();
  }
  void onInitForm() {
    var user = dashboardController.user.value;
    fieldName.text = user.name!;
    fieldEmail.text = user.email!;
    fieldPhoneNumber.text = user.phoneNumber!;
    attController.imgUrl.value = user.imgUrl!;
    print("attController url: ${attController.imgUrl.value}");
    print("attController path: ${attController.imgPath.value}");
  }

  void onSave() async {
    if(formKey.currentState!.validate() && 
        ((attController.imgUrl.value == '' && attController.imgPath.value != '') 
          || attController.imgUrl.value != '')
      ){
      DialogComponent().onLoadingDismissible();

      if(attController.imgUrl.value == ''){
        await attController.uploadFileToFirebase();
        if(attController.imgUrl.value == '') {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Failed',
              middleText: 'Failed upload photo',
              textCancel:'Ok',
          );
          return;
        }
      }

      await saveToCloudFirestore();
    }
  }

  Future<void> saveToCloudFirestore() async {
    var storeId = await LocalStorage().onGetUser();
    var storeDoc = FirebaseFirestore.instance
      .collection('customers').doc(storeId);

    await storeDoc.update({
      'name': fieldName.text,
      // 'email': fieldEmail.text,
      'phone_number': fieldPhoneNumber.text,
      'img_url': attController.imgUrl.value,
    })
        .then((value) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Berhasil',
              middleText: 'Data pengguna berhasil diperbarui',
              textConfirm:'Ok',
              onConfirm: () {
                Get.offAllNamed(AppRoutes.buyerDashboard);
              }
          );
        })
        .catchError((error) {
          Get.isDialogOpen != null && Get.isDialogOpen! ? Get.back() : null;
          Get.defaultDialog(
              title: 'Gagal',
              middleText: 'Data pengguna gagal diperbarui',
              textConfirm:'Ok',
              onConfirm: () => Get.back()
          );});
  }
}