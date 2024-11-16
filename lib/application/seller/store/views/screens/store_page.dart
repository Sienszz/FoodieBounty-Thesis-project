import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/store/controllers/store_seller_controller.dart';
import 'package:projek_skripsi/application/seller/store/views/screens/store_page_body.dart';
import 'package:projek_skripsi/application/seller/store/views/screens/store_page_header.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StoreSellerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Obx(() => controller.isLoading.isTrue ?  
        const Center(
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 5.0,
          ),
        ) :
        Stack(
          children: [
            Container(
              color: AppThemes.blue,
              height: Get.size.height * .4,
              child: const StorePageHeader(),
            ),
            Container(
                margin: EdgeInsets.only(top: Get.size.height * .35),
                child: const StorePageBody())
          ],
        )
      )
    );
  }
}
