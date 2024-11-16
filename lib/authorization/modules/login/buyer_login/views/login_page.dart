import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/views/login_page_body.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/views/login_page_footer.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/views/login_page_header.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/controllers/login_buyer_controller.dart';

class BuyerLoginPage extends StatelessWidget {
  const BuyerLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginBuyerController());
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
