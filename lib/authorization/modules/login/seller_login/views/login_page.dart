import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/authorization/modules/login/seller_login/controllers/login_seller_controller.dart';
import 'package:projek_skripsi/authorization/modules/login/seller_login/views/login_page_body.dart';
import 'package:projek_skripsi/authorization/modules/login/seller_login/views/login_page_footer.dart';
import 'package:projek_skripsi/authorization/modules/login/seller_login/views/login_page_header.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class SellerLoginPage extends StatelessWidget {
  const SellerLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginSellerController());
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.size.width,
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginPageHeader(),
                    SizedBox(height: AppThemes().veryExtraSpacing),
                    const LoginPageBody(),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: Get.size.height * .1,
                child: const LoginPageFooter(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.until((route) => Get.currentRoute == AppRoutes.onBoarding),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: const Icon(Icons.arrow_back, color: AppThemes.blue,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
