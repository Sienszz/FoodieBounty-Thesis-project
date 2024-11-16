import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/voucher/controllers/voucher_buyer_controller.dart';
import 'package:projek_skripsi/application/buyer/voucher/views/screen/voucher_buyer_body.dart';
import 'package:projek_skripsi/core/components/search_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class VoucherBuyerPage extends StatelessWidget {
  const VoucherBuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(VoucherBuyerController());
    controller.wordTextField.value = '';
    controller.lsFilter = controller.lsMergeCompleteVoucher;
    controller.lsFilterFinalStore.value = controller.lsFilter;
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar:  AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.white
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppThemes.blue,
        title:  Text("Daftar Voucer",
          style: AppThemes().text3Bold(color: AppThemes.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchingBar(
              voucherController: controller,
            ),
            VoucherBuyerBody(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}