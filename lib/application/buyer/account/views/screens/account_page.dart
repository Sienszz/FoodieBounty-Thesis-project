import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/account/controllers/account_controller.dart';
import 'package:projek_skripsi/application/buyer/account/views/screens/account_best_info.dart';
import 'package:projek_skripsi/application/buyer/account/views/screens/account_page_body.dart';
import 'package:projek_skripsi/application/buyer/account/views/screens/acount_page_header.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BuyerAccountController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Obx(() => controller.isLoading.isTrue ?  
        const Center(
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 5.0,
          ),
        ) :
        RefreshIndicator(
          onRefresh: () => controller.onRefresh(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  color: AppThemes.blue,
                  height: Get.size.height * .4,
                  child: const AccountPageHeader(),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: Get.size.height * .35),
                  child: const AccountBestInfo(),
                ),
                Container(
                  margin: EdgeInsets.only(top: Get.size.height * .45),
                  child: const AccountPageBody(),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}