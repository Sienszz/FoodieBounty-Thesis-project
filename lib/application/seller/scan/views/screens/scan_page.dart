import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/scan/controllers/scan_seller_controller.dart';
import 'package:projek_skripsi/application/seller/scan/views/screens/scan_page_body.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class SellerScanPage extends StatelessWidget {
  const SellerScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ScanSellerController(Get.arguments));
    return Scaffold(
        backgroundColor: AppThemes.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppThemes.white
          ),
          centerTitle: true,
          backgroundColor: AppThemes.blue,
          title: Text('Pindai QR',
              style: AppThemes().text3Bold(color: AppThemes.white)),
        ),
        body: Obx(() => controller.isLoading.isTrue ? 
          SizedBox(
            width: Get.size.width,
            height: Get.size.width,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppThemes.blue,
                strokeWidth: 5.0,
              ),
            )
          ) : const ScanPageBody()),
    );
  }
}
